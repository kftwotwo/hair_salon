require('spec_helper')

describe(Stylist) do
  before :each do
    @joe = Stylist.new({:first_name => "Joe", :last_name => 'Flower'})
  end

  describe('#initialize') do
    it "will initialize id, first_name, and last_name" do
      expect(@joe.first_name).to eq 'Joe'
      expect(@joe.last_name).to eq 'Flower'
    end
  end


  describe('.all') do
    it('starts with an empty database') do
      expect(Stylist.all).to be_an Array
    end
  end

  describe('#save') do
    it "will save into the database" do
      expect(@joe.save).to be true
    end
   end

   describe('#delete') do
     it "will save  then delete from database" do
       @joe.save
       expect(@joe.delete).to be true
     end
    end

  describe('.find') do
    it('finds a stylist in the database, if it exists') do
      @joe.save
      expect(Stylist.find(@joe.id).first).to eq ["id", "1"]
    end
  end

  describe('#update') do
    it('updates the data in the database') do
      joe = Stylist.new({:first_name => "Joe", :last_name => 'Flower'})
      joe.save
      joe.update({:first_name => "Jamie", :last_name => 'Table'})
      expect(joe.first_name).to eq "Jamie"
      expect(joe.last_name).to eq "Table"
    end
  end
end


# SELECT * FROM clients
# JOIN stylists ON (stylists.id = clients.stylist_id)
