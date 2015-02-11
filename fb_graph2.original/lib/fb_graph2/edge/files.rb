module FbGraph2
  class Edge
    module Files
      def files(params = {})
        files = self.edge :files, params
        files.collect! do |file|
          Struct::GroupFile.new file
        end
      end
    end
  end
end