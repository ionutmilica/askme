class Question < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User', :foreign_key => 'from'
  belongs_to :receiver, :class_name => 'User', :foreign_key => 'to', :dependent => :destroy

  acts_as_votable
  mount_uploader :image, ImageUploader

  validates :question, presence: true

  def self.mine(user_id, question_id)
    where(to: user_id).where(id: question_id).first
  end

  def self.answered
    where.not(reply: nil, replied_at: nil).order('id DESC')
  end

  def self.unanswered
    where(replied_at: nil, reply: nil).order('id DESC')
  end

  def self.best
    where.not(reply: nil, replied_at: nil).order('cached_votes_total DESC')
  end

  def self.create_question(user, current, params)
    question = Question.new
    question.from = current.nil? ? nil : current.id
    question.to = user.id
    question.question = params[:question]
    question.anonymous = params[:anonymous].to_i == 1 ? true : false
    question.created_at = Time.now
    question.save
  end

  def self.create_random(user)
    params = {
        :anonymous => 1,
        :question  => RandomQuestion.random.question
    }
    self.create_question(user, nil, params)
  end

  def self.answer(user_id, question_id, params)
    params[:replied_at] = Time.now

    question = self.mine user_id, question_id

    if question
      question.update!(params)
      Activity.log(user_id, question_id)
      Notification.reply(question)
    end

    question
  end

  def self.delete_all_for_user(user_id)
    delete_all to: user_id
  end

  def self.delete_for_user(question_id, user_id)
    question = find_by_id question_id

    if question and question.to == user_id and question.reply == nil
      question.destroy
    end
  end

  def self.delete_answer(question_id, user_id)
    question = find_by_id question_id

    if question and question.to == user_id
      question.reply = nil
      question.replied_at = nil
      question.save

      Activity.delete_all(question_id: question_id)
      Notification.delete_all(question_id: question_id)
    end
  end
end
