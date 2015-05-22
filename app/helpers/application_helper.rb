module ApplicationHelper

  def format_question_sender_link(question)
    sender = question.sender
    if sender.nil? or question.anonymous
      return ''
    end
    link_to sender.username, profile_answers_path(sender.username)
  end
end
