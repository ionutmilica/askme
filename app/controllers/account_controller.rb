class AccountController < ApplicationController
  before_action :authenticate_user!

  def wall

  end

  def questions
    @unanswered = current_user.received_questions.unanswered
  end


  def answer
    @question = Question.mine current_user.id, params[:id]

    if @question.nil? or @question.reply != nil
      redirect_to account_questions_path
    end
  end

  def do_answer
    Question.answer current_user.id, params[:id], params.require(:question).permit(:reply)
    redirect_to account_questions_path
  end


  def follow

  end

  def search

  end

  def settings

  end
end