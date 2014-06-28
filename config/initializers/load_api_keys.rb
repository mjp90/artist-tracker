API_KEYS = YAML.load_file(Rails.root.join('config', 'api_keys.yml'))

# Twitter API Keys
TWITTER_API_KEY    = API_KEYS['twitter']['api_key']
TWITTER_API_SECRET = API_KEYS['twitter']['api_secret']

# Facebook API Keys


#Souncloud API Keys
SOUNDCLOUD_API_KEY = API_KEYS['soundcloud']['api_key']

#Songkick API Keys
SONGKICK_API_KEY = API_KEYS['songkick']['api_key']