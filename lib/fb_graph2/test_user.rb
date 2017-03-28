require 'fb_graph2/user'

module FbGraph2
  class TestUser < User
    register_attributes(
      raw: [:login_url, :password]
    )

    def friend!(test_user)
      self.post({}, edge: :friends, edge_scope: test_user.id)
      test_user.post({}, edge: :friends, edge_scope: self.id)
    end
  end
end
