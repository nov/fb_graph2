module FbGraph2
  class App < Node
    include Edge::Achievements
    include Edge::AppLinkHosts
    include Edge::AppEventTypes
    include Edge::Banned
    include Edge::Groups
    include Edge::Permissions
    include Edge::Picture
    include Edge::Roles::AppContext
    include Edge::Scores
    include Edge::StaticResources
    include Edge::Subscriptions
    include Edge::TestUsers # called "accounts" edge on Graph API Doc.
    include Edge::Translations

    register_attributes(
      raw: [
        :android_key_hash, :app_domains, :app_events_feature_bitmask, :app_name, :app_type, :auth_dialog_data_help_url,
        :auth_dialog_headline, :auth_dialog_perms_explanation, :auth_referral_default_activity_privacy, :auth_referral_enabled,
        :auth_referral_extended_perms, :auth_referral_friend_perms, :auth_referral_response_type, :auth_referral_user_perms,
        :canvas_fluid_height, :canvas_fluid_width, :canvas_url, :category, :client_config, :company, :configured_ios_sso,
        :contact_email, :creator_uid, :daily_active_users, :daily_active_users_rank, :deauth_callback_url, :description,
        :hosting_url, :icon_url, :ios_bundle_id, :ios_supports_system_auth, :ipad_app_store_id, :iphone_app_store_id,
        :link, :logo_url, :migrations, :mobile_profile_section_url, :mobile_web_url, :monthly_active_users, :monthly_active_users_rank,
        :name, :namespace, :page_tab_default_name, :page_tab_url, :privacy_policy_url, :profile_section_url, :secure_canvas_url,
        :secure_page_tab_url, :server_ip_whitelist, :social_discovery, :subcategory, :supports_attribution, :supports_implicit_sdk_logging,
        :suppress_native_ios_gdp, :terms_of_service_url, :url_scheme_suffix, :use_legacy_auth, :user_support_email, :user_support_url,
        :website_url, :weekly_active_users, :gdpv4_enabled, :gdpv4_nux_enabled, :gdpv4_nux_content
      ],
      timestamp: [:created_time],
      custom: [
        :android_sdk_error_categories, :context, :ios_sdk_error_categories, :object_store_urls, :restrictions,
        :supports_apprequests_fast_app_switch
      ]
    )

    def initialize(id, attributes = {})
      super
      if attributes.include? :context
        self.context = Struct::Context::AppContext.new attributes[:context]
      end
      # TODO: handle custom attributes.
    end

    def self.app(access_token)
      new(:app).authenticate access_token
    end
  end
end