class AddCachedVotesToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :cached_votes_total, :integer, :default => 0
    add_column :questions, :cached_votes_score, :integer, :default => 0
    add_column :questions, :cached_votes_up, :integer, :default => 0
    add_column :questions, :cached_votes_down, :integer, :default => 0
    add_index  :questions, :cached_votes_total
    add_index  :questions, :cached_votes_score
    add_index  :questions, :cached_votes_up
    add_index  :questions, :cached_votes_down

    Question.find_each(&:update_cached_votes)
  end

  def self.down
    remove_column :questions, :cached_votes_total
    remove_column :questions, :cached_votes_score
    remove_column :questions, :cached_votes_up
    remove_column :questions, :cached_votes_down
  end
end