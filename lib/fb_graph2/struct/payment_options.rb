module FbGraph2
  class Struct
    class PaymentOptions < Struct
      register_attributes(
        int_flag: [:amex, :cash_only, :discover, :mastercard, :visa]
      )
    end
  end
end