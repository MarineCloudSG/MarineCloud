module Trainer
  class WebpagesController < BaseController
    def update
      update! do |success, _failure|
        success.html { redirect_to edit_landing_page_path, notice: t("trainer.webpages.edit.success") }
      end
    end

    protected

    def resource
      current_user.webpage
    end

    def build_resource_params
      [params.fetch(:webpage, {}).permit(:name, :domain)]
    end
  end
end
