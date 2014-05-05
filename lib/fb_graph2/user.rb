module FbGraph2
  class User < Node
    include AttributeAssigner

    include Edge::Accounts
    include Edge::Friends
    include Edge::Feed

    register_attributes(
      raw: [
        :about, :bio, :email, :first_name, :gender, :installed, :is_verified, :link, :locale,
        :middle_name, :name, :name_format, :political, :quotes, :relationship_status, :religion,
        :timezone, :third_party_id, :verified, :website
      ],
      time: [:updated_time], # NOTE: undocumented attribute
      date: [:birthday],
      page: [:hometown, :location],
      pages: [:favorite_athletes, :favorite_teams, :inspirational_people, :languages],
      user: [:significant_other],
      custom: [:age_range, :context, :cover, :currency, :education, :work]
    )

    def initialize(id, attributes = {})
      super
      assign attributes
      # TODO: handle custom attributes.
    end

    def self.me(access_token)
      new(:me).authenticate access_token
    end
  end
end