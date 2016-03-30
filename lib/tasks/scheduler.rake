#1. get a list of addresses already assigned and put them in an array
#2. pull unassigned leads and compare each to existing addresses
#3. if unassigned, assign to agent and then send email to agent

	task assign_leads: :environment do #change environment to development
		assigned_addresses = Zestimate.where('assigned_agent IS NOT NULL').pluck('DISTINCT street')
		unassigned_addresses = Zestimate.where('assigned_agent IS NULL').pluck('DISTINCT street',:id)
		unassigned_addresses.each do |address, id|
			if assigned_addresses.include?address
				# do nothing, it's already been covered
				puts "doing nothing"
			else
				@zestimate = Zestimate.find(id)
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
				AgentMailer.lead_email(id,name,email,contact,street,city,state,zipcode,property_type,zestimate_value,zestimate_low,zestimate_high,agent_contact,market_report).deliver_now
				puts "sending email"
			end
		end	
	end


