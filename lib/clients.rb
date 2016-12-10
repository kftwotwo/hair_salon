class Client
  attr_reader :first_name, :last_name, :stylist_id, :id

  def initialize(attrs)
    @first_name = attrs[:first_name]
    @last_name = attrs[:last_name]
    @stylist_id = attrs[:stylist_id]
    @id = attrs[:id]
  end

  class << self
    def all
      returned_clients = DB.exec('SELECT * FROM clients;')
      clients = []
      returned_clients.each() do |client|
        first_name = client['first_name']
        last_name = client['last_name']
        stylist_id = client['stylist_id'].to_i()
        id = client['id'].to_i()
        clients.push(Client.new({:first_name => first_name, :last_name => last_name, :stylist_id => stylist_id, :id => id}))
      end
      clients
    end

    def find(id)
      found_client = nil
      Client.all().each() do |client|
        if client.id() == id
          found_client = client
        end
      end
      found_client
    end
  end #end of singletons

  def ==(another_client)
    self.first_name() == another_client.first_name() && self.last_name() == another_client.last_name() && self.id() == another_client.id()
  end

  def save
    result = DB.exec("INSERT INTO clients (first_name, last_name, stylist_id) VALUES ('#{@first_name}', '#{@last_name}', #{@stylist_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i
  end

  def update(attributes)
    @first_name = attributes.fetch(:first_name)
    @last_name = attributes.fetch(:last_name)
    @stylist_id = self.stylist_id()
    @id = self.id()
    DB.exec("UPDATE clients SET first_name ='#{@first_name}' WHERE id = #{@id};")
    DB.exec("UPDATE clients SET last_name ='#{@last_name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM clients WHERE id = #{self.id()};")
  end
end
