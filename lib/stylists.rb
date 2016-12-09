class Stylist
  attr_reader(:id, :first_name, :last_name)

  def initialize(attrs)
    @id = attrs[:id]
    @first_name = attrs[:first_name]
    @last_name = attrs[:last_name]
  end

  class << self
    def all
      DB.exec('SELECT * FROM stylists')
    end

    def find(last_name)
      DB.exec("SELECT * FROM stylists WHERE last_name = '#{@last_name}';")
    end

  end

  def save
    begin
      DB.exec("INSERT INTO stylists (first_name, last_name) VALUES ('#{@first_name}', '#{@last_name}');")
      true
    rescue StandardError => e
      puts e.message
      false
    end
  end

  def delete
    begin
      DB.exec("DELETE FROM stylists WHERE last_name = '#{@last_name}'")
      true
    rescue StandardError => e
      puts e.message
      false
    end
  end
end
