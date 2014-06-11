module FbGraph2
  class Struct
    class Location < Struct
      register_attributes(
        raw: [:country, :city, :longitude, :zip, :state, :street, :located_in, :latitude]
      )
    end
  end
end