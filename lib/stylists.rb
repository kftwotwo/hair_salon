class Stylist
  attr_reader(:id, :first_name, :last_name)

  def initialize(attrs)
    @id = attrs[:id]
    @first_name = attrs[:first_name]
    @last_name = attrs[:last_name]
  end
end
