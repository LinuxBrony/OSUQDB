class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :quote
      t.string :ip
      t.boolean :upvote

      t.timestamps
    end
  end
end
