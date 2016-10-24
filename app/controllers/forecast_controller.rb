require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

@url = "https://api.darksky.net/forecast/3fae4268941ae87cbeb42d5c856a25c1/" + @lat + "," + @lng
@parsed_data = JSON.parse(open(@url).read)

    @current_temperature = @parsed_data["currently"]["temperature"]

    @current_summary = "Replace this string with your answer."

    @summary_of_next_sixty_minutes = "Replace this string with your answer."

    @summary_of_next_several_hours = "Replace this string with your answer."

    @summary_of_next_several_days = "Replace this string with your answer."

    render("forecast/coords_to_weather.html.erb")
  end
end
