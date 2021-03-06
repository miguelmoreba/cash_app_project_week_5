require_relative('../db/sql_runner.rb')

class Transaction

  attr_reader( :id, :dt, :name, :tag_id, :amount)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @dt = options['dt']
    @name = options['name']
    @tag_id = options['tag_id']
    @amount = options['amount']
  end

  def save()
    sql = "INSERT INTO transactions
    (
      dt,
      name,
      tag_id,
      amount
    )
    VALUES
    (
      $1,
      $2,
      $3,
      $4
    )
    RETURNING id"
    values = [@dt, @name, @tag_id, @amount]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "UPDATE transactions
    SET
    (
      name,
      tag_id,
      amount
    )
    =
    (
      $1,
      $2,
      $3
    )
    WHERE id = $4"
    values = [@name, @tag_id, @amount, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM transactions
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all
    sql = "SELECT * FROM transactions"
    results = SqlRunner.run(sql)
    return results.map{ |transaction| Transaction.new(transaction) }
  end

  def self.delete_all
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end

  def self.total()
    sql = "SELECT SUM(amount) as total FROM transactions"
    values = []
    transactions = SqlRunner.run(sql, values)
    return transactions[0]['total']
  end

  def self.total_tag(id)
    sql = "SELECT SUM(amount) as total FROM transactions
    WHERE tag_id = $1"
    values = [id]
    transactions = SqlRunner.run(sql, values)
    return transactions[0]['total']
  end

  def self.find(id)
    sql = "SELECT * FROM transactions
    WHERE id = $1"
    values = [id]
    transaction = SqlRunner.run(sql, values)
    result = Transaction.new(transaction.first)
    return result
  end

  def tag()
    return Tag.find(@tag_id)
  end


  def nice_date(date)
    year = date[0,4]
    month = date[5,2]
    day = date[8,2]
    return "#{day}/#{month}/#{year}"
  end


  def return_hi
    return "hi"
  end
end
