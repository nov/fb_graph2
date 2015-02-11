module FbGraph2
  class GroupDoc < Node
    register_attributes(
      raw: [:subject, :message, :icon, :revision, :can_edit, :can_delete],
      time: [:created_time, :updated_time],
      profile: [:from]
    )
  end
end