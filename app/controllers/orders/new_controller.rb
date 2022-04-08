module Orders
  class NewController < ApplicationController
    def call
      render :template, locals: { order: Order.new }
    end
  end
end
