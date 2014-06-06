module FbGraph2
  class Payment < Node
    include Edge::Dispute
    include Edge::Refunds

    register_attributes(
      raw: [:product, :quantity, :request_id, :country, :created_time, :payout_foreign_exchange_rate, :test],
      time: [:created_time, :updated_time],
      user: [:user],
      app: [:application],
      custom: [:actions, :items, :disputes]
    )

    def initialize(id, attributes = {})
      super
      # TODO: handle custom attributes.
    end
  end
end