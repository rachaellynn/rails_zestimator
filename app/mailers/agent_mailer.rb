class AgentMailer < ApplicationMailer
  default from: 'info@eplacehomes.com'
  helper ZestimatesHelper

  def lead_email(name,email,contact,street,city,state,zipcode,property_type,zestimate_value,zestimate_low,zestimate_high,agent_contact,market_report)
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
    agents = { '1' => 'rachael@wordaroundtown.com', '2' => 'rachael@eplacehomes.com'}
  	email = agents["1"]
  	mail(to: email, subject: 'Home Valuation Lead')
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
