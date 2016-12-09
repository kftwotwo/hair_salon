require('spec_helper')

describe(Client) do
  before :each do
    @kevin = Client.new({:first_name => "Kevin", :last_name => 'Finley'})
  end

  describe('#initialize') do
    it "will initialize id, first_name, and last_name" do
      expect(@kevin.first_name).to eq 'Kevin'
      expect(@kevin.last_name).to eq 'Finley'
    end
  end

  describe('.all') do
    it('starts with an empty database') do
      expect(Stylist.all).to be_an Array
    end
  end

  describe('#save') do
    it "will save into the database" do
      expect(@kevin.save).to be true
    end
   end

  describe('.find') do
    it('finds a stylist in the database') do
      @kevin.save
      expect(Client.find(@kevin.id).first).to eq ["id", "1"]
    end
  end

  describe('#delete') do
    it "will save then delete from database" do
      @kevin.save
      expect(@kevin.delete).to be true
    end
  end

  describe('#update') do
    it('updates the data in the database') do
      kevin = Stylist.new({:first_name => "Kevin", :last_name => 'Finley'})
      kevin.save
      kevin.update({:first_name => "Andrew", :last_name => 'Two-Two'})
      expect(kevin.first_name).to eq "Andrew"
      expect(kevin.last_name).to eq "Two-Two"
    end
  end
end
