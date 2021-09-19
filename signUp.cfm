<!DOCTYPE html>
<html>
<head>
	<title>
		Sign Up
	</title>
	<!--- Including the styles --->
	<cfinclude template="style.cfm">
	
	<!--- Script to validate the form --->
	<script>
		function validateForm() {
  			var firstName = document.forms["signUp"]["firstName"].value;
  			var lastName = document.forms["signUp"]["lastName"].value;
  			var Email = document.forms["signUp"]["email"].value;
  			var Password = document.forms["signUp"]["Password"].value;
  			var confirmPassword = document.forms["signUp"]["confirmPWD"].value;
  			var Message = "";
  			
  			if (firstName == "") {
  				var Message = Message + "First Name must be filled out";
  			}
  			
  			if (lastName == "") {
  				if (Message == "") {
  					var Message = Message + "Last Name must be filled out";
  				} else {
  					var Message = Message + "\nLast Name must be filled out";
  				}
  			}
  			
  			if (Email == "") {
  				if (Message == "") {
  					var Message = Message + "Email must be filled out";
  				} else {
  					var Message = Message + "\nEmail must be filled out";
  				}
  			}
  			
  			if (Password == "") {
  				if (Message == "") {
  					var Message = Message + "Password must be filled out";
  				} else {
  					var Message = Message + "\nPassword must be filled out";
  				}
  			}
  			
  			if (confirmPassword == "") {
  				if (Message == "") {
  					var Message = Message + "Confirm Password must be filled out";
  				} else {
  					var Message = Message + "\nConfirm Password must be filled out";
  				}
  			}
  			
  			if (Password != confirmPassword) {
  				if (Message == "") {
  					var Message = Message + "Password and Confirm Password must match";
  				} else {
  					var Message = Message + "\nPassword and Confirm Password must match";
  				}
  			}
  			
  			// Validate lowercase letters
 		 	var lowerCaseLetters = /[a-z]/g;
			if(Password.match(lowerCaseLetters)) {  
			} else {
				if (Message == "") {
  					var Message = Message + "Password must have a lowercase letter";
  				} else {
  					var Message = Message + "\nPassword must have a lowercase letter";
  				}
			}
			  
			// Validate capital letters
			var upperCaseLetters = /[A-Z]/g;
			if(Password.match(upperCaseLetters)) {  
			} else {
			    if (Message == "") {
  					var Message = Message + "Password must have a uppercase letter";
  				} else {
  					var Message = Message + "\nPassword must have a uppercase letter";
  				}
			}
			
			// Validate numbers
			var numbers = /[0-9]/g;
			if(Password.match(numbers)) {  
			} else {
			    if (Message == "") {
  					var Message = Message + "Password must have a number";
  				} else {
  					var Message = Message + "\nPassword must have a number";
  				}
		 	}
			  
			// Validate length
			if(Password.length >= 8) {
			} else {
			    if (Message == "") {
  					var Message = Message + "Password must be Minimum 8 characters";
  				} else {
  					var Message = Message + "\nPassword must be Minimum 8 characters";
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
  		<h2 class="text-primary text-center">Sign Up</h2>
  		
  		<!--- checking to see if form is defined and user does not already exist. If does not exist insert new user.  --->
  		<cfif isdefined("form.firstName")>
			<cfquery name="checkUser" datasource="securePortal">
				Select firstName, lastName, Email 
				From Users with(nolock)
				Where Email = '#form.Email#'
			</cfquery>
			
			<cfif checkUser.recordCount GT 0>
				<div class="text-center">
					<span class="text-danger">Error email address already exists please try a diffrent email address.</span>
				</div>
			<cfelse>
				<cfquery name="insertUser" datasource="securePortal">
					insert into users (firstName, lastName, Email, Password, PhoneNumber, superAdmin, createdDate, updatedDate)
					Values ('#form.firstName#','#form.lastName#','#form.Email#','#form.Password#'
					,<cfif isdefined("form.PhoneNumber") and form.PhoneNumber NEQ "">'#form.PhoneNumber#'<cfelse>NULL</cfif>,0, getDate(), getDate())
				</cfquery>
				
				<cflocation url="index.cfm" >
			</cfif>
		</cfif>
		
		<!--- Define variables to be used to set the form if incorrect information is entered --->
		<cfset firstName="">
		<cfset lastName="">
  		<cfset Email="">
  		<cfset phoneNumber="">
  		<cfset password="">
  		<cfset confirmPassword="">
  		
  		<cfif isdefined("form.firstName")>
  			<cfset firstName="#form.firstName#">
  		</cfif>
  		<cfif isdefined("form.lastName")>
  			<cfset lastName="form.lastName">
  		</cfif>
  		<cfif isdefined("form.phoneNumber")>
  			<cfset phoneNumber="#form.phoneNumber#">
  		</cfif>
  		
  		<!--- form to setup a new user --->
  		<cfform name="signUp" action="" onsubmit="return validateForm()" method="post">
  			<div class="border border-3 border-secondary rounded">
	    		<div class="row">
	  				<div class="col-lg-2 text-left font-weight-bold">
	  					First Name: <span class="text-danger">*</span>
	  				</div>
	  				<div class="col-lg-4">
	  					<cfinput type="text" class="form-control" id="firstName" placeholder="Enter First Name" name="firstName" value="#firstName#">
	  				</div>
					<div class="col-lg-2 text-left font-weight-bold">
	  					Last Name: <span class="text-danger">*</span>
	  				</div>
	  				<div class="col-lg-4">
	  					<cfinput type="text" class="form-control" id="lastName" placeholder="Enter Last Name" name="lastName" value="#lastName#">
					</div>
	    		</div>
	    		<div class="row justify-content-md-center p-1">
	  				<div class="col-lg-2 text-left font-weight-bold">
	  					Email: <span class="text-danger">*</span>
	  				</div>
	  				<div class="col-lg-4">
	  					<cfinput type="email" class="form-control" id="email" placeholder="Enter Email" name="email" value="#Email#">
	  				</div>
					<div class="col-lg-2 text-left font-weight-bold">
	  					Phone Number:
	  				</div>
	  				<div class="col-lg-4">
	  					<cfinput type="tel" class="form-control" id="phoneNumber" placeholder="Enter Phone Number" name="phoneNumber" value="#phoneNumber#">
					</div>
	    		</div>
	    		<div class="row justify-content-md-center p-1">
	  				<div class="col-lg-2 text-left font-weight-bold">
	  					Password: <span class="text-danger">*</span>
	  				</div>
	  				<div class="col-lg-4">
	  					<cfinput type="password" class="form-control" id="Password" placeholder="Enter Password" name="Password" value="#Password#">
	  				</div>
					<div class="col-lg-2 text-left font-weight-bold">
	  					Confirm Password: <span class="text-danger">*</span>
	  				</div>
	  				<div class="col-lg-4">
	  					<cfinput type="password" class="form-control" id="confirmPWD" placeholder="Confirm Password" name="confirmPWD" value="#confirmPassword#">
					</div>
	    		</div>
	    	
	    		<div class="row justify-content-md-center p-1">
	    			<div class="col-lg-12 text-center">
	    				<button type="submit" class="btn btn-primary">Create Profile</button>
	    				<a href="index.cfm" class="btn btn-primary">Log In</a>
	    			</div>
	    		</div>
	    	</div>
  		</cfform>
	</div>
</body>
</html>