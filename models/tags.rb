require_relative('../db/sql_runner.rb')

class Tag

  attr_reader(:name, :id)

  def initialize(options)
    @id = options['id'] if options['id']
    @name = options['name']
  end

  def save
    sql = "INSERT INTO tags
    (name)
    VALUES
    ($1)
    RETURNING id"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM tags"
    results = SqlRunner.run(sql)
    return results.map {|tag| Tag.new(tag)}
  end

  def self.delete_all
    sql = "DELETE FROM tags"
    SqlRunner.run(sql)
  end

  # def self.find(id)
  #   sql = "SELECT * FROM tags
  #   WHERE id = $1"
  #   values = [id]
  #   results = SqlRunner.run(sql, values)
  #   return Tag.new(results.first)
  # end

end
