module FbGraph2
  class User < Node
    @@attributes = {
      raw: [
        :about, :bio, :email, :first_name, :gender, :installed, :is_verified, :link, :locale,
        :middle_name, :name, :name_format, :political, :quotes, :relationship_status, :religion,
        :timezone, :third_party_id, :verified, :website
      ],
      time: [:updated_time], # NOTE: undocumented attribute
      date: [:birthday],
      custom: [
        :age_range, :context, :cover, :currency, :education, :favorite_athletes, :favorite_teams,
        :hometown, :inspirational_people, :languages, :location, :significant_other, :work
      ]
    }
    attr_accessor *@@attributes.values.flatten

    def initialize(id, attributes = {})
      super
      @@attributes.each do |type, keys|
        keys.each do |key|
          raw = attributes[key]
          if raw.present?
            value = case type
            when :raw
              raw
            when :date
              Date.parse raw
            when :time
              Time.parse raw
            end
            self.send :"#{key}=", attributes[key]
          end
        end
      end
    end

    def self.me(access_token)
      new(:me, access_token: access_token)
    end
  end
end
