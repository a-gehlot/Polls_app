# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  question_id      :integer          not null
#
class Response < ApplicationRecord
    validates :user_id, :answer_choice_id, presence: true
    validate :duplicate_response_validation
    validate :no_author_response
    
    belongs_to :respondent, class_name: "User", foreign_key: "user_id"
    belongs_to :answer_choice, class_name: "AnswerChoice", foreign_key: "answer_choice_id"

    has_one :question, through: :answer_choice, source: :question

    def sibling_responses
        self.question.responses.where.not(id: self.id)
    end

    def not_duplicate_response
        self.sibling_responses.exists?(user_id: self.user_id)
    end

    def duplicate_response_validation
        if self.not_duplicate_response
            errors[:respondent] << 'has already responded'
        end
    end

    def no_author_response
        author = self.question.poll.user_id
        if author == self.user_id
            errors[:base] << 'Author cannot answer own poll'
        end
    end
end
