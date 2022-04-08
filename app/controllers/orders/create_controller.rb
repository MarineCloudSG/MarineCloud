module Orders
  class CreateController < ApplicationController
    def call
      order = Order.create(
        product: product,
        price: product.price,
        customer_email: params.fetch(:order).fetch(:email)
        )

      order.set_payment_processor :stripe

      order.payment_processor.stripe_account = user.merchant_processor.account.id

      @checkout_session = order.payment_processor.checkout(
        mode: 'payment',
        locale: 'pl',
        line_items: {
          price_data: {
            currency: 'PLN',
            product_data: {name: product.name},
            unit_amount: (product.price * 100).to_i
          },
          quantity: 1
        },
        success_url: 'https://test.marinecloud.test',
        cancel_url: 'https://test.marinecloud.test'
        # stripe_account: "{{#{user.merchant_processor.account.id}}}"
      )

      return redirect_to @checkout_session.url, allow_other_host: true, status: :see_other
    end

    private

    def product
      @product ||= user.products.last
    end

    def user
      @user ||= Webpage.find_by!(domain: request.subdomain).user
    end
  end
end
