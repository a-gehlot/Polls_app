# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do 
    AnswerChoice.destroy_all
    Poll.destroy_all
    Question.destroy_all
    Response.destroy_all
    User.destroy_all

    u1 = User.create!(username: 'andrewg')
    u2 = User.create!(username: 'peterf')
    u3 = User.create!(username: 'spencerc')
    u4 = User.create!(username: 'vijayG')
    u5 = User.create!(username: 'Trav1234')
    
    p1 = Poll.create!(poll_title: 'Andrew Poll', author: u1)
    p2 = Poll.create!(poll_title: 'Trav Poll', author: u5)

    q1 = Question.create!(question: 'Which console is the best?', poll: p1)

    a1 = AnswerChoice.create!(question: q1, answer: 'PS4')
    a2 = AnswerChoice.create!(question: q1, answer: 'Switch')
    a3 = AnswerChoice.create!(question: q1, answer: 'Xbox One')
    a4 = AnswerChoice.create!(question: q1, answer: 'PC')

    r2 = Response.create!(respondent: u2, answer_choice: a1)
    r3 = Response.create!(respondent: u3, answer_choice: a2)
    r4 = Response.create!(respondent: u4, answer_choice: a4)


end
