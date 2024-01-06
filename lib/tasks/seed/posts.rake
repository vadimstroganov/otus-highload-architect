# frozen_string_literal: true

namespace :seed do
  desc 'Seeds posts'
  task posts: :environment do
    User.each do |user|
      puts "generate posts for user #{user[:id]}"

      rand(1..2).times do
        Post::CreateAction.run(user_id: user[:id], text: Faker::GreekPhilosophers.quote)
      end
    end
  end
end
