module FbGraph2
  class Edge
    module InvitableFriends
      def invitable_friends(params = {})
        invitable_friends = self.edge :invitable_friends, params
        invitable_friends.collect! do |friend|
          Struct::Friend.new friend
        end
      end
    end
  end
end