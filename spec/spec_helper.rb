require("rspec")
require('pry')
require("./lib/clients")
require("./lib/stylists")
require('pg')

DB = PG.connect({:dbname => "hair_salon_test"})

RSpec.configure do |config|
  config.after(:each) do

    DB.exec("DELETE FROM clients *;")
    DB.exec("DELETE FROM stylists *;")

    DB.exec('ALTER SEQUENCE clients_id_seq RESTART WITH 1')
    DB.exec('ALTER SEQUENCE stylists_id_seq RESTART WITH 1')
  end
end
