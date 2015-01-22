require('rspec')
require('expense')
require('business')
require('category')
require('spending')
require('pg')
require('pry')

DB = PG.connect({:dbname => "budget_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM expenses *;")
    DB.exec("DELETE FROM businesses *;")
    DB.exec("DELETE FROM categories *;")
    DB.exec("DELETE FROM spendings *;")
  end
end
