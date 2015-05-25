class AccountController < ApplicationController
  before_action :authenticate_user!

  def wall
  end

  def questions
    @unanswered = current_user.received_questions.unanswered
  end

  def delete_questions
    Question.delete_all_for_user current_user.id
    redirect_to account_questions_path
  end

  def delete_question
    Question.delete_for_user params[:id], current_user.id
    redirect_to account_questions_path
  end

  def delete_answer
    Question.delete_answer params[:id], current_user.id
    redirect_to profile_answers_path current_user.username
  end

  def answer
    @question = Question.mine current_user.id, params[:id]

    if @question.nil? or @question.reply != nil
      redirect_to account_questions_path
    end
  end

  def do_answer
    Question.answer current_user.id, params[:id], answer_params
    redirect_to account_questions_path
  end


  def follows
    @follows = current_user.follows_by_type('User')
  end

  def search
    @users = []
  end

  def do_search
    @users = User.search params[:query], current_user.id

    render 'account/search'
  end

  private
  def answer_params
    params.require(:question).permit(:reply, :image)
  end
end