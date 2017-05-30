module FbGraph2
  class Edge
    module Domains
      def domains(params = {})
        domains = self.edge :domains, params
        domains.collect! do |domain|
          Domain.new(domain[:id], domain).authenticate self.access_token
        end
      end
    end
  end
end