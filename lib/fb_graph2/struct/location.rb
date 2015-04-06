module FbGraph2
  class Struct
    class Location < Struct
      register_attributes(
        raw: [:city, :country, :latitude, :located_in, :longitude, :name, :region, :state, :street, :zip]
      )
    end
  end
end