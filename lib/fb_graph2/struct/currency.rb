module FbGraph2
  class Struct
    class Currency < Struct
      register_attributes(
        raw: [:user_currency, :currency_exchange, :currency_exchange_inverse, :usd_exchange, :usd_exchange_inverse, :currency_offset]
      )
    end
  end
end