class Client
  attr_reader :id, :first_name, :last_name

  def initialize(attrs)
    @first_name = attrs[:first_name]
    @last_name = attrs[:last_name]
    @id = attrs["id"].to_i
  end


end
