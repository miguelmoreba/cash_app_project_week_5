require_relative('../db/sql_runner.rb')

class Transaction

  attr_reader( :id, :name, :tag_id, :amount)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @tag_id = options['tag_id']
    @amount = options['amount']
  end

  def save()
    sql = "INSERT INTO transactions
    (
      name,
      tag_id,
      amount
    )
    VALUES
    (
      $1,
      $2,
      $3
    )
    RETURNING id"
    values = [@name, @tag_id, @amount]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
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
    sql = "SELECT SUM(amount) FROM transactions"
    values = []
    transactions = SqlRunner.run(sql, values)
    return transactions[0].values
  end


end
