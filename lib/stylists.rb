class Stylist
  attr_reader(:id, :first_name, :last_name)

  def initialize(attrs)
    @id = attrs[:id]
    @first_name = attrs[:first_name]
    @last_name = attrs[:last_name]
  end

  class << self
    def all
      returned_stylists = DB.exec('SELECT * FROM stylists')
      stylists = []
      returned_stylists.each do |stylist|
        first_name = stylist['first_name']
        last_name = stylist['last_name']
        id = stylist['id'].to_i()
        stylists.push(Stylist.new({:first_name => first_name, :id => id}))
      end
    end

    def ==(other)
      self.first_name().==(other.first_name).&(self.id().==(other.id()))
    end
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
      DB.exec("DELETE FROM stylists WHERE last_name = '#{@last_name}'")
      true
    rescue StandardError => e
      puts e.message
      false
    end
  end


end
