class ZestimatesController < ApplicationController
	# next steps as of 2/26
	# change to postgres database (to prepare for heroku deployment) ok 2/27/16
	# add personal contact info on main form and save it (and other info) to database
	# zillow branding on results form (per api request)
	# zillow (and/or my own) error handling and required fields
	# implement split gem for basic testing (cosmetic changes)
	# implement split gem for different flows (consult with mlm)

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
