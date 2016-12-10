require('spec_helper')

describe(Stylist) do
  before :each do
  @stylist  = Stylist.new({:first_name => "Kevin", :last_name => 'Finley', :id => nil})
  @stylist2  = Stylist.new({:first_name => "Kevin", :last_name => 'Finley', :id => nil})
  @stylist3  = Stylist.new({:first_name => "Ron", :last_name => 'Doggie', :id => nil})
  end

  describe('#initialize') do
    it('will return first_name and last_name') do
      expect(@stylist.first_name).to eq 'Kevin'
      expect(@stylist.last_name).to eq 'Finley'
    end
  end

  describe('.all') do
    it('return empty') do
      expect(Stylist.all).to eq []
    end
  end

  describe('#save') do
    it('will save to the database') do
      @stylist.save
      expect(Stylist.all).to eq [@stylist]
    end
  end

  describe('#==') do
    it('will check to see if stylists have the same last_name') do
      expect(@stylist).to eq @stylist2
    end
  end

  describe('.find') do
    it('returns a stylist by their id') do
      @stylist.save
      @stylist3.save
      expect(Stylist.find(@stylist.id)).to eq @stylist
    end
  end

  describe('#clients') do
    it('returns an array of the clients this stylist has') do
      @stylist3.save
      test_client = Client.new({:first_name => 'Lucky', :last_name => 'Joe', :stylist_id => @stylist3.id(), :id => nil})
      test_client.save
      test_client2 = Client.new({:first_name => 'Siri', :last_name => 'Apple', :stylist_id => @stylist3.id(), :id => nil})
      test_client2.save
      expect(@stylist3.clients).to eq [test_client, test_client2]
    end
  end

  describe('#update') do
    it("allows user to update stylist name in database") do
      stylist = Stylist.new({:first_name => 'paul', :last_name => 'two-two', :id => nil})
      stylist.save
      stylist.update({:first_name => 'Cullen', :last_name => 'fairbanks'})
      expect(stylist.first_name).to eq 'Cullen'
    end
  end

  describe('#delete') do
    it('allows a user to delete a stylist from the database') do
      @stylist.save
      @stylist2.save
      @stylist.delete
      expect(Stylist.all).to eq [@stylist2]
    end
    it('deletes a stylists clients from the database') do
      @stylist.save
      client = Client.new({:first_name => "Logan", :last_name => "Trevor", :stylist_id => @stylist.id(), :id => nil})
      client.save
      client2 = Client.new({:first_name => "Mr.Cat", :last_name => "Cattion", :stylist_id => @stylist.id(), :id => nil})
      client2.save
      @stylist.delete
      expect(Stylist.all).to eq []
    end
  end
end
