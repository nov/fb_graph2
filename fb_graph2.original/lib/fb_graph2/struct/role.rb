module FbGraph2
  class Struct
    class Role < Struct
      register_attributes(
        raw: [:app_id, :user, :role]
      )
    end
  end
end