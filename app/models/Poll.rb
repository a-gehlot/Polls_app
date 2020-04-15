# == Schema Information
#
# Table name: polls
#
#  id         :bigint           not null, primary key
#  poll_title :string           not null
#  user_id    :integer          not null
#
class Poll < ApplicationRecord
    validates :poll_title, presence: true, uniqueness: true
    validates :user_id, presence: true
    
    belongs_to :author, class_name: "User", foreign_key: "user_id"
    has_many :questions, class_name: "Question", foreign_key: "poll_id"
end
