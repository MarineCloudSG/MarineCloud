module Trainer
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :set_locale
    before_action :verify_subscription

    inherit_resources

    def index
      authorize resource_class, :index?
      super
    end

    def new
      authorize resource_class, :new?
      super
    end

    def create
      authorize resource_class, :create?
      super
    end

    def edit
      authorize resource, :edit?
      super
    end

    def update
      authorize resource, :update?
      super
    end

    def show?
      authorize resource, :show?
      super
    end

    def destroy?
      authorize resource, :destroy?
    end

    protected

    def collection
      get_collection_ivar || set_collection_ivar(
        policy_scope(end_of_association_chain).decorate
      )
    end

    def resource
      get_resource_ivar || set_resource_ivar(super.decorate)
    end

    def verify_subscription
      if current_user.payment_processor.subscriptions.blank?
        current_user.set_payment_processor :fake_processor, allow_fake: true
      end
      unless current_user.payment_processor.on_trial_or_subscribed?
        redirect_to choose_subscription_path
      end
    end

    def set_locale
      I18n.locale = current_user.language
    end
  end
end
