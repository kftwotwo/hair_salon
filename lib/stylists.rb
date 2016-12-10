class Stylist
  attr_reader :first_name, :last_name, :id

  def initialize(attrs)
    @first_name = attrs[:first_name]
    @last_name = attrs[:last_name]
    @id = attrs[:id]
  end

  class << self
    def all
      returned_stylists = DB.exec("SELECT * FROM stylists;")
      stylists = []
      returned_stylists.each() do |stylist|
        first_name = stylist.fetch('first_name')
        last_name = stylist.fetch('last_name')
        id = stylist.fetch('id').to_i()
        stylists.push(Stylist.new({:first_name => first_name, :last_name => last_name,:id => id}))
      end
      stylists
    end

    def find(id)
      found_stylist = nil
      Stylist.all().each() do |stylist|
        if stylist.id == id
          found_stylist = stylist
        end
      end
      found_stylist
    end
  end #end of singletons

  def save
    result = DB.exec("INSERT INTO stylists (first_name, last_name) VALUES ('#{@first_name}', '#{@last_name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  def ==(another_stylist)
    self.last_name() == another_stylist.last_name() && self.id() == another_stylist.id()
  end

  def clients
    stylist_clients = []
    clients = DB.exec("SELECT * FROM clients WHERE stylist_id = #{self.id()};")
    clients.each() do |client|
      first_name = client.fetch('first_name')
      last_name = client.fetch('last_name')
      stylist_id = client.fetch('stylist_id').to_i()
      id = client.fetch('id').to_i()
      stylist_clients.push(Client.new({:first_name => first_name, :last_name => last_name, :stylist_id => stylist_id, :id => id}))
    end
    stylist_clients
  end

  def update(attrs)
    @first_name = attrs[:first_name]
    @last_name = attrs[:last_name]
    @id = self.id()
    DB.exec("UPDATE stylists SET first_name ='#{@first_name}', last_name ='#{@last_name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stylists WHERE id = #{self.id()};")
    DB.exec("DELETE FROM clients WHERE stylist_id = #{self.id()};")
  end
end
