module Trainer
  class ProductsController < BaseController
    def create
      create! { products_path }
    end

    protected

    def begin_of_association_chain
      current_user
    end

    def build_resource_params
      [params.fetch(:product, {}).permit(:name, :description, :price, files: [])]
    end
  end
end
