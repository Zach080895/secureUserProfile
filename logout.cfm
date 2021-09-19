<!DOCTYPE html>
<html>
<head>
	<title>
		Logout
	</title>
	<!--- Including the styles --->
	<cfinclude template="style.cfm">
</head>
<body>
	<!--- Clearing the cookie after logout --->
	<cfif IsDefined("Cookie.userEmail")> 
		<cfcookie name="userEmail" value="" expires="NOW"> 
	</cfif>
	
	<cflocation url="index.cfm" >
</body>
</html>