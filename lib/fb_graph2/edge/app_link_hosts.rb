module FbGraph2
  class Edge
    module AppLinkHosts
      def app_link_hosts(params = {})
        hosts = self.edge :app_link_hosts, params

        applinks = [];
        hosts.collect! do |host|
          applinks.push AppLinkHost.new(host[:id], host).authenticate self.access_token
        end

        applinks
      end
    end
  end
end