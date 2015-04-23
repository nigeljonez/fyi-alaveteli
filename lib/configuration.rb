# Configuration values with defaults
# TODO: Make this return different values depending on the current rails environment

module AlaveteliConfiguration
  mattr_accessor :config

  if !const_defined?(:DEFAULTS)

    DEFAULTS = {
      :ADMIN_PASSWORD => '',
      :ADMIN_USERNAME => '',
      :ALLOW_BATCH_REQUESTS => false,
      :AUTHORITY_MUST_RESPOND => true,
      :AVAILABLE_LOCALES => '',
      :BLACKHOLE_PREFIX => 'do-not-reply-to-this-address',
      :BLOG_FEED => '',
      :CACHE_FRAGMENTS => true,
      :CONTACT_EMAIL => 'contact@localhost',
      :CONTACT_NAME => 'Alaveteli',
      :COOKIE_STORE_SESSION_SECRET => 'this default is insecure as code is open source, please override for live sites in config/general; this will do for local development',
      :DEBUG_RECORD_MEMORY => false,
      :DEFAULT_LOCALE => '',
      :DISABLE_EMERGENCY_USER => false,
      :DOMAIN => 'localhost:3000',
      :DONATION_URL => '',
      :EXCEPTION_NOTIFICATIONS_FROM => '',
      :EXCEPTION_NOTIFICATIONS_TO => '',
      :FORCE_REGISTRATION_ON_NEW_REQUEST => false,
      :FORCE_SSL => true,
      :FORWARD_NONBOUNCE_RESPONSES_TO => 'user-support@localhost',
      :FRONTPAGE_PUBLICBODY_EXAMPLES => '',
      :GA_CODE => '',
      :GAZE_URL => '',
      :HTML_TO_PDF_COMMAND => '',
      :INCLUDE_DEFAULT_LOCALE_IN_URLS => true,
      :INCOMING_EMAIL_DOMAIN => 'localhost',
      :INCOMING_EMAIL_PREFIX => 'foi+',
      :INCOMING_EMAIL_SECRET => 'dummysecret',
      :ISO_COUNTRY_CODE => 'GB',
      :MINIMUM_REQUESTS_FOR_STATISTICS => 100,
      :MAX_REQUESTS_PER_USER_PER_DAY => 6,
      :MTA_LOG_PATH => '/var/log/exim4/exim-mainlog-*',
      :MTA_LOG_TYPE => 'exim',
      :NEW_RESPONSE_REMINDER_AFTER_DAYS => [3, 10, 24],
      :OVERRIDE_ALL_PUBLIC_BODY_REQUEST_EMAILS => '',
      :PUBLIC_BODY_STATISTICS_PAGE => false,
      :PUBLIC_BODY_LIST_FALLBACK_TO_DEFAULT_LOCALE => false,
      :RAW_EMAILS_LOCATION => 'files/raw_emails',
      :READ_ONLY => '',
      :RECAPTCHA_PRIVATE_KEY => 'x',
      :RECAPTCHA_PUBLIC_KEY => 'x',
      :REPLY_LATE_AFTER_DAYS => 20,
      :REPLY_VERY_LATE_AFTER_DAYS => 40,
      :RESPONSIVE_STYLING => true,
      :SITE_NAME => 'Alaveteli',
      :SKIP_ADMIN_AUTH => false,
      :SPECIAL_REPLY_VERY_LATE_AFTER_DAYS => 60,
      :THEME_BRANCH => false,
      :THEME_URL => "",
      :THEME_URLS => [],
      :TIME_ZONE => "UTC",
      :TRACK_SENDER_EMAIL => 'contact@localhost',
      :TRACK_SENDER_NAME => 'Alaveteli',
      :TWITTER_USERNAME => '',
      :TWITTER_WIDGET_ID => false,
      :USE_DEFAULT_BROWSER_LANGUAGE => true,
      :USE_GHOSTSCRIPT_COMPRESSION => false,
      :USE_MAILCATCHER_IN_DEVELOPMENT => true,
      :UTILITY_SEARCH_PATH => ["/usr/bin", "/usr/local/bin"],
      :VARNISH_HOST => '',
      :WORKING_OR_CALENDAR_DAYS => 'working',
      :PRODUCTION_MAILER_DELIVERY_METHOD => 'sendmail',
      :MAILER_ADDRESS => '',
      :MAILER_PORT => 587,
      :MAILER_DOMAIN => '',
      :MAILER_USER_NAME =>  '',
      :MAILER_PASSWORD => '',
      :MAILER_AUTHENTICATION => 'plain',
      :MAILER_ENABLE_STARTTLS_AUTO => true
    }
  end

  def self.method_missing(name)
    self.config ||= YAML.load(ERB.new(File.read(Rails.root.join 'config', 'general.yml')).result)
    key = name.to_s.upcase
    return super unless DEFAULTS.has_key?(key.to_sym)
    config.fetch(key, DEFAULTS[key.to_sym])
  end
end

