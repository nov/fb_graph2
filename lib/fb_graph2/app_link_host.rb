module FbGraph2
  class AppLinkHost < Node
    register_attributes(
      raw: [:name, :canonical_url],
      custom: [:ios, :iphone, :ipad, :android, :windows_phone, :web]
    )

    def initialize(id, attributes = {})
      super
      [:ios, :iphone, :ipad, :android, :windows_phone].each do |link_attr|
        if attributes.include? link_attr
          self.send :"#{link_attr}=", collect_links(attributes, link_attr)
        end
      end
    end

    private

    def collect_links(attributes, link_attr)
      Collection.new(attributes[link_attr]).collect! do |link|
        klass = case link_attr
        when :ios, :iphone, :ipad
          Struct::AppLink::Native::IOS
        when :android
          Struct::AppLink::Native::Android
        when :windows_phone
          Struct::AppLink::Native::WindowsPhone
        end
        klass.new link
      end
    end
  end
end