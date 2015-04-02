module FbGraph2
  class Struct
    class Rating < Struct
      register_attributes(
        raw: [:has_rating, :has_review, :rating, :review_text],
        datetime: [:created_time],
        user: [:reviewer],
        custom: [:open_graph_story]
      )
    end
  end
end
