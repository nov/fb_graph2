module FbGraph2
  class Struct
    class Permission < Struct
      register_attributes(
        raw: [:permission, :status]
      )

      def as_identifier
        permission
      end

      def revokable?
        !['public_profile'].include? permission
      end
    end
  end
end