module FbGraph2
  class Edge
    module Notifications
      def notifications(params = {})
        notifications = self.edge :notifications, params
        notifications.collect do |notification|
          Notification.new notification[:id], notification
        end
      end
    end
  end
end