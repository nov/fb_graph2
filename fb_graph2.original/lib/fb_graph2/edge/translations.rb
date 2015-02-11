module FbGraph2
  class Edge
    module Translations
      def translations(params = {})
        translations = self.edge :translations, params
        translations.collect! do |translation|
          Translation.new(translation[:id], translation).authenticate self.authenticate
        end
      end

      def translation!(params = {})
        self.post params, edge: :translations
      end
      alias_method :translate!, :translation!
    end
  end
end