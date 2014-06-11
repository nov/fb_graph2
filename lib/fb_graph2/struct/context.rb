module FbGraph2
  class Struct
    class Context < Struct
      register_attributes(
        custom: [:mutual_friends, :mutual_likes]
      )

      def initialize(attributes = {})
        if attributes.include? :mutual_friends
          self.mutual_friends = Collection.new(attributes[:mutual_friends]).collect do |user|
            User.new user[:id], user
          end
        end
        if attributes.include? :mutual_likes
          self.mutual_likes = Collection.new(attributes[:mutual_likes]).collect do |page|
            Page.new page[:id], page
          end
        end
      end
    end
  end
end