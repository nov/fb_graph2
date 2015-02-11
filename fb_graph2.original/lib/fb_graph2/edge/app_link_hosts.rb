module FbGraph2
  class Edge
    module AppLinkHosts
      def app_link_hosts(params = {})
        hosts = self.edge :app_link_hosts, params
        hosts.collect! do |host|
          AppLinkHost.new(hosts[:id], hosts).authenticate self.access_token
        end
      end
    end
  end
end