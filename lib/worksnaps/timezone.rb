# frozen_string_literal: true

module Worksnaps
  class Timezone
    TIMEZONES = [
      { api_id: 1, offset: '-12:00', activesupport_name: 'Etc/GMT-12' },
      { api_id: 2, offset: '-11:00', activesupport_name: 'Pacific/Midway' },
      { api_id: 3, offset: '-10:00', activesupport_name: 'Pacific/Honolulu' },
      { api_id: 4, offset: '-09:00', activesupport_name: 'America/Anchorage' },
      { api_id: 5, offset: '-08:00', activesupport_name: 'America/Los_Angeles' },
      { api_id: 6, offset: '-07:00', activesupport_name: 'America/Phoenix' },
      { api_id: 7, offset: '-07:00', activesupport_name: 'America/Chihuahua' },
      { api_id: 8, offset: '-07:00', activesupport_name: 'America/Denver' },
      { api_id: 9, offset: '-06:00', activesupport_name: 'America/Bahia_Banderas' },
      { api_id: 10, offset: '-06:00', activesupport_name: 'America/Chicago' },
      { api_id: 11, offset: '-06:00', activesupport_name: 'America/Mexico_City' },
      { api_id: 12, offset: '-06:00', activesupport_name: 'America/Regina' },
      { api_id: 13, offset: '-05:00', activesupport_name: 'America/Bogota' },
      { api_id: 14, offset: '-05:00', activesupport_name: 'America/New_York' },
      { api_id: 15, offset: '-05:00', activesupport_name: 'America/Indiana/Indianapolis' },
      { api_id: 16, offset: '-04:00', activesupport_name: 'America/Halifax' },
      { api_id: 17, offset: '-04:00', activesupport_name: 'America/Caracas' },
      { api_id: 18, offset: '-04:00', activesupport_name: 'America/Santiago' },
      { api_id: 19, offset: '-03:30', activesupport_name: 'America/St_Johns' },
      { api_id: 20, offset: '-03:00', activesupport_name: 'America/Sao_Paulo' },
      { api_id: 21, offset: '-03:00', activesupport_name: 'America/Argentina/Buenos_Aires' },
      { api_id: 22, offset: '-03:00', activesupport_name: 'America/Nuuk' },
      { api_id: 23, offset: '-02:00', activesupport_name: 'America/Noronha' },
      { api_id: 24, offset: '-01:00', activesupport_name: 'Atlantic/Azores' },
      { api_id: 25, offset: '-01:00', activesupport_name: 'Atlantic/Cape_Verde' },
      { api_id: 26, offset: '+0:00', activesupport_name: 'Africa/Casablanca' },
      { api_id: 27, offset: '+0:00', activesupport_name: 'Europe/Dublin' },
      { api_id: 28, offset: '+01:00', activesupport_name: 'Europe/Amsterdam' },
      { api_id: 29, offset: '+01:00', activesupport_name: 'Europe/Belgrade' },
      { api_id: 30, offset: '+01:00', activesupport_name: 'Europe/Brussels' },
      { api_id: 31, offset: '+01:00', activesupport_name: 'Europe/Sarajevo' },
      { api_id: 32, offset: '+01:00', activesupport_name: 'Africa/Algiers' },
      { api_id: 33, offset: '+02:00', activesupport_name: 'Europe/Athens' },
      { api_id: 34, offset: '+02:00', activesupport_name: 'Europe/Bucharest' },
      { api_id: 35, offset: '+02:00', activesupport_name: 'Africa/Cairo' },
      { api_id: 36, offset: '+02:00', activesupport_name: 'Africa/Harare' },
      { api_id: 37, offset: '+02:00', activesupport_name: 'Europe/Helsinki' },
      { api_id: 38, offset: '+02:00', activesupport_name: 'Asia/Jerusalem' },
      { api_id: 39, offset: '+03:00', activesupport_name: 'Asia/Baghdad' },
      { api_id: 40, offset: '+03:00', activesupport_name: 'Asia/Kuwait' },
      { api_id: 41, offset: '+03:00', activesupport_name: 'Europe/Moscow' },
      { api_id: 42, offset: '+03:00', activesupport_name: 'Africa/Nairobi' },
      { api_id: 43, offset: '+03:30', activesupport_name: 'Asia/Tehran' },
      { api_id: 44, offset: '+04:00', activesupport_name: 'Asia/Muscat' },
      { api_id: 45, offset: '+04:00', activesupport_name: 'Asia/Baku' },
      { api_id: 46, offset: '+04:30', activesupport_name: 'Asia/Kabul' },
      { api_id: 47, offset: '+05:00', activesupport_name: 'Antarctica/Mawson' },
      { api_id: 48, offset: '+05:00', activesupport_name: 'Asia/Karachi' },
      { api_id: 49, offset: '+05:30', activesupport_name: 'Asia/Kolkata' },
      { api_id: 50, offset: '+05:45', activesupport_name: 'Asia/Kathmandu' },
      { api_id: 51, offset: '+06:00', activesupport_name: 'Asia/Almaty' },
      { api_id: 52, offset: '+06:00', activesupport_name: 'Asia/Dhaka' },
      { api_id: 54, offset: '+06:30', activesupport_name: 'Asia/Kolkata' }, # Indian Standard Time
      { api_id: 54, offset: '+06:30', activesupport_name: 'Asia/Yangon' },
      { api_id: 55, offset: '+07:00', activesupport_name: 'Asia/Bangkok' },
      { api_id: 56, offset: '+07:00', activesupport_name: 'Asia/Krasnoyarsk' },
      { api_id: 57, offset: '+08:00', activesupport_name: 'Asia/Shanghai' },
      { api_id: 58, offset: '+08:00', activesupport_name: 'Asia/Irkutsk' },
      { api_id: 59, offset: '+08:00', activesupport_name: 'Asia/Kuala_Lumpur' },
      { api_id: 60, offset: '+08:00', activesupport_name: 'Australia/Perth' },
      { api_id: 61, offset: '+08:00', activesupport_name: 'Asia/Taipei' },
      { api_id: 62, offset: '+09:00', activesupport_name: 'Asia/Tokyo' },
      { api_id: 63, offset: '+09:00', activesupport_name: 'Asia/Seoul' },
      { api_id: 64, offset: '+09:00', activesupport_name: 'Asia/Yakutsk' },
      { api_id: 65, offset: '+09:30', activesupport_name: 'Australia/Adelaide' },
      { api_id: 66, offset: '+09:30', activesupport_name: 'Australia/Darwin' },
      { api_id: 67, offset: '+10:00', activesupport_name: 'Australia/Brisbane' },
      { api_id: 68, offset: '+10:00', activesupport_name: 'Australia/Sydney' },
      { api_id: 69, offset: '+10:00', activesupport_name: 'Pacific/Guam' },
      { api_id: 70, offset: '+10:00', activesupport_name: 'Australia/Hobart' },
      { api_id: 71, offset: '+10:00', activesupport_name: 'Asia/Vladivostok' },
      { api_id: 72, offset: '+11:00', activesupport_name: 'Asia/Magadan' },
      { api_id: 73, offset: '+12:00', activesupport_name: 'Pacific/Auckland' },
      { api_id: 74, offset: '+12:00', activesupport_name: 'Pacific/Fiji' },
      { api_id: 75, offset: '+13:00', activesupport_name: 'Pacific/Tongatapu' }
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
