require 'open-uri'
require 'nokogiri'
require 'byebug'

url = 'https://ria.ru'

html = open(url)
doc = Nokogiri::HTML(html)

news = doc.css('.cell-list__item-title')

10.times do |i|
  puts news[i].text
end


