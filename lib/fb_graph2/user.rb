module FbGraph2
  class User < Node
    include Edge::Accounts
    include Edge::Achievements
    include Edge::Activities
    include Edge::Albums
    include Edge::AppRequests
    include Edge::Books
    include Edge::Domains
    include Edge::Events
    include Edge::Family
    include Edge::Feed
    include Edge::FriendLists
    include Edge::Friends
    include Edge::Games
    include Edge::Groups
    include Edge::Interests
    include Edge::InvitableFriends
    include Edge::Likes::LikerContext
    include Edge::Movies
    include Edge::Music
    include Edge::PaymentTransactions
    include Edge::Permissions
    include Edge::Picture
    include Edge::Photos
    include Edge::Pokes
    include Edge::Posts
    include Edge::Scores
    include Edge::TaggableFriends
    include Edge::Tagged
    include Edge::TaggedPlaces
    include Edge::Television
    include Edge::Videos
    extend Searchable

    register_attributes(
      raw: [
        :about, :email, :first_name, :gender, :install_type, :installed, :interested_in, :is_eligible_promo,
        :is_shared_login, :is_verified, :last_name, :link, :locale, :meeting_for, :middle_name, :name, :name_format,
        :political, :quotes, :relationship_status, :religion, :test_group, :third_party_id, :timezone, :token_for_business,
        :verified, :viewer_can_send_gift, :website,
        # NOTE: in family edge context
        :relationship,
        # NOTE: in page admin context
        :perms, :role,
        # NOTE: in group context
        :administrator,
        # NOTE: in photo tags context
        :x, :y,
        # NOTE: in event-related context
        :rsvp_status
      ],
      time: [
        :updated_time,
        :shared_login_upgrade_required_by,
        # NOTE: in photo tags context
        :created_time,
      ],
      date: [:birthday],
      page: [:hometown, :location],
      pages: [:favorite_athletes, :favorite_teams, :inspirational_people, :languages, :sports],
      user: [
        :significant_other,
        # NOTE: in photo tags context
        :tagging_user
      ],
      photo: [:cover],
      custom: [
        :age_range, :context, :currency, :devices, :education, :payment_mobile_pricepoints, :payment_pricepoints,
        :security_settings, :suggested_groups, :video_upload_limits, :work
      ]
    )

    def initialize(id, attributes = {})
      super
      if attributes.include? :age_range
        self.age_range = Struct::AgeRange.new attributes[:age_range]
      end
      if attributes.include? :context
        self.context = Struct::Context::UserContext.new attributes[:context]
      end
      if attributes.include? :currency
        self.currency = Struct::Currency.new attributes[:currency]
      end
      if attributes.include? :devices
        self.devices = attributes[:devices].collect do |device|
          Struct::Device.new device
        end
      end
      if attributes.include? :education
        self.education = attributes[:education].collect do |education|
          Struct::Education.new education
        end
      end
      if attributes.include? :work
        self.work = attributes[:work].collect do |work|
          Struct::Work.new work
        end
      end
    end

    def self.me(access_token)
      new(:me).authenticate access_token
    end
  end
end
