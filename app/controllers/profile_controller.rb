class ProfileController < ApplicationController
  before_action :set_user

  def answers
    @answers = @user.received_questions.answered
  end

  def best

  end

  def gifts

  end

  protected
    def set_user
      @user = User.find_by_username params[:username]
    end
end