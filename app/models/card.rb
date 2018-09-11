class Card < ApplicationRecord
  # belongs_to :magic_set
  has_many :collections
  has_many :deck_cards
  has_many :decks, through: :deck_cards
  has_many :card_formats
  has_many :formats, through: :card_formats

  has_and_belongs_to_many :colors
  has_and_belongs_to_many :magic_sets
  has_and_belongs_to_many :supertypes
  has_and_belongs_to_many :types
  has_and_belongs_to_many :subtypes

  validates :name, uniqueness: true
  validates :img_url, presence: true
  # joins is inner join
  # includes is left join
  scope :default_search, -> {}
  scope :colors, -> (colors) { joins(:colors).where('colors.name': colors).references(:colors) }
  scope :wildcard, -> (column, arg) { where("(#{column} LIKE ?", "%#{arg}%")}
  scope :basic_wildcard, -> (arg) { order(name: :asc).where("(cards.name LIKE ? OR cards.full_type LIKE ?) AND cards.last_printing NOT IN ('UNH', 'UGL', 'UST', 'VAN') AND cards.layout NOT IN ('token', 'scheme')", "%#{arg}%", "%#{arg}%").limit(100)}

  def mainboard_deck_card_count(deck_id)
    self.deck_cards.find_by(deck_id: deck_id, sideboard: false).card_count
  end

  def self.search(params)
    if params[:term]
      @cards = Card.basic_wildcard(params[:term])
    end
    @cards
  end

  def self.default_search
    most_recent_set = MagicSet.order(release_date: :desc).limit(1)[0].code
    Card.order(name: :asc).where(last_printing: most_recent_set).limit(50)
  end

  def self.get_collection_cards_by_user(user_id)
    sql = <<-SQL
      SELECT
      collections.id,
      cards.name,
      cards.mana_cost,
      cards.cmc,
      cards.full_type,
      cards.rarity,
      cards.text,
      cards.flavor,
      cards.artist,
      cards.number,
      cards.power,
      cards.toughness,
      cards.loyalty,
      cards.img_url,
      cards.multiverse_id,
      cards.layout,
      collections.count,
      collections.premium,
      collections.condition,
      collections.wishlist,
      collections.updated_at,
      magic_sets.name AS set_name,
      magic_sets.code AS set_code
      FROM cards
      INNER JOIN collections ON
      cards.id = collections.card_id
      INNER JOIN magic_sets ON
      magic_sets.id = collections.magic_set_id
      WHERE
      collections.user_id = ?
    SQL
    Card.find_by_sql [sql, user_id]
    # Card.joins(:magic_sets, :collections).where('collections.user_id': 1).references(:collections)
  end

  def self.validate_card_names(cards)
    failed_card_keys = []
    cards.each do |card|
      # card_info = card[:info]
      # found = Card.find_by(name: card_info[:name])
      # if card[:name].length > 0 && !Card.find_by(name: card[:name])
      if !Card.find_by(name: card[:name])
        failed_card_keys.push(card[:key])
      end
    end
    failed_card_keys
  end

  def add_types(card_data)
    if card_data.types
      card_data.types.each do |type|
        self.types.push(Type.find_or_create_by(name: type))
      end
      new_card_types = self.types.map { |t| t.name }
      if new_card_types.include?("Creature")
        self.primary_type = "Creature"
      else
        self.primary_type = new_card_types.first
      end
      self.save
    end
  end

  def add_subtypes(card_data)
    if card_data.subtypes
      card_data.subtypes.each do |subtype|
        self.subtypes.push(Subtype.find_or_create_by(name: subtype))
      end
    end
  end

  def add_supertypes(card_data)
    if card_data.supertypes
      card_data.supertypes.each do |supertype|
        self.supertypes.push(Supertype.find_or_create_by(name: supertype))
      end
    end
  end

  def add_legalities(card_data)
    CardFormat.create(card_id: self.id, format_id: Format.find_or_create_by(name: "Casual").id, legal: true)
    if card_data.legalities
      card_data.legalities.each do |legality|
        if formats.include?(legality.format)
          legal = false
          if legality.legality == 'Legal'
            legal = true
          end
          CardFormat.find_or_create_by(card_id: self.id, format_id: Format.find_by(name: legality.format).id, legal: legal)
        end
      end
    end
  end

  def add_printings(card_data)
    if card_data.printings
      sets = MagicSet.add_sets_from_card_data(card_data)
      self.magic_sets.push(sets)
    end
  end

  def add_color(card_data)
    card_data.colors.each do |color|
      self.colors.push(Color.find_by(name: color))
    end
  end

  def self.seed(new_cards_dataset)
    counter = 0
    new_cards_dataset.each do |card_data|
      new_card = Card.new(
        name: card_data.names && card_data.names.length > 0 ? card_data.names.join(" // ") : card_data.name,
        mana_cost: card_data.mana_cost,
        cmc: card_data.cmc,
        full_type: card_data.type,
        rarity: card_data.rarity,
        text: card_data.text,
        flavor: card_data.flavor,
        artist: card_data.artist,
        number: card_data.number,
        power: card_data.power,
        toughness: card_data.toughness,
        loyalty: card_data.loyalty,
        img_url: card_data.image_url,
        multiverse_id: card_data.multiverse_id,
        layout: card_data.layout,
        last_printing: card_data.set
      )

      if new_card.save
        counter += 1
        puts "Created card: #{new_card.name}"

        new_card.add_supertypes(card_data)
        new_card.add_types(card_data)
        new_card.add_subtypes(card_data)
        new_card.add_printings(card_data)
        new_card.add_legalities(card_data)

      else
        puts "Failed to create #{new_card.name}. Errors: #{new_card.errors.full_messages}"
      end
    end
    counter
  end


end
