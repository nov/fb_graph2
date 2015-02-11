module FbGraph2
  class Struct
    class GroupFile < Struct
      register_attributes(
        raw: [:id, :download_link],
        time: [:updated_time],
        user: [:from],
        group: [:group]
      )
    end
  end
end