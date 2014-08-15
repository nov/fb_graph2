module FbGraph2
  class Edge
    module TaggableFriends
      def taggable_friends(params = {})
        taggable_friends = self.edge :taggable_friends, params
        taggable_friends.collect! do |friend|
          Struct::Friend.new friend
        end
      end
    end
  end
end