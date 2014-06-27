module FbGraph2
  class Struct
    class MessageTag < Struct
      register_attributes(
        raw: [:id,:name,:type,:offset,:length]
      )
    end
  end
end
