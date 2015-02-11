module FbGraph2
  class Struct
    class RestaurantSpecialties < Struct
      register_attributes(
        int_flag: [:coffee, :drinks, :breakfast, :dinner, :lunch]
      )
    end
  end
end