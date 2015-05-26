class HomeController < ApplicationController
  def home
      if user_signed_in?
        redirect_to account_wall_path
      end
  end
end