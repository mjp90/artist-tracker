class SongkickApi

  RESULTS_PER_PAGE = 50

  def self.get_upcoming_concerts(songkick_account)
    results = self.request_results_for_account(songkick_account)

    upcoming_concerts = []
    total_concerts    = results["totalEntries"]
    page              = results["page"].to_i
    events            = results["results"]["event"]

    events.each do |event|
      event_info = self.extract_event_info(event)
      upcoming_concerts << event_info
    end

    # Only handles a second page for now. Don't know if we'll need more
    if total_concerts > page * RESULTS_PER_PAGE
      results = self.request_results_for_account(songkick_account, page + 1)
      page              = results["page"].to_i
      events            = results["results"]["event"]

      events.each do |event|
        event_info = self.extract_event_info(event)
        upcoming_concerts << event_info
      end
    end

    songkick_account.update_attributes(:total_concerts => total_concerts)
    upcoming_concerts
  end

  def self.extract_event_info(event)
    start_date = event['start']['datetime'] ? DateTime.strptime(event['start']['datetime']) : start_date = Time.zone.parse(event['start']['date'])
    city, state, country = event['location']['city'].split(', ')
    state, country = country, state if country.nil? # If Intl. the state field holds country

    event_info = {
      :age_restriction => event['ageRestriction'],
      :city            => city,
      :country         => country,
      :event_name      => event['displayName'],
      :songkick_id     => event['id'],
      :start_date      => start_date,
      :state           => state,
      :url             => event['uri']
    }

    venue = event['venue']
    venue_info = {
      :lat => venue['lat'],
      :long => venue['lng'],
    }

    event_info.merge!(venue_info)
  end

  def self.request_results_for_account(songkick_account, page=1)
    calendar_get_url = self.calendar_url_for_artist_id(songkick_account.songkick_id, page)
    results = JSON.parse(RestClient.get(calendar_get_url, nil))["resultsPage"]
  end

  def self.calendar_url_for_artist_id(songkick_id, page=1)
    "http://api.songkick.com/api/3.0/artists/#{songkick_id}/calendar.json?apikey=#{SONGKICK_API_KEY}"
  end

end