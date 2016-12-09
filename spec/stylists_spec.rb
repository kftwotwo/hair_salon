require('spec_helper')

describe(Stylist) do
  before :each do
    @joe = Stylist.new({:first_name => 'Joe', :last_name => "Flower"})
  end

  describe('#initialize') do
    it "will initialize id, first_name, and last_name" do
      expect(@joe.first_name).to eq 'Joe'
      expect(@joe.last_name).to eq 'Flower'
    end
  end

  describe('#save') do
    it "will save into the database" do
      expect(@joe.save).to be true
    end
  end
end
