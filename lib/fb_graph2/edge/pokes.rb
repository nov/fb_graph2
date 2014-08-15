module FbGraph2
  class Edge
    module Pokes
      def pokes(params = {})
        pokes = self.edge :pokes, params
        pokes.collect! do |poke|
          Struct::Poke.new poke
        end
      end
    end
  end
end