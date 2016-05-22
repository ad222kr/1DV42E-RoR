# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

venue1 = Venue.create(name: "First venue")
venue2 = Venue.create(name: "Second venue");

event1 = Event.create(name: "HehEvent", date: 3.days.from_now)
event2 = Event.create(name: "SecondEvent", date: 10.days.from_now)
event3 = Event.create(name: "SecondEvent", date: 1.days.from_now)
event4 = Event.create(name: "SecondEvent", date: 2.days.from_now)
event5 = Event.create(name: "SecondEvent", date: 3.days.from_now)
event6 = Event.create(name: "SecondEvent", date: 5.days.from_now)
event7 = Event.create(name: "SecondEvent", date: 6.days.from_now)

venue1.events << event1
venue1.events << event2
venue1.events << event3
venue1.events << event4
venue2.events << event5
venue2.events << event6
venue2.events << event7

venue1.save
venue2.save

