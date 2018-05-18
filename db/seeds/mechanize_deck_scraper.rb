require 'rubygems'
require 'mechanize'


def parse_deck(href)
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

   puts deck
end

agent = Mechanize.new

page = agent.get('http://mtgtop8.com/index')

results_links = page.links.find_all { |l| l.href.include? 'event?e=' }

puts results_links

results_links.each do |l|
  tournament_result = l.click
  download = tournament_result.links.find_all { |l| l.href.include? 'mtgo?d=' }
  puts download[0].href
  parse_deck(download[0].href)
end
