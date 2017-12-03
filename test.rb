require 'icalendar'

event_file = File.open("download.ics")

events = Icalendar::Event.parse(event_file)

# massive placeholder
eventarray = Hash.new

events.each do |event|
  # just an array keyed by the start date.
  # we don't need the description for now
  # eventarray[event.dtstart] = [event.summary, event.description]
  eventarray[event.dtend] = event.summary

  # puts "start date-time: #{event.dtstart}"
  # puts "END date-time: #{event.dtend}"
  #
  # #puts "start date-time timezone: #{event.dtstart.ical_params['tzid']}"
  # puts "summary: #{event.summary}"
end

# to get just the year: .strftime("%Y")
# just the month t.strftime("%m")
# just the day t.strftime("%d")
# eyear=event.dtstart.strftime("%Y")

# sort it by date!
eventarray = eventarray.sort

# set up some variables before we start.
currentYear = 2017
currentMonth = 12
puts "<pre>"
puts eventarray.length

eventarray.each { |eventdate,item|
  incomingYear=eventdate.strftime("%Y")
  incomingMonth=eventdate.strftime("%m")

  # start a new year if it doesn't match
  if incomingYear != currentYear
    currentYear=eventdate.strftime("%Y")
    puts "\n\n\n#{currentYear}"
    puts "==========================================\n"
  end

  # start a new month if it doesn't match
  if incomingMonth != currentMonth
    currentMonth=eventdate.strftime("%m")
    puts "\n#{eventdate.strftime('%B')}" # full word-name of the month
    puts "==============\n"
  end

  # print the item itself
  puts "#{eventdate.strftime('%d')} - #{item}"


#  currentYear=eventdate.strftime("%Y")
}
puts "</pre>"

### AS A 13-column TABLE
currentYear = 2017
currentMonth = 1
colCount=1
# there's a fast ruby way for this but, meh.
puts "<table border =1 ><tr><td></td><td>January</td><td>February</td><td>March</td><td>April</td><td>May</td><td>June</td><td>July</td><td>August</td><td>September</td><td>October</td><td>November</td><td>December</td>"

puts "<tr><td>#{currentYear}</td>"
eventarray.each { |eventdate,item|
  incomingYear=eventdate.strftime("%Y")
  incomingMonth=eventdate.strftime("%m")

  # start a new year if it doesn't match
  if incomingYear != currentYear
    # start new table row, close where we are
    currentYear=eventdate.strftime("%Y")
    puts "</tr><tr><td>#{currentYear}</td><td>"
    # restart currentMonth to Jan
    currentMonth = 1
  end

  # start a new month if it doesn't match
  if incomingMonth != currentMonth
    # the difference in #s is the number of cells we need to open and close.
    diff = (incomingMonth.to_i - currentMonth.to_i)
    currentMonth=eventdate.strftime("%m")
    diff.times do
      puts "</td><td>" # full word-name of the month
    end
  end

  # print the item itself
  puts "#{eventdate.strftime('%m-%d')} - #{item}<br/>"


#  currentYear=eventdate.strftime("%Y")
}
puts "</table>"
