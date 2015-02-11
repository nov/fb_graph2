module FbGraph2
  class Order < Node
    register_attributes(
      raw: [:amount, :country, :from, :refund_reason_code, :status],
      time: [:created_time, :updated_time],
      app: [:application]
    )
  end
end