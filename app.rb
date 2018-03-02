require('sinatra')
require('sinatra/contrib/all')
require_relative('controllers/transaction_controller.rb')
require_relative('controllers/tags_controller.rb')

get '/' do
  @transactions = Transaction.all
  @transactions_total = Transaction.total
  erb(:index)
end
