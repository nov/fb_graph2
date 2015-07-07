module FbGraph2
  class Edge
    module AppLinkHosts
      def app_link_hosts(params = {})
        hosts = self.edge :app_link_hosts, params
        hosts.collect! do |host|
          AppLinkHost.new(host[:id], host).authenticate self.access_token
        end
      end

      def app_link_host!(params = {})
        jsonized_params = params.inject({}) do |jsonized_params, (key, value)|
          jsonized_param = case value
          when Hash, Array
            value.to_json
          else
            value
          end
          jsonized_params.merge! key => jsonized_param
        end
        host = self.post jsonized_params, edge: :app_link_hosts
        AppLinkHost.new(host[:id], params.merge(host)).authenticate self.access_token
      end
    end
  end
end