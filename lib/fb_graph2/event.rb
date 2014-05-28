module FbGraph2
  class Event < Node
    register_attributes(
      raw: [:description, :is_date_only, :location, :name, :privacy, :ticket_uri, :timezone],
      time: [:end_time, :start_time, :updated_time],
      page: [:venue],
      profile: [:owner],
      group: [:parent_group],
      photo: [:cover]
    )
  end
end