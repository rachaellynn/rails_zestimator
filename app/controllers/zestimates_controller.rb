class ZestimatesController < ApplicationController
	# next steps as of 2/26
	# 1. change to postgres database (to prepare for heroku deployment) ok 2/27/16 // 
	# remember to turn on/connect to the postgres database after starting up the rails server -- is there a way to automate this?

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
		street = params[:zestimate][:street]
		city = params[:zestimate][:city]
		state = params[:zestimate][:state]
		zipcode = params[:zestimate][:zipcode]
		name = params[:zestimate][:name]
		email = params[:zestimate][:email]
		
		@title = 'Your Home Value Estimate'
		#call the zillow api
		@ID = ENV["zillow_api_id"]
		#@ID = Figaro.env.zillow_api_id
		#url = 'http://www.zillow.com/webservice/GetSearchResults.htm'
		url = 'http://www.zillow.com/webservice/GetDeepSearchResults.htm' #alternate URL with more data to be used later . . . include usecode, number of bedrooms, last sale date, 
		# read more here: http://www.zillow.com/howto/api/GetDeepSearchResults.htm
		if street == "" || zipcode == ""
			flash[:error] = "No street or Zip -- Please enter a valid street address along wtih a city and state OR zipcode"
			redirect_to zestimates_path
		else
			#flash[:error] = "this is our message"
			@call_url = url + "?zws-id=" + @ID + "&address=" + street + "&citystatezip=" + city + state + zipcode
			@doc = Nokogiri::HTML(open(@call_url))
			@code = @doc.at_xpath("//code").content
			# flash[:error] = @code
			if @code != "0"
				flash[:error] = "Please enter a valid street address along wtih a city and state OR zipcode" + @call_url
					#flash[:error] = @call_url
				redirect_to zestimates_path
			else
				@street = @doc.at_xpath("//street").content
				@city = @doc.at_xpath("//city").content
				@state = @doc.at_xpath("//state").content
				@zipcode = @doc.at_xpath("//zipcode").content
				@zestimate_value = @doc.at_xpath("//amount").content
				@zestimate_low = @doc.at_xpath("//low").content
				@zestimate_high = @doc.at_xpath("//high").content
				@property_type = @doc.at_xpath("//usecode")
				@property_type = /([A-Z][a-zA-Z\d]+)/.match(@property_type)[0]
				@zestimate = Zestimate.new(zestimate_params)
				@zestimate.update_attribute(:property_type, @property_type)
				#@zestimate = Zestimate.new(name: name, email: email, street: @street, city: @city, state: @state, zipcode: @zipcode, property_type: @property_type)
				@zestimate.save
			end	
		end

	end

	def edit
  		@zestimate = Zestimate.find(params[:id])
	end

	def update
		@zestimate = Zestimate.find(params[:id])
		agent_contact = params[:zestimate][:agent_contact]
		market_report = params[:zestimate][:market_report]
		contact = params[:zestimate][:contact]
		@property_type = "single family"
		if @zestimate.update_attribute(:property_type, @property_type)
			@message0 = "property type updated"
		end

		if @zestimate.update_attributes(zestimate_params)
				@message1 = "An agent will be in touch with you soon."
		elsif @market_report != ""
				@message2 = "You'll receive your first monthly market report shortly"
		# handle a successful update
		else
			render 'edit'
		end

	end
  # def update
  #   @user = User.find(params[:id])
  #   if @user.update_attributes(user_params)
  #     # Handle a successful update.
  #   else
  #     render 'edit'
  #   end
  # end



private	
	
	def zestimate_params
		params.require(:zestimate).permit(:name, :email, :street, :city, :state, :zipcode, :property_type, :agent_contact, :market_report, :contact, :comments)
	end	

end
