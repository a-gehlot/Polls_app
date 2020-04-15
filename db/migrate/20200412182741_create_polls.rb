class CreatePolls < ActiveRecord::Migration[6.0]
  def change
    create_table :polls do |t|
      t.string :poll_title, :null => false
      t.integer :user_id, :null => false
    end
  end
end
