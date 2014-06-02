module FbGraph2
  class Offer < Node
    register_attributes(
      raw: [:claim_limit, :coupon_type, :image_url, :published, :redemption_code, :redemption_link, :terms, :title, :message],
      time: [:created_time, :expiration_time, :reminder_time],
      timestamp: [:scheduled_publish_time],
      page: [:from]
    )
  end
end