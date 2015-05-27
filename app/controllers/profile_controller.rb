class ProfileController < ApplicationController
  before_action :set_user
  before_action :set_answers
  before_filter :authenticate_user!, only: [:follow, :unfollow]

  def answers
  end

  def best
    @best = @user.received_questions.best
  end

  def ask
    Question.create_question(@user, current_user, question_params)
    redirect_to profile_answers_path params[:username]
  end

  def follow
    current_user.follow @user
    redirect_to profile_answers_path
  end


  def unfollow
    current_user.stop_following @user
    redirect_to profile_answers_path
  end

  def answer
    @answer = Question.find_by_id params[:id]
    unless @answer
      redirect_to profile_answers_path
    end
  end

  private
    def question_params
      unless  user_signed_in?
        params[:question]['anonymous'] = 1
      end
      params.require(:question).permit(:question, :anonymous)
    end

    def set_user
      @user = User.find_by_username params[:username]

      if @user.nil?
        redirect_to root_path
      end
    end

    def set_answers
      @answers = @user.received_questions.answered
    end
end