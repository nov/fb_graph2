module FbGraph2
  class Struct
    class Subscription < Struct
      register_attributes(
        raw: [:object, :callback_url, :fields, :active]
      )
    end
  end
end