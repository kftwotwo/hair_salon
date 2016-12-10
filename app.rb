require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/clients')
require('./lib/stylists')
require('pg')

DB = PG.connect({:dbname => 'hair_salon_test'})

get('/') do
  erb(:index)
end

get('/stylists') do
  @stylists = Stylist.all
  erb(:stylists)
end

post('/stylists') do
  first_name = params['first_name']
  last_name = params['last_name']
  Stylist.new({:first_name => first_name, :last_name => last_name, :id => nil}).save
  @stylists = Stylist.all
  erb(:stylists)
end

get('/stylists/:id') do
  @stylist = Stylist.find(params['id'].to_i)
  erb(:stylist)
end

get('/stylists/:id/edit') do
  @stylist = Stylist.find(params['id'].to_i)
  erb(:edit_stylist)
end

patch('/stylists/:id') do
  first_name = params['new_first_name']
  last_name = params['new_last_name']
  @stylist = Stylist.find(params['id'].to_i)
  @stylist.update({:first_name => first_name, :last_name => last_name})
  erb(:stylist)
end

delete('/stylists/:id') do
  @stylist = Stylist.find(params['id'].to_i)
  @stylist.delete
  @stylists = Stylist.all
  erb(:stylists)
end

get('/clients') do
  @clients = Client.all
  erb(:clients)
end

post('/clients') do
  first_name = params['first_name']
  last_name = params['last_name']
  stylist_id = params['stylist_id'].to_i
  @stylist = Stylist.find(stylist_id)
  @client = Client.new(:first_name => first_name, :last_name => last_name, :stylist_id => stylist_id, :id => nil)
  @client.save
  erb(:stylist)
end

get('/clients/:id') do
  @client = Client.find(params['id'].to_i)
  @my_stylist = Stylist.find(@client.stylist_id)
  erb(:client)
end

get('/clients/:id/edit') do
  @client = Client.find(params['id'].to_i)
  erb(:edit_client)
end

patch('/clients/:id') do
  first_name = params['new_first_name']
  last_name = params['new_last_name']
  @client = Client.find(params['id'].to_i)
  @client.update({:first_name => first_name, :last_name => last_name})
  @stylist = Stylist.find(@client.stylist_id)
  erb(:stylist)
end

delete('/clients/:id') do
  @client = Client.find(params['id'].to_i)
  @stylist = Stylist.find(@client.stylist_id)
  @client.delete
  @clients = Client.all
  erb(:stylist)
end
