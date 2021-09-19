<!--- Check to veify site has not been entered incorrectly --->
<cfif not isdefined("cookie.userEmail")>
	<cfcookie name="message" value="You have been timed out. Please log back in to reconnect." expires="1"> 
	
	<cflocation url="index.cfm">
</cfif>

<!--- check for if user is a super admin to show additonal report/link --->
<cfquery name="checkAdmin" datasource="securePortal">
	Select firstName, lastName, Email, superAdmin
	From Users with(nolock)
	Where Email = '#cookie.userEmail#' and superAdmin = 1
</cfquery>

<!--- Seeing if profile color is set --->
<cfquery name="getProfileColor" datasource="securePortal">
	Select profileColor
	From Users with(nolock)
	Where Email = '#cookie.userEmail#'
</cfquery>

<cfset defaultColor="primary">

<!--- Seting profile color if defined --->
<cfif getProfileColor.profileColor NEQ "">
	<cfset defaultColor="#getProfileColor.profileColor#">
</cfif>

<!--- header nav bar --->
<cfoutput>
	<nav class="navbar navbar-expand-md bg-#defaultColor# navbar-dark">
	  	<a class="navbar-brand" href="userProfile.cfm">Secure Profile</a>
	  	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="##collapsibleNavbar">
	    	<span class="navbar-toggler-icon"></span>
	  	</button>
	  	<div class="collapse navbar-collapse" id="collapsibleNavbar">
	    	<ul class="navbar-nav">
	      		<li class="nav-item">
	        		<a class="nav-link text-white" href="userProfile.cfm">Profile</a>
	      		</li>
	      		<cfif checkAdmin.recordCount GT 0>
		      		<li class="nav-item">
		        		<a class="nav-link text-white" href="userReport.cfm">User Report</a>
		      		</li>
	      		</cfif>
	    	</ul>
	    	<ul class="navbar-nav ml-auto">
	    		<li class="nav-item">
	      			<a class="nav-link text-white" href="logout.cfm">Logout</a>
	    		</li>
	  		</ul>
	  	</div>  
	</nav>
</cfoutput>