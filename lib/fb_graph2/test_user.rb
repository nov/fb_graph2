require 'fb_graph2/user'

module FbGraph2
  class TestUser < User
    register_attributes(
      raw: [:login_url, :password]
    )
  end
end
