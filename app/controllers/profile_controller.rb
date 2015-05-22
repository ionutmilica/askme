class ProfileController < ApplicationController
  before_action :set_user

  def answers
    @answers = @user.received_questions.answered
  end

  def best

  end

  def gifts

  end

  def ask
    Question.create_question(@user, current_user, question_params)

    redirect_to profile_answers_path params[:username]
  end

  private
    def question_params
      params.require(:question).permit(:question, :anonymous)
    end

    def set_user
      @user = User.find_by_username params[:username]
    end
end