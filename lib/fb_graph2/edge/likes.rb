module FbGraph2
  class Edge
    module Likes
      module LikerContext
        def likes(params = {})
          pages = self.edge :likes, params
          pages.collect do |page|
            Page.new(page[:id], page).authenticate self.access_token
          end
        end

        def liked?(page_id, params = {})
          pages = self.edge :likes, params, edge_scope: page_id
          pages.present?
        end
      end

      module LikeeContext
        def initialize(id, attributes)
          super
          if attributes.include?(:likes)
            @_cached_likes = Collection.new attributes[:likes]
          end
        end

        def likes(params = {})
          users = if @_cached_likes.present? && params.blank?
            @_cached_likes
          else
            self.edge :likes, params
          end
          users.collect do |user|
            User.new(user[:id], user).authenticate self.access_token
          end
        end

        def like!(params = {})
          self.post params, edge: :likes
        end

        def unlike!(params = {})
          self.delete params, edge: :likes
        end
      end
    end
  end
end