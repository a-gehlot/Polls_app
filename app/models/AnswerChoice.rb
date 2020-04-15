# == Schema Information
#
# Table name: answer_choices
#
#  id          :bigint           not null, primary key
#  answer      :string           not null
#  question_id :integer          not null
#
class AnswerChoice < ApplicationRecord
    validates :answer, :question_id, presence: true

    belongs_to :question, class_name: "Question", foreign_key: "question_id"
    has_many :responses, class_name: "Response", foreign_key: "answer_choice_id"
end
