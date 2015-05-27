# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

questions = [
    'If you could be invisible, what would you do?',
    'What can’t be bought with money?',
    'Who do you think is the most beautiful person in the World?',
    'How often do you listen to the radio? What is your favorite radio station?',
    'Do you like Coke or Pepsi? Why?',
    'Which countries have you visited?',
    'When you feel sad, what cheers you up?',
    'What would you do if you meet an alien?',
    'What are you currently addicted to?',
    'Why is a healthy lifestyle so trendy now?',
    'Do you prefer a bath or shower?',
    'What are you obsessed with?',
    'What\'s your favorite drink?',
    'What could you do as a child that you can\'t do now?'
]

questions.each do |question|
  RandomQuestion.add question
end
