class AddInfoFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fullname, :string
    add_column :users, :location, :string
    add_column :users, :description, :text
  end
end
