require_relative("../models/tags.rb")
require_relative("../models/transactions.rb")
require("pry-byebug")

Tag.delete_all
Transaction.delete_all

tag1 = Tag.new({
  "name" => "Groceries"
  })

tag1.save

tag2 = Tag.new({
  "name" => "Clothes"
  })

tag2.save

transaction1 = Transaction.new({
  "name" => "Week groceries",
  "tag_id" => tag1.id,
  "amount" => "14,35"
  })

transaction1.save

binding.pry
nil
