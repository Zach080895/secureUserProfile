<!DOCTYPE html>
<html>
<head>
	<title>
		Change Password
	</title>
	<!--- Including the styles --->
	<cfinclude template="style.cfm">
	
	<!--- Script to validate the form --->
	<script>
		function validateForm() {
  			var password = document.forms["userPassword"]["Password"].value;
  			var currentPassword = document.forms["userPassword"]["currentPassword"].value;
  			var newPassword = document.forms["userPassword"]["newPassword"].value;
  			var renewPassword = document.forms["userPassword"]["renewPassword"].value;
  			var Message = "";
  			
  			if (password != currentPassword) {
  				var Message = Message + "Incorrect Current Password Entered";
  			}
  			
  			if (newPassword != renewPassword) {
  				if (Message == "") {
  					var Message = Message + "New Password and Confirm New Password must match";
  				} else {
  					var Message = Message + "\nNew Password and Confirm New Password must match";
  				}
  			}
  			
  			// Validate lowercase letters
 		 	var lowerCaseLetters = /[a-z]/g;
			if(newPassword.match(lowerCaseLetters)) {  
			} else {
				if (Message == "") {
  					var Message = Message + "New Password must have a lowercase letter";
  				} else {
  					var Message = Message + "\nNew Password must have a lowercase letter";
  				}
			}
			  
			// Validate capital letters
			var upperCaseLetters = /[A-Z]/g;
			if(newPassword.match(upperCaseLetters)) {  
			} else {
			    if (Message == "") {
  					var Message = Message + "New Password must have a uppercase letter";
  				} else {
  					var Message = Message + "\nNew Password must have a uppercase letter";
  				}
			}
			
			// Validate numbers
			var numbers = /[0-9]/g;
			if(newPassword.match(numbers)) {  
			} else {
			    if (Message == "") {
  					var Message = Message + "New Password must have a number";
  				} else {
  					var Message = Message + "\nNew Password must have a number";
  				}
		 	}
			  
			// Validate length
			if(newPassword.length >= 8) {
			} else {
			    if (Message == "") {
  					var Message = Message + "New Password must be Minimum 8 characters";
  				} else {
  					var Message = Message + "\nNew Password must be Minimum 8 characters";
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
	<!--- including the header file --->
	<cfinclude template="header.cfm">
	
	<div class="container">
  		<cfoutput>
  			<h2 class="text-#defaultColor# text-center">Change Password</h2>
  		</cfoutput>
  		
  		<!--- checking to see if the form is defined and updating the password --->
  		<cfif isdefined("form.currentPassword")>
			<cfquery name="updatePassword" datasource="securePortal">
				Update 
				Users
				Set Password = '#form.newPassword#'
				Where email = '#cookie.userEmail#'
			</cfquery>
			
			<div class="text-center">
				<span class="text-success">Your password has been succesfully updated.</span>
			</div>
		</cfif>
  		
  		<!--- query to get the user password --->
  		<cfquery name="getUser" datasource="securePortal">
			Select password
			From Users with(nolock)
			Where Email='#cookie.userEmail#'
		</cfquery>
		
		<cfset password="">
  		
  		<!--- setting the user password --->
  		<cfif getUser.recordcount gt 0>
  			<cfloop query="getUser">
  				<cfset password="#Password#">
  			</cfloop>
  		</cfif>
  		
  		<!--- form to update the user password --->
  		<cfform name="userPassword" action="" onsubmit="return validateForm()" method="post">
  			<div class="border border-3 border-secondary rounded">
	    		<div class="row justify-content-md-center p-1">
					<div class="col col-lg-4 text-right font-weight-bold">
	  					Current Password:
	  				</div>
	  				<div class="col col-lg-8">
	  					<cfinput type="password" class="form-control" id="currentPassword" placeholder="Enter Current Password" name="currentPassword" required="yes" message="Current Password Cannot Be Blank">
	  					<cfinput type="hidden" class="form-control" id="Password" placeholder="Enter Current Password" name="Password" value="#Password#">
	  				</div>	    			
	    		</div>	
				<div class="row justify-content-md-center p-1">
					<div class="col col-lg-4 text-right font-weight-bold">
	  					New Password:
	  				</div>
	  				<div class="col col-lg-8">
	  					<cfinput type="password" class="form-control" id="newPassword" placeholder="Enter New Password" name="newPassword" required="yes" message="New Password Cannot Be Blank">
	  				</div>	    			
	    		</div>
	    		<div class="row justify-content-md-center p-1">
					<div class="col col-lg-4 text-right font-weight-bold">
	  					Confirm New Password:
	  				</div>
	  				<div class="col col-lg-8">
	  					<cfinput type="password" class="form-control" id="renewPassword" placeholder="Confirm New Password" name="renewPassword" required="yes" message="Confirm Password Cannot Be Blank">
	  				</div>	    			
	    		</div>
	    		<div class="row justify-content-md-center p-1">
	    			<div class="col col-lg-12 text-center">
	    				<cfoutput>
	    					<button type="submit" class="btn btn-#defaultColor#">Update Password</button>
	    				</cfoutput>
	    			</div>
	    		</div>
	    	</div>
  		</cfform>
	</div>
</body>
</html>