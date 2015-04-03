module FbGraph2
  class Struct
    module Context
      class UserContext < Struct
        register_attributes(
          users: [:mutual_friends],
          pages: [:mutual_likes]
        )
      end

      class PageContext < Struct
        register_attributes(
          users: [:friends_who_like, :friends_tagged_at, :music_listen_friends, :video_watch_friends]
        )
      end

      class AppContext < Struct
        register_attributes(
          users: [:friends_using_app]
        )
      end
    end
  end
end