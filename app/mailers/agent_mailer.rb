class AgentMailer < ApplicationMailer
  default from: 'info@eplacehomes.com'
  helper ZestimatesHelper

  def lead_email(id,name,email,contact,street,city,state,zipcode,property_type,zestimate_value,zestimate_low,zestimate_high,agent_contact,market_report)
    @id = id
    @name = name
    @email = email
    @contact = contact
    @street = street
    @city = city
    @state = state
    @zipcode = zipcode
    @property_type = property_type
    @zestimate_value = zestimate_value
    @zestimate_low = zestimate_low
    @zestimate_high = zestimate_high
    @agent_contact = agent_contact
    @market_report = market_report
    #@agent_contact = { '1' => 'rachael@wordaroundtown.com', '2' => 'rachael@eplacehomes.com'}
  	random = Random.new
    random = random.rand(1..2).to_s #set max range to the number of agents in the hash
    #email = agents[random]
    @assigned_agent = "rachael@wordaroundtown.com"
    @zestimate = Zestimate.find(@id)
    @zestimate.update_attributes(assigned_agent: @assigned_agent)
  	mail(to: @agent_contact, subject: 'Home Valuation Lead')
  end

end

# example from sass_rails project
# class ContactMailer < ActionMailer::Base
#     default to: 'rachaellburger@gmail.com'
    
#     def contact_email(name, email, body)
#         @name = name
#         @email = email
#         @body = body
        
#         mail(:from => email, subject: 'message from contact form')
#     end
    
# end
