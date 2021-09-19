<!DOCTYPE html>
<html>
<head>
	<title>
		User Profile
	</title>
	<!--- Including the styles --->
	<cfinclude template="style.cfm">
	
	<!--- Script to validate the form --->
	<script>
		function validateForm() {
  			var firstName = document.forms["userProfile"]["firstName"].value;
  			var lastName = document.forms["userProfile"]["lastName"].value;
  			var Email = document.forms["userProfile"]["email"].value;
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
  			<h2 class="text-#defaultColor# text-center">User Profile</h2>
  		</cfoutput>
  		
  		
		<!--- checking to see if form is defined if so updating the user --->
  		<cfif isdefined("form.firstName")>
			<cfquery name="updateUser" datasource="securePortal">
				Update 
				Users
				Set firstName = '#form.firstName#', lastName = '#form.lastName#', Email = '#form.Email#', phoneNumber = '#form.phoneNumber#', 
					address = '#form.address#', City = '#form.City#', State = '#form.State#', zipCode = '#form.zip#', Gender = '#form.Gender#',
					BirthDate = '#form.BirthDate#', profileColor = '#form.profileColor#', updatedDate = getdate()
				Where email = '#form.Email#'
			</cfquery>
			
			<div class="text-center">
				<span class="text-success">Your profile has been succesfully updated.</span>
			</div>
			
			<cflocation url="userProfile.cfm" >
		</cfif>
  		
  		<!--- query to get the user infromation --->
  		<cfquery name="getUser" datasource="securePortal">
			Select *
			From Users with(nolock)
			Where Email='#cookie.userEmail#'
		</cfquery>
		
		<!--- Defining the variables to set in the form --->
		<cfset firstName="">
		<cfset lastName="">
  		<cfset Email="">
  		<cfset phoneNumber="">
  		<cfset address="">
		<cfset City="">
  		<cfset State="">
  		<cfset zipCode="">
  		<cfset GenderVar="N/A">
  		<cfset BirthDate="">
  		<cfset profileColorVar="Blue">
  		
  		<!--- Defining the variables based on the query --->
  		<cfif getUser.recordcount gt 0>
  			<cfloop query="getUser">
  				<cfset firstName="#firstName#">
				<cfset lastName="#lastName#">
		  		<cfset Email="#Email#">
		  		<cfset phoneNumber="#phoneNumber#">
		  		<cfset address="#address#">
				<cfset City="#City#">
		  		<cfset State="#State#">
		  		<cfset zipCode="#zipCode#">
		  		<cfif Gender NEQ "">
		  			<cfset GenderVar="#Gender#">
		  		</cfif>
		  		<cfset BirthDate="#dateformat(BirthDate,'yyyy-mm-dd')#">
		  		<cfif profileColor NEQ "">
		  			<cfset profileColorVar="#profileColor#">
		  		</cfif>
  			</cfloop>
  		</cfif>
  		
  		<!--- form to update the user profile --->
  		<cfform name="userProfile" action="" onsubmit="return validateForm()" method="post">
  			<div class="border border-3 border-secondary rounded">
	    		<div class="row justify-content-md-center p-1">
	  				<div class="col col-lg-2 text-right font-weight-bold">
	  					First Name: <span class="text-danger">*</span>
	  				</div>
	  				<div class="col col-lg-4">
	  					<cfinput type="text" class="form-control" id="firstName" placeholder="Enter First Name" name="firstName" value="#firstName#">
	  				</div>
					<div class="col col-lg-2 text-right font-weight-bold">
	  					Last Name: <span class="text-danger">*</span>
	  				</div>
	  				<div class="col col-lg-4">
	  					<cfinput type="text" class="form-control" id="lastName" placeholder="Enter Last Name" name="lastName" value="#lastName#">
					</div>
	    		</div>
	    		<div class="row justify-content-md-center p-1">
	  				<div class="col col-lg-2 text-right font-weight-bold">
	  					Email: <span class="text-danger">*</span>
	  				</div>
	  				<div class="col col-lg-4">
	  					<cfinput type="email" class="form-control" id="email" placeholder="Enter Email" name="email" value="#Email#" readonly="yes">
	  				</div>
					<div class="col col-lg-2 text-right font-weight-bold">
	  					Phone Number:
	  				</div>
	  				<div class="col col-lg-4">
	  					<cfinput type="tel" class="form-control" id="phoneNumber" placeholder="Enter Phone Number" name="phoneNumber" value="#phoneNumber#">
					</div>
	    		</div>
	    		<div class="row justify-content-md-center p-1">
	  				<div class="col col-lg-2 text-right font-weight-bold">
	  					Address:
	  				</div>
	  				<div class="col col-lg-10">
	  					<cfinput type="text" class="form-control" id="Address" placeholder="Enter Address" name="Address" value="#Address#">
	  				</div>
	    		</div>
	    		<div class="row justify-content-md-center p-1">
	  				<div class="col col-lg-2 text-right font-weight-bold">
	  					City:
	  				</div>
	  				<div class="col col-lg-2">
	  					<cfinput type="text" class="form-control" id="City" placeholder="Enter City" name="City" value="#City#">
	  				</div>
	  				<div class="col col-lg-2 text-right font-weight-bold">
	  					State:
	  				</div>
	  				<div class="col col-lg-2">
	  					<cfinput type="text" class="form-control" id="State" placeholder="Enter State" name="State" value="#State#">
	  				</div>
	  				<div class="col col-lg-2 text-right font-weight-bold">
	  					Zip Code:
	  				</div>
	  				<div class="col col-lg-2">
	  					<cfinput type="text" class="form-control" id="Zip" placeholder="Enter Zip" name="Zip" value="#zipCode#">
	  				</div>
	    		</div>
	    		<div class="row justify-content-md-center p-1">
	    			<div class="col col-lg-2 text-right font-weight-bold">
	  					Gender:
	  				</div>
	  				<div class="col col-lg-4">
	  					<cfselect name="Gender" class="form-control">
	  						<option value="Male" <cfif GenderVar EQ "Male">selected</cfif>>Male</option>
	  						<option value="Female" <cfif GenderVar EQ "Female">selected</cfif>>Female</option>
	  						<option value="N/A" <cfif GenderVar EQ "N/A">selected</cfif>>N/A</option>
	  					</cfselect>
	  				</div>
					<div class="col col-lg-2 text-right font-weight-bold">
	  					Birth Date:
	  				</div>
	  				<div class="col col-lg-4">
	  					<cfinput type="date" class="form-control" id="birthDate" placeholder="Enter Birth Date" name="birthDate" value="#BirthDate#">
					</div>
	    		</div>
	    		<div class="row justify-content-md-center p-1">
	    			<div class="col col-lg-2 text-right font-weight-bold">
	  					Profile Color:
	  				</div>
	  				<div class="col col-lg-4">
	  					<cfselect name="profileColor" class="form-control">
	  						<option value="primary" <cfif profileColorVar EQ "primary">selected</cfif>>Blue</option>
	  						<option value="danger" <cfif profileColorVar EQ "danger">selected</cfif>>Red</option>
	  						<option value="warning" <cfif profileColorVar EQ "warning">selected</cfif>>yellow</option>
	  						<option value="success" <cfif profileColorVar EQ "success">selected</cfif>>green</option>
	  						<option value="dark" <cfif profileColorVar EQ "dark">selected</cfif>>black</option>
	  					</cfselect>
					</div>
	    		</div>
	    		<div class="row justify-content-md-center p-1">
	    			<div class="col col-lg-12 text-center">
	    				<cfoutput>
	    					<button type="submit" class="btn btn-#defaultColor#">Update Profile</button>
	    					<a href="changePassword.cfm" class="btn btn-#defaultColor#">Change Password</a>
	    				</cfoutput>
	    			</div>
	    		</div>
	    	</div>
  		</cfform>
	</div>
</body>
</html>