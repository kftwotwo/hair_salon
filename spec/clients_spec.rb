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

end
