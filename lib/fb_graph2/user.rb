module FbGraph2
  class User < Node
    include Edge::Friends

    self.registered_attributes = {
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
    attr_accessor *registered_attributes.values.flatten

    def initialize(id, attributes = {})
      super
      assign attributes
    end

    def self.me(access_token)
      new(:me).authenticate access_token
    end
  end
end