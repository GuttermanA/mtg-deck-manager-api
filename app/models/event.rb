class Event < ApplicationRecord
  has_many :decks
  belongs_to :format

  def add_attributes_from_string(string)
    # string will enter as "FORMAT #PLAYERS DATE"
    #name is up to first digit

    name = string[/^[^\d]*/].strip
    #players is first unbroken digit chains between spaces
    players = string[/\s(\d+)\s/].strip
    #date is formated dd/mm/yy
    date = string[/\d{2}\/\d{2}\/\d{2}/].strip
    byebug
    self.format = Format.find_or_create_by(name: name)
    self.players = players
    self.date = Date.parse(date)
    self.save!
  end
end
