module FbGraph2
  module RequestFilter
    class Debugger
      def filter_request(request)
        started = "======= [FbGraph2] API REQUEST STARTED ======="
        log started, request.dump
      end

      def filter_response(request, response)
        finished = "======= [FbGraph2] API REQUEST FINISHED ======="
        log '-' * 50, response.dump, finished
      end

      private

      def log(*outputs)
        outputs.each do |output|
          FbGraph2.logger.info output
        end
      end
    end
  end
end