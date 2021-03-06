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

  def self.find(id)
    sql = "SELECT * FROM tags
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return Tag.new(results.first)
  end

  def self.total(id)
    sql = "SELECT SUM(amount) as total FROM transactions WHERE id = $1"
    values = []
    transactions_by_tag = SqlRunner.run(sql, values)
    return transactions[0]['total']
  end

  def transactions()
    sql = "SELECT * FROM transactions
    WHERE tag_id = $1"
    values = [@id]
    results = SqlRunner.run( sql, values )
    return results.map {|transaction| Transaction.new(transaction)}
  end

end
