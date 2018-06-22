class Deck < ApplicationRecord
  belongs_to :user
  belongs_to :format
  has_many :deck_cards, dependent: :delete_all
  has_many :cards, through: :deck_cards
  belongs_to :event, required: false
  validates :name, :format, presence: true

  # scope :basic_wildcard, -> (term) { order(created_at: :desc).joins(:format, :user).where("name LIKE ? OR archtype LIKE ?", "%#{term}%", "%#{term}%")}

  before_save :card_count_calculator


  def card_count_calculator
    self.total_mainboard = DeckCard.where(deck_id: self.id, sideboard: false).sum(:card_count)
    self.total_sideboard = DeckCard.where(deck_id: self.id, sideboard: true).sum(:card_count)
    self.total_cards = self.total_mainboard + self.total_sideboard
  end

  def self.basic_wildcard(term, user_id = nil)
    if user_id
      Deck.order(created_at: :desc).joins(:format, :user).where("decks.name LIKE ? OR decks.archtype LIKE ?", "%#{term}%", "%#{term}%").select('decks.*, formats.name AS format_name, users.name AS user_name').references(:format, :user).limit(50)
    else
      Deck.order(created_at: :desc).joins(:format, :user).where("(decks.name LIKE ? OR decks.archtype LIKE ?) AND decks.user_id <> ?", "%#{term}%", "%#{term}%", user_id).select('decks.*, formats.name AS format_name, users.name AS user_name').references(:format, :user).limit(50)
    end
  end

  def self.default_search(user_id = nil)
    if user_id
      Deck.order(created_at: :desc).joins(:format, :user).where("decks.user_id <> ?").select('decks.*, formats.name AS format_name, users.name AS user_name').references(:format, :user).limit(50)
    else
      Deck.order(created_at: :desc).joins(:format, :user).select('decks.*, formats.name AS format_name, users.name AS user_name').references(:format, :user).limit(50)
    end
  end

  def self.by_id(deck_id)
    Deck.joins(:format, :user).where(id: deck_id).select('decks.*, formats.name AS format_name, users.name AS user_name').references(:format, :user)[0]
  end

  def self.mtgtop8_scrape_homepage_decks
    agent = Mechanize.new

    page = agent.get('http://mtgtop8.com/index')

    results_links = page.links.find_all { |l| l.href.include? 'event?e=' }

    puts results_links

    results_links.each do |l|
      tournament_result = l.click
      doc = tournament_result.parser
      #event_info is a td element with a class of S14. After retrieval, the rest of the steps are to parse out extraneous chars.
      event_info = doc.css('td.S14').inner_text.strip.gsub(/[\r\n\t]/, " ").split("  ")[0].gsub("players - ","")

      @event = Event.find_or_create_by(name: tournament_result.title[/[^@]+/].strip)

      @event.add_attributes_from_string(event_info)
      download = tournament_result.links.find_all { |l| l.href.include? 'dec?' }
      puts download[0].href
      @deck = Deck.parse_deck(download[0].href)
      @deck.event = @event
      @deck.save!

    end

  end

  private

  def self.parse_deck(href)
    raw = RestClient::Request.execute(method: :get, url: "http://mtgtop8.com/#{href}")

    deck_array = raw.body.gsub("// ", "").gsub("/ ", "// ").to_s.split("\r\n").drop(1)
    deck = {"cards" => {"mainboard" => {}, "sideboard" => {}} }


    deck_array.each do |e|
      if  /SB/ =~ e[0,2]
        deck["cards"]["sideboard"][e[/(?<=\] ).+/]] = e[/\d+?(?= \[)/]
      elsif /\d/ =~ e.first
        deck["cards"]["mainboard"][e[/(?<=\] ).+/]] = e[/\d+?(?= \[)/]
      else
        deck[e[/^[^\ :]*/].downcase] = e[/(?<=: ).+/]
      end
    end
    byebug
    @deck = Deck.new(
     name: deck["name"],
     format_id: Format.find_or_create_by(name: deck["format"]).id,
     user_id: User.find_by(name: "admin").id,
     creator: deck["creator"].gsub('_', ' '),
     tournament: true
    )
    if @deck.save!

      deck["cards"].each do |board, cards|

        sideboard = board == "sideboard"
        cards.each do |name, count|
          puts name
          card = Card.where("cards.name = ? AND cards.last_printing NOT IN ('UNH', 'UGL', 'UST')", name).first || Card.where("name LIKE ?", "#{name}%").first
          @new_deck_card = DeckCard.new(
            deck_id: @deck.id,
            # card_id: Card.wildcard("cards.name", name)[0].id,
            card_id: card.id,
            card_count: count == nil ?  1 : count,
            sideboard: sideboard
          )
          @new_deck_card.save!
        end
      end
    else
      puts "Deck failed to save"
    end

    @deck.save!

    puts deck
    @deck
  end

end
