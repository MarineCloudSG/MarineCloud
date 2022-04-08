module Trainer
  class ClientsController < BaseController
    def create
      create! do |success, _failure|
        success.html do
          resource.create_profile
          redirect_to resource, notice: t("trainer.clients.new.success", name: resource.name)
        end
      end
    end

    def update
      update! { clients_path }
    end

    protected

    def begin_of_association_chain
      current_user
    end

    def build_resource_params
      [params.fetch(:client, {}).permit(:name, :phone, :email)]
    end
  end
end
