class LikesController < ApplicationController
  before_action :authenticate_user!

  def like
    question = Question.find_by_id params[:id]
    if question and current_user.likes question
      Notification.like(current_user.id, question)
      render html: 'ok'
    else
      render html: 'nok'
    end
  end

end