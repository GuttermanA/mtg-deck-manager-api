#GETS DECK FROM MTG mtgtop8 AND PARSES INTO AN OBJECT

def self.parse_deck(href)
  raw = RestClient::Request.execute(
             method: :get,
             url: "http://mtgtop8.com/#{href}"
           )

   main = raw.to_s.split("Sideboard")[0].split("\r\n")
   sideboard = raw.to_s.split("Sideboard")[1].split("\r\n")
   deck = {main:{}, sideboard:{}}
   main.each do |card|
     card_name = card[/\D+/].strip
     number = card[/\d+/]
     deck[:main][card_name] = number.to_i
   end

   sideboard.each do |card|
     if !card.empty?
       card_name = card[/\D+/].strip
       number = card[/\d+/]
       deck[:sideboard][card_name] = number.to_i
     end
   end

   deck
end
