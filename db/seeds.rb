require_relative("../models/tags.rb")
require_relative("../models/transactions.rb")
require("pry-byebug")

Transaction.delete_all
Tag.delete_all


tag1 = Tag.new({
  "name" => "Groceries"
  })

tag1.save

tag2 = Tag.new({
  "name" => "Clothes"
  })

tag2.save

transaction1 = Transaction.new({
  "dt" => "2-12-17",
  "name" => "Week groceries",
  "tag_id" => tag1.id,
  "amount" => 14.35
  })

transaction1.save

transaction2 = Transaction.new({
  "dt" => "2-12-17",
  "name" => "shite",
  "tag_id" => tag2.id,
  "amount" => 8.00
  })

transaction2.save

binding.pry
nil
