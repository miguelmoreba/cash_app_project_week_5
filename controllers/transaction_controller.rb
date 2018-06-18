require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('../models/transactions.rb')
require_relative('../models/tags.rb')

get '/transactions' do
  @transactions = Transaction.all
  @transactions_total = Transaction.total
  erb(:index)
end

get '/transactions/new' do
  @transactions = Transaction.all
  @tags = Tag.all
  erb(:"transactions/new")
end

get '/transactions/:id/edit' do
  @transaction = Transaction.find(params[:id])
  @tags = Tag.all
  erb(:"transactions/edit")
end

post '/transactions' do
  transaction = Transaction.new(params)
  transaction.save
  redirect to '/transactions'
end

post '/transactions/:id/delete' do
  transaction = Transaction.find(params[:id])
  transaction.delete
  redirect to '/transactions'
end

post '/transactions/:id' do #update
  Transaction.new(params)
  redirect to '/transactions'
end
