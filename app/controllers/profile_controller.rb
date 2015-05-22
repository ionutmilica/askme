class ProfileController < ApplicationController

  def answers
    @user = User.find_by_username params[:username]
  end

  def best

  end

  def gifts

  end
end