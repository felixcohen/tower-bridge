#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"
Bundler.require(:default)

PATH_PREFIX = File.expand_path(File.dirname(__FILE__))


URL = PATH_PREFIX + "/schedule.htm"
MINUTE = 60

doc = Nokogiri::HTML(open(URL))

rows = doc.search("table tr")
rows.shift

output = []

rows.each do |row|
  cells = row.search("td")
  timestring = (cells[0].inner_html + " " + cells[1].inner_html + " " + cells[2].inner_html).gsub("&nbsp;", " ")
  time = Time.parse(timestring)
  vessel = cells[3].inner_html
  direction_of_vessel = cells[4].inner_html.downcase
  unless direction_of_vessel.match("stream")
    direction_of_vessel = direction_of_vessel + "stream"
  end
  output << {:vessel => vessel, :action => "opening", :time => (time - 5*MINUTE), :direction_of_vessel => direction_of_vessel}
  output << {:vessel => vessel, :action => "closing", :time => (time + 5*MINUTE), :direction_of_vessel => direction_of_vessel}
end

next_event = output.select {|event| event[:time] <= (Time.now + MINUTE) and event[:time] >= Time.now}.first

get "/" do
  if next_event
    case next_event[:action]
    when "opening"
        "2"
    when "closing"
        "1"
    end
  else
    "0"    
  end
end

