module FbGraph2
  class Struct
    class RestaurantServices < Struct
      register_attributes(
        int_flag: [:kids, :delivery, :walkins, :catering, :reserve, :groups, :waiter, :outdoor, :takeout]
      )
    end
  end
end