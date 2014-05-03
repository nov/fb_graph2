module FbGraph2
  class User < Node
    def self.me(access_token)
      new(:me, access_token: access_token)
    end
  end
end
