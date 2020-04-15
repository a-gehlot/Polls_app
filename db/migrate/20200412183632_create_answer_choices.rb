class CreateAnswerChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :answer_choices do |t|
      t.string :answer, :null => false
      t.integer :question_id, :null => false
    end
  end
end
