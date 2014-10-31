module FbGraph2
  class Edge
    module Roles
      module AppContext
        def roles(params = {})
          roles = self.edge :roles, params
          roles.collect! do |role|
            Struct::Role.new role
          end
        end

        def role!(user, params = {})
          self.post params.merge(
            user: Util.as_identifier(user)
          ), edge: :roles
        end

        def unrole!(user, params = {})
          self.post params.merge(
            user: Util.as_identifier(user)
          ), edge: :roles
        end
      end

      module PageContext
        def roles(*args)
          params = args.extract_options!
          users = self.edge :roles, params, edge_scope: args.first
          users.collect! do |user|
            User.new(user[:id], user).authenticate self.access_token
          end
          if args.first.present?
            users.first
          else
            users
          end
        end
      end
    end
  end
end