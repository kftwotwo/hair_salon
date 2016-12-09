require('sinatra')
require('./lib/clients')
require('./lib/stylists')
require('pg')

DB = PG.connect({:dbname => "hair_salon_test"})

get('/') do
  erb(:index)
end
