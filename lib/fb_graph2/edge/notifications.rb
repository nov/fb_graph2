module FbGraph2
  class Edge
    module Notifications
      def notifications(params = {})
        notifications = self.edge :notifications, params
        notifications.collect do |notification|
          Notification.new notification[:id], notification
        end
      end

      def notification!(params = {})
        notification = self.post params, edge: :notifications
        notification[:success]
      end
      alias_method :notify!, :notification!
    end
  end
end