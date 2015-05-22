class AddTitleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :title, :text
  end
end
