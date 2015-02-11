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
            raw: [:class, :package]
          )
        end

        class WindowsPhone < Native
          register_attributes(
            raw: [:app_name]
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