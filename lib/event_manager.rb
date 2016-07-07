require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def legislators_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

puts "EventManager initialized."

contents = CSV.open('../event_attendees.csv', headers: true, header_converters: :symbol)

template_letter = File.read("../form_letter.erb")
erb_template = ERB.new(template_letter)

contents.each do |row|
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])
  
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)
  puts form_letter
end