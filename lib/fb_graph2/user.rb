module FbGraph2
  class User < Node
    include Edge::Accounts
    include Edge::Achievements
    include Edge::Activities
    include Edge::Albums
    include Edge::Books
    include Edge::Events
    include Edge::Family
    include Edge::Feed
    include Edge::FriendLists
    include Edge::Friends
    include Edge::Games
    include Edge::Home
    include Edge::Interests
    include Edge::InvitableFriends
    include Edge::Likes
    include Edge::Links
    include Edge::Movies
    include Edge::Music
    include Edge::Notifications
    include Edge::Permissions
    include Edge::Picture
    include Edge::Photos
    include Edge::Pokes
    include Edge::Posts
    include Edge::Scores
    include Edge::Statuses
    include Edge::Tagged
    include Edge::Television
    include Edge::Videos

    register_attributes(
      raw: [
        :about, :bio, :email, :first_name, :gender, :installed, :is_verified, :link, :locale,
        :middle_name, :name, :name_format, :political, :quotes, :relationship_status, :religion,
        :timezone, :third_party_id, :verified, :website,
        # NOTE: in family edge context
        :relationship
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
      # TODO: handle custom attributes.
    end

    def self.me(access_token)
      new(:me).authenticate access_token
    end
  end
end