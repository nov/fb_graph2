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
          class IPhone < IOS; end
          class IPad < IOS; end
        end

        class Android < Native
          register_attributes(
            raw: [:class, :package]
          )
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