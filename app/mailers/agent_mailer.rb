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

    #select agent for email lead
    # @@agent_id ||= 1 #set initial agent id
    # #agent_hash = { 1 => 'rachael@eplacehomes.com', 2 => 'rachaellburger@gmail.com', 3 => 'rachael@wordaroundtown.com'}
    # agent_hash = { 1 => 'herb@eplacehomes.com', 2 => 'jasmin.lucci@eplacehomes.com', 3 => 'jennifer.keenan@eplacehomes.com', 4 => 'john.turner@eplacehomes.com', 5 => 'michael.pfister@eplacehomes.com', 6 => 'ryan.pietras@eplacehomes.com', 7 => 'victor.divine@eplacehomes.com'}
    # @assigned_agent = agent_hash[@@agent_id]
    # @@agent_id < 7? @@agent_id += 1: @@agent_id = 1

    #redoing agent assigned to use a database so that variable are persistent/round robin works well
    @agent = Agent.find_by lead_rotation:1
    @assigned_agent = @agent.email
    
    #update the assigned agent and send the email to the agent and to "info"
    @zestimate = Zestimate.find(@id)
    @zestimate.update_attributes(assigned_agent: @assigned_agent)
    (@market_report == 1 || @agent_contact == 1)? @subject = 'URGENT Home Valuation Lead': @subject = 'Home Valuation Lead'
    mail(to: "#{@assigned_agent}, info@eplacehomes.com", subject: @subject)
    # 1. change the lead_rotation of the agent just emailed to 0
    @agent.update_attributes(lead_rotation:0)   
    # 2. figure out new agent ID
    @agent.id == 5? @id = 1: @id = @agent.id += 1
    # 3. update the info
    @agent = Agent.find(@id)
    @agent.update_attributes(lead_rotation:1)
  end

end

