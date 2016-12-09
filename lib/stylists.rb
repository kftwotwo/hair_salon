class Stylist
  attr_reader :id, :first_name, :last_name

  def initialize(attrs)
    @first_name = attrs[:first_name]
    @last_name = attrs[:last_name]
    @id = attrs["id"].to_i
  end

  class << self
    def all
      DB.exec("SELECT * FROM stylists;").map do |data|
        Stylist.new(data)
      end
    end

    def find(id)
      DB.exec("SELECT * FROM stylists WHERE id = #{id};").first
    end
  end #end of singletons

  def ==(other)
    @last_name == other.last_name && @id == other.id
  end

  def save
    begin
      saved = DB.exec("INSERT INTO stylists (first_name, last_name) VALUES ('#{@first_name}', '#{@last_name}') RETURNING id;")
      @id = saved.first['id'].to_i
      true
    rescue StandardError => e
      puts e.message
      false
    end
  end

  def delete
    begin
      DB.exec("DELETE FROM stylists WHERE id = #{@id};")
      true
    rescue StandardError => e
      puts e.message
      false
    end
  end

  def update(attrs)
    @first_name = attrs[:first_name]
    @last_name = attrs[:last_name]
    DB.exec("UPDATE stylists SET first_name = '#{@first_name}', last_name = '#{@last_name}' WHERE id = #{id};")
  end

  def client
    clients = DB.exec("SELECT * FROM clients WHERE stylist_id = #{self.id};")
  end
end
