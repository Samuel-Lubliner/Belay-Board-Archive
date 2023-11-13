if Rails.env.development?
  namespace :dev do
    desc "Drops, creates, migrates, and adds sample data to database"
    task reset: [
           :environment,
           "db:drop",
           "db:create",
           "db:migrate",
           "dev:sample_data",
         ]

    desc "Adds sample data for development environment"
    task sample_data: [
      :environment,
      "dev:add_users",
      "dev:add_availabilities",
      "dev:add_requests",
    ] do
      puts "done adding sample data"
    end

    task add_users: :environment do
      puts "adding users..."
      names = ["Sam", "Olivia", "Robbie", "Rashid"]

      names.each do |name|
        u = User.create(
          email: "#{name}@example.com",
          username: name,
          password: "password",
        )
        puts "added #{u.email}"
      end
    end

    task add_availabilities: :environment do
      puts "adding availabilities..."
    
      locations = ["Movement Lincoln Park", "Movement Wrigley", "BKB", "First Ascent Avondale", "First Ascent Humboldt", "First Ascent Uptown"]

      descriptions = ['Seeking a partner for bouldering.', 'Seeking a partner for top rope.', 'Seeking a partner lead climbing.']
    
      users = User.all
    
      users.each do |user|
        20.times do
          start_time = rand(3.months).seconds.from_now
    
          end_time = start_time + rand(2..6).hours
    
          location = locations.sample

          description = descriptions.sample
    
          user.availabilities.create(
            start_time: start_time,
            end_time: end_time,
            location: location,
            description: description,
            is_open: true
          )
        end
      end
    
      puts "done adding availabilities..."
    end
    

    task add_requests: :environment do
      puts "adding requests..."
    end
  end
end
