# == Schema Information
#
# Table name: questions
#
#  id       :bigint           not null, primary key
#  question :string           not null
#  poll_id  :integer          not null
#
class Question < ApplicationRecord
    validates :question, :poll_id, presence: true, uniqueness: true
    
    has_many :answer_choices, class_name: "AnswerChoice", foreign_key: "question_id"
    belongs_to :poll, class_name: "Poll", foreign_key: "poll_id"

    has_many :responses, through: :answer_choices, source: :responses

    def results
        choices = self.answer_choices.includes(:responses)

        result_hash = {}
        choices.each do |t|
            result_hash[t.answer] = t.responses.length
        end

        result_hash
    end

    def better_results
        choices = AnswerChoice.find_by_sql([<<-SQL, self.id])
            SELECT
                answer_choices.*,
                COUNT(responses.user_id) AS num_choices
            FROM
                answer_choices
            LEFT OUTER JOIN
                responses ON answer_choices.id = responses.answer_choice_id
            WHERE
                answer_choices.question_id = ?
            GROUP BY
                answer_choices.id
        SQL

        choices.inject({}) do |results, val|
            results[val.answer] = val.num_choices
            results
        end
    end

    def better_results_rails
        choices = self.answer_choices
        .left_outer_joins(:responses)
        .group('answer_choices.id')
        .select('answer_choices.*, COUNT(responses.user_id) AS num_choices')

        choices.inject({}) do |results, val|
            results[val.answer] = val.num_choices
            results
        end
    end
end
