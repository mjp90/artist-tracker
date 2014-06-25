class SongkickAccount < ActiveRecord::Base
  has_many   :concerts
  belongs_to :user
  belongs_to :account

  def self.create_account_for(user)
    account = self.new
    

    if user.is_a?(Artist)
    
  end

  def update_events(options={})
    url = self.calendar_url(options)
    response = JSON.parse(RestClient.get(url, nil))["resultsPage"]
    total_events = response["totalEntries"]
    page = response["page"]
    events = response["results"]["event"]

    events.each do |event|
      {
        :songkick_id     => event['id'],
        :type            => event['type'], # => Do we need to keep track of this? 
        :popularity      => event['popularity'],
        :display_name    => event['displayName'],
        :start_datetime  => event['start']['datetime'],
        :age_restriction => event['ageRestriction'],
        :city            => event['location']['city'],
        :uri             => event['uri'],
        :age_restriction  => event['ageRestriction']
      }

      performances = event['performance']
      performances.each do |performance|
        {
          :artist_name => performance['displayName'],
          :billing_type => performance['billing']
        } 
      end

      # We have access to the venue info from event['venue'] but don't know if we need
      venue = event['venue']
      {
        :country => venue['metroArea']['country']['displayName'],
        :state => venue['metroArea']['state']['displayName'],
        :venue_name => venue['displayName']
      }

      location = event['location']
      {
        :city => location['city'] # => "Rothbury, MI, US" 
      }

    end

  end

  def calendar_url(options={})
    "http://api.songkick.com/api/3.0/artists/#{self.artist_id}/calendar.json?apikey=#{SONGKICK_API_KEY}"
  end
end
