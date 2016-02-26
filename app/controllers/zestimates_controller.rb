class ZestimatesController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	require 'open-uri'

	def index
	  	@title = "Your Home Price Estimator"
	end

	def create
	 	#pull data from the form
		params.inspect
		street = params[:street]
		city = params[:city]
		state = params[:state]
		zipcode = params[:zipcode]

		@title = 'Your Home Value Estimate'
		#call the zillow api
		@ID = ENV["zillow_api_id"]
		#@ID = Figaro.env.zillow_api_id
		#@ID = "X1-ZWz19un24nbeh7_4bx42"
		url = 'http://www.zillow.com/webservice/GetSearchResults.htm'
		@call_url = url + "?zws-id=" + @ID + "&address=" + street + "&citystatezip=" + city + state + zipcode
		@doc = Nokogiri::HTML(open(@call_url))
		@street = @doc.at_xpath("//street").content
		@city = @doc.at_xpath("//city").content
		@state = @doc.at_xpath("//state").content
		@zipcode = @doc.at_xpath("//zipcode").content
		@zestimate = @doc.at_xpath("//amount").content
		@zestimate_low = @doc.at_xpath("//low").content
		@zestimate_high = @doc.at_xpath("//high").content
	end

end
