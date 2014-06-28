class Order
  class StripeBuilder
    attr_accessor :token, :order

    def self.create_charge(*args)
      new(*args).generate_charge
    end

    def initialize(options = {})
      self.token = options[:token]
      self.order = options[:order]
    end

    def generate_charge
      order.credit_card_number = token
      order.save
      begin
        charge = Stripe::Charge.create(
          amount: (order.total_price * 100).to_i,
          currency: "usd",
          card: token
        )
      rescue Stripe::CardError => e
        order.errors << e.message
      end
    end
  end
end
