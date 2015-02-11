module FbGraph2
  class Edge
    module Settings
      def settings(params = {})
        settings = self.edge :settings, params
        settings.collect! do |setting|
          Struct::Setting.new setting
        end
      end
    end
  end
end