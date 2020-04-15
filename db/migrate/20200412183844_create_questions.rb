class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :question, :null => false
      t.integer :poll_id, :null => false
    end
  end
end
