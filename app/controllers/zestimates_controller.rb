class ZestimatesController < ApplicationController
	# done 2/28.16 -- change to postgres database (to prepare for heroku deployment) ok 2/27/16 // 
	# remember to turn on/connect to the postgres database after starting up the rails server -- is there a way to automate this?

	# done 3.13.16 -- add personal contact info on main form and save it (and other info) to database
	# done 3.13.16 -- send email to random agent with all of the contact info
	# done 3.14.16 -- error handling is not working on submission page
	# zillow branding on results form (per api request)
	# zillow (and/or my own) error handling and required fields
	# implement split gem for basic testing (cosmetic changes)
	# implement split gem for different flows (consult with mlm)
	# deploy to heroku
	# set up tests

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
			flash[:danger] = "Please enter a valid street address along wtih a city and state OR zipcode"
			redirect_to zestimates_path
		else
			#flash[:error] = "this is our message"
			@call_url = url + "?zws-id=" + @ID + "&address=" + street + "&citystatezip=" + city + state + zipcode
			@doc = Nokogiri::HTML(open(@call_url))
			@code = @doc.at_xpath("//code").content
			# flash[:error] = @code
			if @code != "0"
				flash[:danger] = "Please enter a valid street address along wtih a city and state OR zipcode"
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
				@zestimate.save
				@zestimate.update_attributes(:property_type => @property_type, :zestimate_value => @zestimate_value, :zestimate_low => @zestimate_low, :zestimate_high => @zestimate_high)
				#@zestimate = Zestimate.new(name: name, email: email, street: @street, city: @city, state: @state, zipcode: @zipcode, property_type: @property_type)
			end	
		end

	end

	def edit
		@zestimate = Zestimate.find(params[:id])
		@agent_contact = @zestimate.agent_contact
		@market_report = @zestimate.market_report
		@contact = @zestimate.contact
		@email = @zestimate.email
		@name = @zestimate.name
		@street = @zestimate.street
		@city = @zestimate.city
		@state = @zestimate.state
		@zipcode = @zestimate.zipcode
		@property_type = @zestimate.property_type
		@zestimate_value = @zestimate.zestimate_value
		@zestimate_low = @zestimate.zestimate_low
		@zestimate_high = @zestimate.zestimate_high
	end

	def update
		@title = "Thank you!"
		@zestimate = Zestimate.find(params[:id])
		agent_contact = @zestimate.agent_contact
		market_report = @zestimate.market_report
		contact = @zestimate.contact
		email = @zestimate.email
		name = @zestimate.name
		street = @zestimate.street
		city = @zestimate.city
		state = @zestimate.state
		zipcode = @zestimate.zipcode
		property_type = @zestimate.property_type
		zestimate_value = @zestimate.zestimate_value
		zestimate_low = @zestimate.zestimate_low
		zestimate_high = @zestimate.zestimate_high
		
		

		if @zestimate.update_attributes(zestimate_params)
			@zestimate = Zestimate.find(params[:id])
			market_report = @zestimate.market_report
			agent_contact = @zestimate.agent_contact
			email = @zestimate.email
			contact = @zestimate.contact
			if email == ""
				flash[:danger] = "Please enter an email or contact info if you would like to receive market reports or be contacted by an agent"
				redirect_to zestimate_path action: "update", id: params[:id]
			elsif market_report == "1" && agent_contact == "1" & email 
				flash.now[:success] = "Thanks! An agent will be in touch shortly and you'll receive your first market report soon" 
			elsif market_report == "1" && agent_contact == ""
				flash.now[:success] = "Thanks! You'll receive your first market report shortly."
			else
				flash.now[:success] = "Thanks! An agent will be in touch with you shortly"
			end
		AgentMailer.lead_email(name,email,contact,street,city,state,zipcode,property_type,zestimate_value,zestimate_low,zestimate_high,agent_contact,market_report).deliver_now
		else
			render 'edit'
		end

	end


private	
	
	def zestimate_params
		params.require(:zestimate).permit(:name, :email, :street, :city, :state, :zipcode, :property_type, :agent_contact, :market_report, :contact, :comments)
	end	

end
