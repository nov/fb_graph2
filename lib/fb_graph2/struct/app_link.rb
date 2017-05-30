module FbGraph2
  class Struct
    class AppLink < Struct
      register_attributes(
        raw: [:url]
      )

      class Native < AppLink
        register_attributes(
          raw: [:app_name]
        )

        class IOS < Native
          register_attributes(
            raw: [:app_store_id]
          )
        end

        class Android < Native
          register_attributes(
            raw: [:package],
            custom: [:klass]
          )

          def initialize(attributes = {})
            super
            if attributes.include? :class
              self.klass = attributes[:class]
            end
          end
        end

        class WindowsPhone < Native
          register_attributes(
            raw: [:app_id]
          )
        end
      end

      class Web < AppLink
        register_attributes(
          raw: [:should_fallback]
        )
      end
    end
  end
end