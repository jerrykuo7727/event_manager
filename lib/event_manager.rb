require "csv"

puts "EventManager initialized."

contents = CSV.open("../event_attendees.csv", headers: true, header_converters: :symbol)

contents.each do |row|
  name = row[:first_name]
  zipcode = row[:zipcode]

  # if the zip code is exactly five digits, assume that it is ok
  # if the zip code is more than 5 digits, truncate it to the first 5 digits
  # if the zip code is less than 5 digits, add zeros to the front until it becomes five digits
  if zipcode.length < 5
    zipcode = zipcode.rjust(5, "0")
  elsif zipcode.length > 5
    zipcode = zipcode[0..4]
  end

  puts "#{name} #{zipcode}"
end