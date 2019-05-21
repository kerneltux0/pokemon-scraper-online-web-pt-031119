class Pokemon
  attr_accessor :name, :type, :db
  attr_reader :id

  def initialize(id:, name:, type:, db:)
    @name = name
    @id = id
    @type = type
    @db = db

  end

  def self.save(name,type,db)
    sql = <<-SQL
      INSERT INTO pokemon (name,type)
      VALUES (?, ?)
    SQL

    grab_id = <<-SQL
      SELECT last_insert_rowid()
      FROM pokemon
    SQL

    db.execute(sql,name,type)
    @id = db.execute(grab_id)[0][0]
  end

  def self.find(id,db)
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?
    SQL
    
    db.execute(sql,id).map do |row|
      self.new(id:row[0],name:row[1],type:row[2],db:db)
    end.first

  end

end
