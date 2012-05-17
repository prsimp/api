def build_random_user
  first_name = Faker::Name.first_name
  last_name  = Faker::Name.last_name
  name       = "#{first_name} #{last_name}"
  username   = (first_name[0..2] + last_name).gsub(/[^a-z]/i, '').downcase
  email      = "#{username}@example.com"
  age        = Random.new.rand(18..65)
  location   = "#{Faker::Address.city}, #{Faker::AddressUS.state}"

  User.create!(name: name, username: username, email: email, age: age, location: location)
end

41.times { build_random_user }

me = User.new(name: "Paul Simpson",
              email: "prsimp@gmail.com",
              username: "prsimp",
              age: 27,
              location: "Manhattan, Kansas")

my_profiles = [
  {site: "Github", username: "prsimp", profile_url: "https://github.com/prsimp/"},
  {site: "StackOverflow", username: "Paul Simpson", profile_url: "http://stackoverflow.com/users/1005071/paul-simpson"},
  {site: "Twitter", username: "prsimp", profile_url: "https://twitter.com/#!/prsimp"},
  {site: "Last.fm", username: "parisim", profile_url: "http://www.last.fm/user/parisim"}
]

my_profiles.each { |profile| me.profiles.build(profile) }

# harvest_facts = [
#   {fact_type: "Harvest", title: "Company Culture", body: "Harvest gives back to the OSS, local startup and international communities. This is important to me."},
#   {fact_type: "Harvest", title: "People Love It", body: "I want to build something that people love because it makes their lives better."},
#   {fact_type: "Harvest", title: "Coworkers", body: "I want to work with people who are passionate about their craft, are honest, hard-working, and know how to enjoy work."},
#   {fact_type: "Harvest", title: "Team Management", body: "I like the open-minded and flexible approach to managing a distributed company."}
# ]

# harvest_facts.each { |fact| me.facts.build(fact) }

# hire_facts = [
#   {fact_type: "Hire", title: "Hungry", body: "I am hungry to learn and grow as a developer."},
#   {fact_type: "Hire", title: "Fast Learner", body: "I am smart and learn very rapidly."},
#   {fact_type: "Hire", title: "Calm", body: "I've been trained to be comfortable in situations a bit out of my depth. On the job training often the best kind of experience."},
#   {fact_type: "Hire", title: "Curious", body: "I like to figure out what makes things tick."},
#   {fact_type: "Hire", title: "Problem Solver", body: "I am a natural problem solver"},
#   {fact_type: "Hire", title: "Team Player", body: "I love working with other people and communicate well."}
# ]

# hire_facts.each { |fact| me.facts.build(fact) }

# background_facts = [
#   {fact_type: "Background", title: "Formal Training", body: "AP Computer Science (C++) in high school."},
#   {fact_type: "Background", title: "Formal Training", body: "Intro to Java and Programming Java courses from North Carolina State University Engineering Online Program"},
#   {fact_type: "Background", title: "Formal Training", body: "Discrete Mathematics course from North Carolina State University Engineering Online Program"},
#   {fact_type: "Background", title: "Self-Taught", body: "Basic Ruby knowledge"},
#   {fact_type: "Background", title: "Self-Taught", body: "Basic Rails knowledge"},
#   {fact_type: "Background", title: "Self-Taught", body: "Intermediate HTML and CSS knowledge"},
#   {fact_type: "Recent", title: "NYCorBUST", body: "Built a rails application for aggregating items we were selling on Craigslist in preparation for the move. Visible at http://www.nycorbust.com or on Github at http://github.com/prsimp/nycorbust"},
#   {fact_type: "Recent", title: "US Army", body: "Spent the last almost 3.5 years serving as an Infantry Officer in the United States Army"},
#   {fact_type: "Recent", title: "Paul Simpson API", body: "Built this sweet API to display myself"},
# ]

# background_facts.each { |fact| me.facts.build(fact) }

# random_facts = [
#   {fact_type: "Random", title: "Tomatoes", body: "Can't stand tomatoes. Especially on sandwhiches"},
#   {fact_type: "Random", title: "Bananas", body: "Likes almost all things banana-flavored"},
#   {fact_type: "Random", title: "Pets", body: "Prefers cats to dogs, generally, but has secretly always wanted a snake."},
#   {fact_type: "Random", title: "Favorite Books", body: "Anna Karenina, The Soul of a New Machine, Catch-22, and Once an Eagle."},
#   {fact_type: "Random", title: "Backflips", body: "Quit doing backflips off the diving board after hitting his head on one at age nine."},
#   {fact_type: "Random", title: "Gutter", body: "Was accidentally dropped head-first into a gutter in Washington D.C. as an infant."},
#   {fact_type: "Random", title: "Vans", body: "Loves classic Vans shoes."},
#   {fact_type: "Random", title: "Spelling Bee", body: "Lost a spelling bee in 2nd grade by misspelling austere a-u-s-t-i-r-e"}
# ]

# random_facts.each { |fact| me.facts.build(fact) }

my_facts = [
  {fact_type: "Harvest", title: "Company Culture", body: "Harvest gives back to the OSS, local startup and international communities. This is important to me."},
  {fact_type: "Harvest", title: "People Love It", body: "I want to build something that people love because it makes their lives better."},
  {fact_type: "Harvest", title: "Coworkers", body: "I want to work with people who are passionate about their craft, are honest, hard-working, and know how to enjoy work."},
  {fact_type: "Harvest", title: "Team Management", body: "I like the open-minded and flexible approach to managing a distributed company."},
  {fact_type: "Hire", title: "Hungry", body: "I am hungry to learn and grow as a developer."},
  {fact_type: "Hire", title: "Fast Learner", body: "I am smart and learn very rapidly."},
  {fact_type: "Hire", title: "Calm", body: "I've been trained to be comfortable in situations a bit out of my depth. On the job training often the best kind of experience."},
  {fact_type: "Hire", title: "Curious", body: "I like to figure out what makes things tick."},
  {fact_type: "Hire", title: "Problem Solver", body: "I am a natural problem solver"},
  {fact_type: "Hire", title: "Team Player", body: "I love working with other people and communicate well."},
  {fact_type: "Background", title: "Formal Training", body: "AP Computer Science (C++) in high school."},
  {fact_type: "Background", title: "Formal Training", body: "Intro to Java and Programming Java courses from North Carolina State University Engineering Online Program"},
  {fact_type: "Background", title: "Formal Training", body: "Discrete Mathematics course from North Carolina State University Engineering Online Program"},
  {fact_type: "Background", title: "Self-Taught", body: "Basic Ruby knowledge"},
  {fact_type: "Background", title: "Self-Taught", body: "Basic Rails knowledge"},
  {fact_type: "Background", title: "Self-Taught", body: "Intermediate HTML and CSS knowledge"},
  {fact_type: "Recent", title: "NYCorBUST", body: "Built a rails application for aggregating items we were selling on Craigslist in preparation for the move. Visible at http://www.nycorbust.com or on Github at http://github.com/prsimp/nycorbust"},
  {fact_type: "Recent", title: "US Army", body: "Spent the last almost 3.5 years serving as an Infantry Officer in the United States Army"},
  {fact_type: "Recent", title: "Paul Simpson API", body: "Built this sweet API to display myself"},
  {fact_type: "Random", title: "Tomatoes", body: "Can't stand tomatoes. Especially on sandwhiches"},
  {fact_type: "Random", title: "Bananas", body: "Likes almost all things banana-flavored"},
  {fact_type: "Random", title: "Pets", body: "Prefers cats to dogs, generally, but has secretly always wanted a snake."},
  {fact_type: "Random", title: "Favorite Books", body: "Anna Karenina, The Soul of a New Machine, Catch-22, and Once an Eagle."},
  {fact_type: "Random", title: "Backflips", body: "Quit doing backflips off the diving board after hitting his head on one at age nine."},
  {fact_type: "Random", title: "Gutter", body: "Was accidentally dropped head-first into a gutter in Washington D.C. as an infant."},
  {fact_type: "Random", title: "Vans", body: "Loves classic Vans shoes."},
  {fact_type: "Random", title: "Spelling Bee", body: "Lost a spelling bee in 2nd grade by misspelling austere a-u-s-t-i-r-e"}
]

my_facts.each { |fact| me.facts.build(fact)}

me.save!

58.times { build_random_user }