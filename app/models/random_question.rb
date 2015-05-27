class RandomQuestion < ActiveRecord::Base

  def self.add(question)
    q = RandomQuestion.new
    q.question = question
    q.save
  end

  def self.random
    self.order_by_rand.limit(1).first
  end
end
