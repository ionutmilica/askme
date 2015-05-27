module ApplicationHelper

  def format_question_sender_link(question)
    sender = question.sender
    if sender.nil? or question.anonymous
      return ''
    end
    link_to sender.username, profile_answers_path(sender.username)
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible", role: 'alert') do
               concat(content_tag(:button, class: 'close', data: { dismiss: 'alert' }) do
                        concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
                        concat content_tag(:span, 'Close', class: 'sr-only')
                      end)
               concat message
             end)
    end
    nil
  end

  def emojify(content)
    h(content).to_str.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias($1)
        %(<img alt="#$1" src="#{image_path("emoji/#{emoji.image_filename}")}" style="vertical-align:middle" width="20" height="20" />)
      else
        match
      end
    end.html_safe if content.present?
  end
end
