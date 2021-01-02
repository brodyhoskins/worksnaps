# frozen_string_literal: true

module Worksnaps
  class Timezone
    TIMEZONES = [
      { api_id: 1, offset: '-12:00', activesupport_name: 'International Date Line West' },
      { api_id: 2, offset: '-11:00', activesupport_name: 'Midway Island, American Samoa' },
      { api_id: 3, offset: '-10:00', activesupport_name: 'Hawaii' },
      { api_id: 4, offset: '-09:00', activesupport_name: 'Alaska' },
      { api_id: 5, offset: '-08:00', activesupport_name: 'Pacific Time (US & Canada), Tijuana' },
      { api_id: 6, offset: '-07:00', activesupport_name: 'Arizona' },
      { api_id: 7, offset: '-07:00', activesupport_name: 'Chihuahua, La Paz, Mazatlan' },
      { api_id: 8, offset: '-07:00', activesupport_name: 'Mountain Time (US & Canada)' },
      { api_id: 9, offset: '-06:00', activesupport_name: 'Central America' },
      { api_id: 10, offset: '-06:00', activesupport_name: 'Central Time (US & Canada)' },
      { api_id: 11, offset: '-06:00', activesupport_name: 'Guadalajara, Mexico City, Monterrey' },
      { api_id: 12, offset: '-06:00', activesupport_name: 'Saskatchewan' },
      { api_id: 13, offset: '-05:00', activesupport_name: 'Bogota, Lime, Quito' },
      { api_id: 14, offset: '-05:00', activesupport_name: 'Eastern Time (US & Canada)' },
      { api_id: 15, offset: '-05:00', activesupport_name: 'Indiana (East)' },
      { api_id: 16, offset: '-04:00', activesupport_name: 'Atlantic Time (Canada)' },
      { api_id: 17, offset: '-04:00', activesupport_name: 'Caracas, La Paz' },
      { api_id: 18, offset: '-04:00', activesupport_name: 'Santiago' },
      { api_id: 19, offset: '-03:30', activesupport_name: 'Newfoundland' },
      { api_id: 20, offset: '-03:00', activesupport_name: 'Brasilia' },
      { api_id: 21, offset: '-03:00', activesupport_name: 'Buenos Aires, Georgetown' },
      { api_id: 22, offset: '-03:00', activesupport_name: 'Greenland' },
      { api_id: 23, offset: '-02:00', activesupport_name: 'Mid-Atlantic' },
      { api_id: 24, offset: '-01:00', activesupport_name: 'Azores' },
      { api_id: 25, offset: '-01:00', activesupport_name: 'Cape Verde Is.' },
      { api_id: 26, offset: '+0:00', activesupport_name: 'Casablanca, Monrovia' },
      { api_id: 27, offset: '+0:00', activesupport_name: 'Dublin, Edinburgh, Lisbon, London' },
      { api_id: 28, offset: '+01:00', activesupport_name: 'Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna' },
      { api_id: 29, offset: '+01:00', activesupport_name: 'Belgrade, Bratislava, Budapest, Ljubljana, Prague' },
      { api_id: 30, offset: '+01:00', activesupport_name: 'Brussels, Copenhagen, Madrid, Paris' },
      { api_id: 31, offset: '+01:00', activesupport_name: 'Sarajevo, Skopje, Warsaw, Zagreb' },
      { api_id: 32, offset: '+01:00', activesupport_name: 'West Central Africa' },
      { api_id: 33, offset: '+02:00', activesupport_name: 'Athens, Istanbul, Minsk' },
      { api_id: 34, offset: '+02:00', activesupport_name: 'Bucharest' },
      { api_id: 35, offset: '+02:00', activesupport_name: 'Cairo' },
      { api_id: 36, offset: '+02:00', activesupport_name: 'Harare, Pretoria' },
      { api_id: 37, offset: '+02:00', activesupport_name: 'Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius' },
      { api_id: 38, offset: '+02:00', activesupport_name: 'Jerusalem' },
      { api_id: 39, offset: '+03:00', activesupport_name: 'Baghdad' },
      { api_id: 40, offset: '+03:00', activesupport_name: 'Kuwait, Riyadh' },
      { api_id: 41, offset: '+03:00', activesupport_name: 'Moscow, St. Petersburg, Volgograd' },
      { api_id: 42, offset: '+03:00', activesupport_name: 'Nairobi' },
      { api_id: 43, offset: '+03:30', activesupport_name: 'Tehran' },
      { api_id: 44, offset: '+04:00', activesupport_name: 'Abu Dhabi, Muscat' },
      { api_id: 45, offset: '+04:00', activesupport_name: 'Baku, Tbilisi, Yerevan' },
      { api_id: 46, offset: '+04:30', activesupport_name: 'Kabul' },
      { api_id: 47, offset: '+05:00', activesupport_name: 'Ekaterinburg' },
      { api_id: 48, offset: '+05:00', activesupport_name: 'Islamabad, Karachi, Tashkent' },
      { api_id: 49, offset: '+05:30', activesupport_name: 'Chennai, Kolkata, Mumbai, New Delhi' },
      { api_id: 50, offset: '+05:45', activesupport_name: 'Kathmandu' },
      { api_id: 51, offset: '+06:00', activesupport_name: 'Almaty, Novosibirsk' },
      { api_id: 52, offset: '+06:00', activesupport_name: 'Astana, Dhaka' },
      { api_id: 53, offset: '+06:00', activesupport_name: 'Sri Jayawardenepura' },
      { api_id: 54, offset: '+06:30', activesupport_name: 'Rangoon' },
      { api_id: 55, offset: '+07:00', activesupport_name: 'Bangkok, Hanoi, Jakarta' },
      { api_id: 56, offset: '+07:00', activesupport_name: 'Krasnoyarsk' },
      { api_id: 57, offset: '+08:00', activesupport_name: 'Beijing, Chongqing, Hong Kong, Urumgi' },
      { api_id: 58, offset: '+08:00', activesupport_name: 'Irkutsk, Ulaan Bataar' },
      { api_id: 59, offset: '+08:00', activesupport_name: 'Kuala Lumpur, Singapore' },
      { api_id: 60, offset: '+08:00', activesupport_name: 'Perth' },
      { api_id: 61, offset: '+08:00', activesupport_name: 'Taipei' },
      { api_id: 62, offset: '+09:00', activesupport_name: 'Osaka, Sapporo, Tokyo' },
      { api_id: 63, offset: '+09:00', activesupport_name: 'Seoul' },
      { api_id: 64, offset: '+09:00', activesupport_name: 'Yakutsk' },
      { api_id: 65, offset: '+09:30', activesupport_name: 'Adelaide' },
      { api_id: 66, offset: '+09:30', activesupport_name: 'Darwin' },
      { api_id: 67, offset: '+10:00', activesupport_name: 'Brisbane' },
      { api_id: 68, offset: '+10:00', activesupport_name: 'Canberra, Melbourne, Sydney' },
      { api_id: 69, offset: '+10:00', activesupport_name: 'Guam, Port Moresby' },
      { api_id: 70, offset: '+10:00', activesupport_name: 'Hobart' },
      { api_id: 71, offset: '+10:00', activesupport_name: 'Vladivostok' },
      { api_id: 72, offset: '+11:00', activesupport_name: 'Magadan, Solomon Is., New Caledonia' },
      { api_id: 73, offset: '+12:00', activesupport_name: 'Auckland, Wellington' },
      { api_id: 74, offset: '+12:00', activesupport_name: 'Fiji, Kamchatka, Marshall Is.' },
      { api_id: 75, offset: '+13:00', activesupport_name: 'Nukualofa' }
    ].freeze

    attr_accessor :api_id, :dst, :offset, :activesupport_name

    def initialize(api_id, dst)
      return nil if api_id.blank?

      TIMEZONES.each do |timezone|
        next unless timezone.dig(:api_id) == api_id

        @api_id = api_id
        @activesupport_name = timezone.dig(:activesupport_name)
        @dst = dst
        @offset = timezone.dig(:offset)

        return self
      end

      nil
    end

    def to_activesupport
      @to_activesupport ||= ActiveSupport::TimeZone.new(@activesupport_name)
    end

    def to_tzinfo
      @to_tzinfo ||= to_activesupport.tzinfo
    end

    def blank?
      return true if !@api_id.blank? || @activesupport_name.blank? || !@offset.blank?

      false
    end

    def dst?
      @dst
    end
  end
end
