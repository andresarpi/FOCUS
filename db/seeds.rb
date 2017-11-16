# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u = User.first

#users.each do |u|
    
    for i in 0..50 do
        
        s = Survey.new
        s.user_id = 2
        s.feeling = 30 + Random.rand(70)
        s.focus = 1 + Random.rand(98)
        s.activity_id = 1 + Random.rand(5).to_i
        puts s.activity_id
        s.created = Time.current - (i/2.0) * 3600 * 24
        s.save!

    end
#end