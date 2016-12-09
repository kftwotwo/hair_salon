require('spec_helper')

describe(Client) do
  before :each do
    @joe = Client.new({:first_name => "Kevin", :last_name => 'Finley'})
  end

  describe('#initialize') do
    it "will initialize id, first_name, and last_name" do
      expect(@joe.first_name).to eq 'Kevin'
      expect(@joe.last_name).to eq 'Finley'
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

  describe('.find') do
    it('finds a stylist in the database, if it exists') do
      @joe.save
      expect(Client.find(@joe.id).first).to eq ["id", "1"]
    end
  end

end
