1000.times do
  Question.create({ title: Faker::Hacker.say_something_smart,
                    body:  Faker::Hipster.paragraph,
                    view_count: rand(1000)
                  })
end

puts Cowsay.say 'Created 1000 questions', :cow
