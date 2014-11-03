class CreateActivityRequests < ActiveRecord::Migration
  def change
    create_table :activity_requests do |t|
      t.integer :activity_id
      t.integer :user_id
      t.integer :friend_id
      t.boolean :accepted
      t.boolean :holding
      t.timestamps
    end
    add_index :activity_requests, [:activity_id, :user_id, :friend_id]
  end
end
