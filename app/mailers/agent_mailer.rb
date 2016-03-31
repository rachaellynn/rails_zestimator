class AgentMailer < ApplicationMailer
  default from: 'ePlace Leads <info@eplacehomes.com>'
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

    #select agent to email to
    @@agent_id ||= 1 #set initial agent id
    agent_hash = { 1 => 'rachael@eplacehomes.com', 2 => 'rachaellburger@gmail.com'}
    #agent_hash = { 1 => 'herb@eplacehomes.com', 2 => 'jasmin.lucci@eplacehomes.com', 3 => 'jennifer.keenan@eplacehomes.com', 4 => 'john.turner@eplacehomes.com', 5 => 'michael.pfister@eplacehomes.com', 6 => 'ryan.pietras@eplacehomes.com', 7 => 'victor.divine@eplacehomes.com'}
    @assigned_agent = agent_hash[@@agent_id]
    @@agent_id < 2? @@agent_id += 1: @@agent_id = 1
    
    #@agent_contact = { '1' => 'rachael@wordaroundtown.com', '2' => 'rachael@eplacehomes.com'}
  	random = Random.new
    random = random.rand(1..2).to_s #set max range to the number of agents in the hash
    #email = agents[random]
    #@assigned_agent = "rachael@wordaroundtown.com"
    @zestimate = Zestimate.find(@id)
    @zestimate.update_attributes(assigned_agent: @assigned_agent)
    #email_with_name = %("#{@user.name}" <#{@user.email}>)
    #mail(to: email_with_name, subject: 'Welcome to My Awesome Site')
    (@market_report == 1 || @agent_contact == 1)? @subject = 'URGENT Home Valuation Lead': @subject = 'Home Valuation Lead'
  	#mail(to: @assigned_agent, subject: @subject)
    mail(to: "#{@assigned_agent}, rachaellburger+test@gmail.com", subject: @subject)
    #mail(to: 'rachaellburger@gmail.com',subject: 'HVL for ' + @assigned_agent) #sends a copy of the email to Denise
    ## use info there
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
