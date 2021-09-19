<!DOCTYPE html>
<html>
<head>
	<title>
		Secure Login
	</title>
	<!--- Including the styles --->
	<cfinclude template="style.cfm">
	
	<!--- Script to validate the form --->
	<script>
		function validateForm() {
  			var Email = document.forms["myForm"]["email"].value;
  			var Password = document.forms["myForm"]["pswd"].value;
  			var Message = "";
  			
  			if (Email == "") {
  				var Message = Message + "Email must be filled out";
  			}
  			
  			if (Password == "") {
  				if (Message == "") {
  					var Message = Message + "Password must be filled out";
  				} else {
  					var Message = Message + "\nPassword must be filled out";
  				}
  			}
  			
  			if (Message != "") {
  				alert(Message);
  				return false;
  			}
		}
	</script>
</head>
<body>
	
	<div class="container">
  		<h2 class="text-primary text-center">Secure Login</h2>
  		
  		<!--- Displaying a message if site is accessed invalid/time out --->
  		<cfif isdefined("cookie.message")>
  			<cfoutput>
  				<div class="text-center">
	  				<span class="text-warning">#cookie.message#</span>
	  			</div>
  			</cfoutput>
  			
  			<cfcookie name="message" value="" expires="NOW"> 
  		</cfif>
  		
  		<!--- checking to see if form is defined then verifing users exists and correct information was entered --->
  		<cfif isdefined("form.email")>
  			<cfquery name="checkUser" datasource="securePortal">
				Select firstName, lastName, Email
				From Users with(nolock)
				Where Email = '#form.Email#' and password = '#form.pswd#'
			</cfquery>
  			
			<cfif checkUser.recordCount GT 0>
				<cfcookie name="userEmail" value="#form.Email#" expires="1"> 
				
				<cflocation url="userProfile.cfm">
			<cfelse>
				<div class="text-center">
					<span class="text-danger">You have entered an invalid email or password please try agin.</span>
				</div>
			</cfif>
		</cfif>
  		
  		<!--- form to let the user login to the site --->
  		<cfform name="myForm" action="" onsubmit="return validateForm()" method="post">
    		<div class="border border-3 border-secondary rounded">
	    		<div class="container">
		    		<div class="form-group">
		      			<label for="email" class="font-weight-bold">Email:</label>
		      			<cfinput type="email" class="form-control" id="email" placeholder="Enter email" name="email">
		    		</div>
		    		<div class="form-group">
		      			<label for="pwd" class="font-weight-bold">Password:</label>
		      			<cfinput type="password" class="form-control" id="pwd" placeholder="Enter password" name="pswd">
		    		</div>
		    		<div class="row justify-content-md-center p-1">
		    			<div class="col col-lg-12 text-center">
		    				<button type="submit" class="btn btn-primary">Log In</button>
		    				<a href="signUp.cfm" class="btn btn-primary">Sign Up</a>
		    			</div>
		    		</div>
		    	</div>
	    	</div>
  		</cfform>
	</div>
</body>
</html>