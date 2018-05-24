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
  scope :basic_wildcard, -> (arg) { order(name: :asc).where("(cards.name LIKE ? OR cards.full_type LIKE ?) AND cards.last_printing NOT IN ('UNH', 'UGL', 'UST') AND cards.layout NOT IN ('token', 'scheme')", "%#{arg}%", "%#{arg}%").limit(100)}

  def mainboard_deck_card_count(deck_id)
    self.deck_cards.find_by(deck_id: deck_id, sideboard: false).card_count
  end

  def self.search(params)
    if params[:term]
      @cards = Card.basic_wildcard(params[:term])
    end
    @cards
  end

  # def self.basic_wildcard(arg)
  #   sql = <<-SQL
  #     SELECT
  #       cards.*,
  #       magic_sets.code AS set_code
  #     FROM cards
  #     INNER JOIN magic_sets ON
  #     cards.magic_set_id = magic_sets.id
  #     WHERE
  #     cards.name LIKE ?
  #     OR cards.full_type LIKE ?
  #     ORDER BY cards.name ASC
  #     LIMIT 50
  #   SQL
  #   Card.find_by_sql [sql, "%#{arg}%", "%#{arg}%"]
  # end

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
      card_info = card[:info]
      # found = Card.find_by(name: card_info[:name])
      # if card[:name].length > 0 && !Card.find_by(name: card[:name])
      if !Card.find_by(name: card_info[:name])
        failed_card_keys.push(card[:key])
      end
    end
    failed_card_keys
  end


end
