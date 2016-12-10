require('capybara/rspec')
require('./app')
require('pry')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('view info for a stylist', {:type => :feature}) do
  before :each do
    @stylist = Stylist.new({:first_name => 'Kenney', :last_name => 'Sig', :id => nil})
    @stylist2 = Stylist.new({:first_name => 'Billy', :first_name => 'Ray', :id => nil})

    @client = Client.new({:first_name => 'Getro', :last_name => 'Paris', :stylist_id => @stylist.id(), :id => nil})
    @client2 = Client.new({:first_name => 'Getro', :last_name => 'Paris', :stylist_id => @stylist.id(), :id => nil})
  end
  it('allows a user to see all the clients and name of a stylist') do
    @tylist.save()
    @client.save()
    visit('/stylists')
    click_link(stylist.first_name())
    expect(page).to have_content(@client.first_name())
  end
end

describe('add clients to a stylist', {:type => :feature}) do
  it('allows a user to add a client to a stylist') do
    @stylist.save()
    visit("/stylists/#{test_stylist.id()}")
    fill_in("first_name", {:with => "John"})
    fill_in("last_name", {:with => "twotwo"})
    click_button('Add Client')
    expect(page).to have_content("John")
  end
end

describe('add stylists', {:type => :feature}) do
  it('allows the user to add a stylist to list of stylists') do
    visit('/stylists')
    fill_in('name', :with => 'Table')
    click_button('Add Stylist')
    expect(page).to have_content('Table')
  end
end

describe('update stylists', {:type => :feature}) do
  it('allows the user to update the name of a stylist') do
    visit('/stylists')
    fill_in('first_name', :with => 'sarina')
    fill_in('last_name', :with => 'nus')
    click_button('Add Stylist')
    click_link('sarina nus')
    click_link('Edit sarina nus')
    fill_in('new_first_name', :with => 'Jerry')
    fill_in('new_last_name', :with => 'Tom')
    click_button('Update')
    expect(page).to have_content('Jerry Tom')
  end
end

describe('delete a stylist', {:type => :feature}) do
  it('allows the user to delete a stylist') do
    visit('/stylists')
    fill_in('name', :with => 'Trena')
    click_button('Add Stylist')
    click_link('Trena')
    click_button('Delete Trena')
    expect(page).to have_content('no stylists yet!')
  end
end

describe('update clients', {:type => :feature}) do
  it('allows the user to update the name of a client') do
    visit('/stylists')
    fill_in('name', :with => 'Trena')
    click_button('Add Stylist')
    click_link('Trena')
    fill_in('first_name', :with => 'John')
    fill_in('last_name', :with => 'Smith')
    click_button('Add Client')
    click_link("Smith, John")
    click_link('Edit')
    fill_in('new_first_name', :with => 'Jane')
    fill_in('new_last_name', :with => 'Williams')
    click_button('Update')
    expect(page).to have_content('Jane')
  end
end

describe('delete a client', {:type => :feature}) do
  it('allows the user to delete a client from the database') do
    visit('/stylists')
    fill_in('name', :with => 'Trena')
    click_button('Add Stylist')
    click_link('Trena')
    fill_in('first_name', :with => 'John')
    fill_in('last_name', :with => 'Smith')
    click_button('Add Client')
    click_link("Smith, John")
    click_button('Delete John')
    expect(page).to have_content('any clients yet!')
  end
end
