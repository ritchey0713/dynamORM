# execute application from here
require_relative "./environment"


Song.create_table

s = Song.create(name: "song name", release_year: "2006")

Song.create(name: "song name1", release_year: "2006")
Song.create(name: "song name2", release_year: "2006")
Song.create(name: "song name3", release_year: "2006")
Song.create(name: "song name4", release_year: "2006")
Song.create(name: "song name5", release_year: "2006")
Song.create(name: "song name6", release_year: "2006")
Song.create(name: "song name7", release_year: "2006")
Song.create(name: "song name8", release_year: "2006")

Song.create(name: "song name9", release_year: "2006")

songs = Song.all 
# puts "hello"
# puts songs.last.id

puts Song.find_by_name("song name5")