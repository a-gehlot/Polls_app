# == Schema Information
#
# Table name: users
#
#  id       :bigint           not null, primary key
#  username :string           not null
#
class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true
    
    has_many :responses, class_name: "Response", foreign_key: "user_id"
    has_many :authored_polls, class_name: "Poll", foreign_key: "user_id"
end
