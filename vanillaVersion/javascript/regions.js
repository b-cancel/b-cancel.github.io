function clickedPlus(closedID)
{
	var len = closedID.length;
	var baseString = closedID.substring(0,len-6);
	var openID = baseString+"Opened";

	document.getElementById(closedID).setAttribute("style","display:none;");
	document.getElementById(openID).setAttribute("style","display:block;");
}

function clickedMinus(openID)
{
	var len = openID.length;
	var baseString = openID.substring(0,len-6);
	var closedID = baseString+"Closed";

	document.getElementById(openID).setAttribute("style","display:none;");
	document.getElementById(closedID).setAttribute("style","display:block;");
}