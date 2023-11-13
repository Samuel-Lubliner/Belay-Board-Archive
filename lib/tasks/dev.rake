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
    end

    task add_requests: :environment do
      puts "adding requests..."
    end
  end
end
