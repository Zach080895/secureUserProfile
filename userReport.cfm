<!DOCTYPE html>
<html>
<head>
	<title>
		User Report
	</title>
	<!--- Including the styles --->
	<cfinclude template="style.cfm">
	
	<!--- Script used for the search bar to search the table --->
	<script>
		$(document).ready(function(){
	  		$("#myInput").on("keyup", function() {
	    		var value = $(this).val().toLowerCase();
	    		$("#myTable tr").filter(function() {
	      			$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
	    		});
	  		});
		});
	</script>
	
	<!--- Script used to sort the table --->
	<script src="JS/sorttable.js"></script>
</head>
<body>
	<!--- including the header file --->
	<cfinclude template="header.cfm">
	
	<!--- Checking if invalide access to link --->
	<cfif checkAdmin.recordCount GT 0>
		<!--- Query to get all users --->
		<cfquery name="getAllUsers" datasource="securePortal">
			Select *
			From Users with(nolock)
			Order by firstName, lastName
		</cfquery>
		
		<div class="container">
			<cfoutput>
				<h2 class="text-#defaultColor# text-center">User Report</h2>
			</cfoutput>
	  		<div class="table-responsive">
		  		<input class="form-control" id="myInput" type="text" placeholder="Search..">
		  		<!--- displaying the result from the above query in below table --->
		  		<table class="table table-striped sortable">
		  			<thead>
		  				<tr>
			  				<th>First Name</th>
			  				<th>Last Name</th>
			  				<th>Email</th>
			  				<th>Phone Number</th>
			  			</tr>
		  			</thead>
		  			 <tbody id="myTable">
		  				<cfoutput query="getAllUsers">
			  				<tr>
			  					<td>#firstName#</td>
			  					<td>#lastName#</td>
			  					<td>#Email#</td>
			  					<td>#phoneNumber#</td>
			  				</tr>
			  			</cfoutput>	
		  			</tbody>
		    	</table>
		    </div>
		</div>
	<cfelse>
		<div class="container">
			<div class="text-center">
				<h3 class="text-danger">You have entered this page in error.</h3>
				<h5>Pleaee return to your profile.</h5>
			</div>
		</div>
	</cfif>
</body>
</html>