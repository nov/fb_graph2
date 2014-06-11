module FbGraph2
  class Struct
    class Parking < Struct
      register_attributes(
        int_flag: [:street, :lot, :valet]
      )
    end
  end
end