class LikesController < ApplicationController
  before_action :authenticate_user!

  def like
    question = Question.find_by_id params[:id]
    if question
      current_user.create_like(question)
      render html: 'ok'
    else
      render html: 'nok'
    end
  end

end