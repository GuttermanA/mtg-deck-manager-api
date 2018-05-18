class Deck < ApplicationRecord
  belongs_to :user
  belongs_to :format
  has_many :deck_cards, dependent: :delete_all
  has_many :cards, through: :deck_cards

  validates :name, :format, presence: true

  scope :basic_search, -> (term) { where("name LIKE ? OR archtype LIKE ?", "%#{term}%", "%#{term}%")}

  before_save :card_count_calculator


  def card_count_calculator
    self.total_mainboard = DeckCard.where(deck_id: self.id, sideboard: false).sum(:card_count)
    self.total_sideboard = DeckCard.where(deck_id: self.id, sideboard: true).sum(:card_count)
    self.total_cards = self.total_mainboard + self.total_sideboard
  end

  def self.mtgtop8_scrape_homepage_decks
    agent = Mechanize.new

    page = agent.get('http://mtgtop8.com/index')

    results_links = page.links.find_all { |l| l.href.include? 'event?e=' }

    puts results_links

    results_links.each do |l|
      tournament_result = l.click
      download = tournament_result.links.find_all { |l| l.href.include? 'dec?' }
      puts download[0].href
      Deck.parse_deck(download[0].href)
    end

  end

  private

  def self.parse_deck(href)
    raw = RestClient::Request.execute(method: :get, url: "http://mtgtop8.com/#{href}")

    deck_array = raw.body.gsub("// ", "").gsub("/ ", "// ").to_s.split("\r\n").drop(1)
    deck = {"cards" => {"mainboard" => {}, "sideboard" => {}} }


    deck_array.each do |e|
      if  /SB/ =~ e[0,2]
        deck["cards"]["sideboard"][e[/(?<=\] ).+/]] = e.delete("^0-9")
      elsif /\d/ =~ e.first
        deck["cards"]["mainboard"][e[/(?<=\] ).+/]] = e.delete("^0-9")
      else
        deck[e[/^[^\ :]*/].downcase] = e[/(?<=: ).+/]
      end
    end

    @deck = Deck.new(
     name: deck["name"],
     format_id: Format.find_by(name: deck["format"]).id,
     user_id: User.find_by(name: "admin").id,
     creator: deck["creator"],
     tournament: true
    )
    if @deck.save

      deck["cards"].each do |board, cards|

        sideboard = board == "sideboard"
        cards.each do |name, count|
          puts name
          @new_deck_card = DeckCard.new(
            deck_id: @deck.id,
            # card_id: Card.wildcard("cards.name", name)[0].id,
            card_id: Card.where("name LIKE ?", "%#{name}%")[0].id,
            card_count: count == nil ?  1 : count,
            sideboard: sideboard
          )
          @new_deck_card.save
        end
      end
    else

    end

    @deck.save

    puts deck
  end

end
