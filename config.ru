require './app'
require './controllers/transaction_controller'

map '/' do
  run App
  # run Transaction_controller
end
#
map '/transactions' do
  run Transaction_controller
end
