class Client
  attr_reader :id, :first_name, :last_name

  def initialize(attrs)
    @first_name = attrs[:first_name]
    @last_name = attrs[:last_name]
    @id = attrs["id"].to_i
  end

  class << self
    def all
      DB.exec("SELECT * FROM clients;").map do |clients|
        Stylist.new(clients)
      end
    end

  end
end
