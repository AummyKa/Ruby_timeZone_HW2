require 'sinatra'
require 'timezone'

get'/' do
  erb :form
end

post '/Your friend timezone' do
	begin
	input_city = params[:user_city]
	input_check = input_city.split(' ')
	timezones = Timezone::Zone.names
	find_zone = timezones.find { |e| /#{input_city}/ =~ e } 
	timezone = Timezone::Zone.new :zone => find_zone
	time_only = timezone.time Time.now
	city_time = time_only.to_s.split(' ')
	time =  city_time[1]
	time_split = time.split(':')
	hours = time_split[0]
	minutes = time_split[1]
	if hours.to_i > 12 
		actual_hours = hours.to_i - 12
		suffix = "PM"
	else 
		actual_hours = hours
		suffix = "AM"
	end
	 "The current time in #{params[:user_city]} is: " + "<br>" + "<br>" + "<br>" + actual_hours.to_s + ":" + minutes.to_s + suffix
end
end


