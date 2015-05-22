class AddAnonymousToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :anonymous, :boolean
  end
end
