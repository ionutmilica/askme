class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :from
      t.integer :to
      t.string :question
      t.string :reply
      t.datetime :created_at
      t.datetime :replied_at
    end
  end
end
