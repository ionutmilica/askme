class ProfileController < ApplicationController
  before_action :set_user
  before_action :set_answers

  def answers

  end

  def best

  end

  def gifts

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


  private
    def question_params
      unless  user_signed_in?
        params[:question]['anonymous'] = true
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