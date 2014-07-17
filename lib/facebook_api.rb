## Notes About The API ##
# Up To 50 Concurrent Requests At Once
# Gets Return Limit of 25

class FacebookApi

  def self.client
    if @client
      @client
    else
      oauth = Koala::Facebook::OAuth.new(FACEBOOK_API_KEY, FACEBOOK_API_SECRET, nil)
      access_token = oauth.get_app_access_token
      ArtistTrackerKey.first.update_column(:facebook_access_token, access_token)
      @client = Koala::Facebook::API.new(access_token)
    end
  end

  def self.get_account_info_for_owner(owner)
    username = owner.facebook_url
    username.slice!(/.*com\//)

    response     = client.get_object(username)
    account_info = self.extract_account_info(response)
  end

  def self.get_posts_for_account(account)
    page_one_url      = get_posts_url(account)
    response          = client.api(page_one_url)
    page_one_response = response['posts']
    page_two_url      = page_one_response['paging']['next'].slice(/\/\d{5,}.*/)
    page_two_response = client.api(page_two_url)
    combined_response = page_one_response['data'] + page_two_response['data']

    posts = []
    combined_response.each do |post|
      posts.prepend(self.extract_post_info(post))
    end

    posts
  end


  # Comment on a Post: https://developers.facebook.com/docs/graph-api/reference/v2.0/comment
  # Like a Post: https://developers.facebook.com/docs/graph-api/reference/v2.0/post
  # Like Page: DONT THINK THIS ALLOWED:
  # "https://developers.facebook.com/plugins/code?path=like-box&href=https%3A%2F%2Fwww.facebook.com%2FFacebookDevelopers&width&height&show_faces=true&header=true&stream=false&show_border=true&colorscheme=light"


  def self.extract_account_info(response)
    banner = response['cover']
    {
      :about_info       => response['about'],
      :banner_image_url => (banner['source'] if banner),
      :bio              => response['bio'],
      :facebook_id      => response['id'],
      :genre            => response['genre'],
      :hometown         => response['hometown'],
      :likes_count      => response['likes']
    }
  end

  def self.extract_post_info(post)
    comments = post['comments']
    likes    = post['likes']
    shares   = post['shares']
    begin
      {
        :comments_count => (comments['summary']['total_count'] if comments),
        :facebook_id    => post['id'],
        :likes_count    => (likes['summary']['total_count'] if likes),
        :message        => post['message'],
        :posted_at      => post['created_at'],
        :shares_count   => (shares['count'] if shares)
      }
    rescue NoMethodError
      nil
    end
  end

  def self.get_posts_url(account)
    "/#{account.facebook_id}?fields=posts.fields(message, picture, shares, likes.limit(1).summary(true), comments.limit(1).summary(true))"
  end

end