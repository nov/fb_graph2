module FbGraph2
  class Event < Node
    include Edge::Attending
    include Edge::Declined
    include Edge::Feed
    include Edge::Maybe
    include Edge::Noreply
    include Edge::Picture
    include Edge::Photos
    include Edge::Videos
    extend Searchable

    register_attributes(
      raw: [:description, :location, :name, :ticket_uri, :timezone],
      time: [:end_time, :start_time, :updated_time],
      page: [:venue],
      profile: [:owner],
      group: [:parent_group],
      photo: [:cover]
    )
  end
end