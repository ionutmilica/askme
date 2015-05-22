class HomeController < ApplicationController
  def home
    if current_user
      redirect_to account_wall_path
    end
  end

  def about

  end

  def terms

  end
end