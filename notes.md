<div class="row">
  <div class="col-md-12">
  <h3>for <%= @street %> <%= @city %>, <%= @state %>  <%= @zipcode %></h3>
  </div>
</div> 

<div class="row">

	<div class="col-md-4">
		low zestimate<br>
		<%= @zestimate_low %>
	</div>

	<div class="col-md-4">
		<h2>Your Zestimate<br>
		<%= @zestimate %></h2>
	</div>

	<div class="col-md-4">
		high zestimate<br>
		<%= @zestimate_high %>
	</div>

</div>	