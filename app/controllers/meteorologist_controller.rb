require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    @street_address_without_spaces = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the variable @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the variable @street_address_without_spaces.
    # ==========================================================================

@url_geo = "https://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address_without_spaces + "&key="
@parsed_geo_data = JSON.parse(open(@url_geo).read)
@lat = (@parsed_geo_data["results"][0]["geometry"]["location"]["lat"]).to_s
@lng = (@parsed_geo_data["results"][0]["geometry"]["location"]["lng"]).to_s
@url_weather = "https://api.darksky.net/forecast/3fae4268941ae87cbeb42d5c856a25c1/" + @lat + "," + @lng
@parsed_weather_data = JSON.parse(open(@url_weather).read)

    @current_temperature = @parsed_weather_data["currently"]["temperature"]

    @current_summary = @parsed_weather_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = @parsed_weather_data["minutely"]["summary"]

    @summary_of_next_several_hours = @parsed_weather_data["hourly"]["summary"]

    @summary_of_next_several_days = @parsed_weather_data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
