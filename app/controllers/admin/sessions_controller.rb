module Admin
  class SessionsController < ApplicationController
    skip_before_action :authorize
    layout 'application_admin'
    def new
      # render layout: false
    end

    def create
      user = User.find_by(name: params[:name])
      unless user
        user = User.find_by(email: params[:name])
      end
      user
      if user and user.authenticate(params[:password])
        session[:user_id] = user.id.to_s
        # abort user.id.to_s.inspect
        redirect_to admin_news_index_path
      else
        redirect_to admin_login_url, alert: "Invalid user/password combination"
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to  admin_login_url, notice: "Logged out"
    end
  end
end

