class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.integer :follower, null: false
      t.integer :followed, null: false
      t.timestamps
    end
    add_index  :follows, [:follower, :followed], unique: true
  end
end
