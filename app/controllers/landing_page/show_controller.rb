module LandingPage
  class ShowController < ApplicationController
    layout "landing_page"

    def call
      render :template, locals: { trainer: trainer }
    end

    private

    def webpage
      @webpage ||= Webpage.find_by!(domain: request.subdomain)
    end

    def trainer
      @trainer ||= User.find(webpage.user_id)
    end
  end
end
