module FbGraph2
  class Edge
    module FriendLists
      def friend_lists(params = {})
        friend_lists = self.edge :friendlists, params
        friend_lists.collect! do |friend_list|
          FriendList.new(friend_list[:id], friend_list).authenticate self.access_token
        end
      end
      alias_method :friendlists, :friend_lists
    end
  end
end