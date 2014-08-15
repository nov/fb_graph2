module FbGraph2
  class Edge
    module AppRequests
      def app_requests(params = {})
        requests = self.edge :apprequests, params
        requests.collect! do |request|
          Request.new(request[:id], request).authenticate self.access_token
        end
      end
      alias_method :apprequests, :app_requests

      def app_request!(params = {})
        response = self.post params, edge: :apprequests
        if request = response[:request]
          response[:request] = Request.new(request[:id], request).authenticate self.access_token
        end
        response
      end
      alias_method :apprequest!, :app_request!
    end
  end
end