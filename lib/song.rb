class Song 
  attr_accessor :name, :release_year, :id 

  def initialize(id=nil, name, release_year)
    @id = id 
    @name = name 
    @release_year = release_year 
  end 

  def self.create_table
    sql = <<-SQL 
      CREATE TABLE IF NOT EXISTS songs(
        id INTEGER PRIMARY KEY,
        name TEXT,
        release_year TEXT
      )
    SQL
    DB[:conn].execute(sql)
  end

  def old_save
    sql = <<-SQL
      INSERT INTO songs (name, release_year)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.release_year)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
  end 

  def save
    if self.id 
      self.update
    else 
      sql = <<-SQL
        INSERT INTO songs (name, release_year)
        VALUES (?, ?)
      SQL

      DB[:conn].execute(sql, self.name, self.release_year)

      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
    end 
  end

  def self.create(name:, release_year:)
    song = Song.new(name, release_year)
    song.save 
    song
  end 

  def self.new_from_db(row)
    song = self.new(row[0],row[1], row[2])
    # song.name = row[1]
    # song.release_year = row[2]
    # song.artist_id = row[3]
    song
  end

  def self.all 
    sql = <<-SQL
      SELECT * 
      FROM songs
    SQL

    data = DB[:conn].execute(sql)
    data.map {|row| self.new_from_db(row)}
  end 

  def self.find_by_name(name)
    sql = <<-SQL
      SELECT * 
      FROM songs 
      WHERE name = ?
      LIMIT 1
    SQL

    data = DB[:conn].execute(sql, name)
    data.map {|row| self.new_from_db(row)}.first
  end 

  def update
    sql = <<- SQL 
      UPDATE songs 
      SET name = ?,
      release_year = ?
      WHERE id = ?
    SQL
    DB[:conn].execute(sql, self.name, self.release_year, self.id)
  end 

end 
