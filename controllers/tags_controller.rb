require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('../models/transactions')
require_relative('../models/tags')

get '/tag/:id' do
  @tag = Tag.find(params['id'].to_i)
  # @transactions_tag = @tag.transactions
  erb(:"tags/view_tag")
end
