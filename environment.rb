require "sqlite3"
require_relative "./lib/song"

DB = {:conn => SQLite3::Database.new("db/lecture.db")}