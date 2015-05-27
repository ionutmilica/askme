class CreateRandomQuestions < ActiveRecord::Migration
  def change
    create_table :random_questions do |t|
      t.string :question

      t.timestamps null: false
    end
  end
end
