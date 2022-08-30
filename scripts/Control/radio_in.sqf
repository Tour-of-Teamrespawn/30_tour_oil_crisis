if (isServer) then
{
	TOUR_core setVariable ["TOUR_task_radio", true, true];
};

waitUntil {!isNil "A2S_taskHint"};

_caller = _this;

if ( ("TOUR_objBomb" call A2S_taskState != "SUCCEEDED") && !(TOUR_core getVariable "TOUR_task_explosion") ) then
{

	enableradio true;
	sleep 2;
	_caller sideChat (format ["HQ, this is %1, do you read? OVER", groupID (group _caller)]);
	sleep 7;
	TOUR_HQ sideChat (format ["This is HQ, we read you %1, go ahead. OVER", groupID (group _caller)]);
	sleep 7;
	_caller sideChat "We were unable to complete the mission, we had to abort. OVER";
	sleep 8;
	TOUR_HQ sideChat (format ["HQ: Damn it %1! Those orders came from the Commander in Chief! Second Battalion are an hour away... you better have a good excuse when they arrive! OVER", groupID (group _caller)]);
	sleep 12;
	_caller sideChat (format ["Sir yes Sir...! %1 OUT", groupID (group _caller)]);
	sleep 2;
	enableradio false;
	sleep 3;
	
	if (isServer) then 
	{	
		if ("TOUR_objCiv" call A2S_taskState != "failed") then
		{
			["TOUR_objCiv", "SUCCEEDED"] call A2S_setTaskState;
			"TOUR_objCiv" call A2S_taskCommit;
		};

		if ("TOUR_objEnemy" call A2S_taskState != "SUCCEEDED") then
		{
			["TOUR_objEnemy", "FAILED"] call A2S_setTaskState;
			"TOUR_objEnemy" call A2S_taskCommit;
		};
		
		["TOUR_objBomb", "FAILED"] call A2S_setTaskState;
		"TOUR_objBomb" call A2S_taskCommit;
		sleep 2;
		"TOUR_objBomb" call A2S_taskHint;
		
		sleep 7;
		"failed" remoteExecCall ["BIS_fnc_endMissionServer", 0, true];
	};


};


if ((TOUR_core getVariable "TOUR_task_explosion")) then
{

	enableradio true;
	sleep 2;
	_caller sideChat (format ["HQ, this is %1, do you read? OVER", groupID (group _caller)]);
	sleep 7;
	TOUR_HQ sideChat (format ["This is HQ, we read you %1, go ahead. OVER", groupID (group _caller)]);
	sleep 7;
	_caller sideChat "The oil fields are... erm... inoperable. OVER";
	sleep 8;
	TOUR_HQ sideChat (format ["HQ: I thought you were up to this %1. It was a simple mission. Make sure those latrines are clean for when Second Battalion arrive! OVER", groupID (group _caller)]);
	sleep 12;
	_caller sideChat (format ["Ughh, wilco Sir... %1 OUT", groupID (group _caller)]);
	sleep 2;
	enableradio false;
	sleep 3;

	if (isServer) then 
	{
	
		if ("TOUR_objCiv" call A2S_taskState != "failed") then
		{
			["TOUR_objCiv", "SUCCEEDED"] call A2S_setTaskState;
			"TOUR_objCiv" call A2S_taskCommit;
		};

		if ("TOUR_objEnemy" call A2S_taskState != "SUCCEEDED") then
		{
			["TOUR_objEnemy", "FAILED"] call A2S_setTaskState;
			"TOUR_objEnemy" call A2S_taskCommit;
		};
		
		["TOUR_objBomb", "FAILED"] call A2S_setTaskState;
		"TOUR_objBomb" call A2S_taskCommit;
		
		sleep 7;
		"failed" remoteExecCall ["BIS_fnc_endMissionServer", 0, true];
	};
};

if ( ("TOUR_objBomb" call A2S_taskState == "SUCCEEDED") && ("TOUR_objEnemy" call A2S_taskState == "SUCCEEDED") ) then
{

	enableradio true;
	sleep 2;
	_caller sideChat (format ["HQ, this is %1, do you read? OVER", groupID (group _caller)]);
	sleep 7;
	TOUR_HQ sideChat (format ["This is HQ, we read you %1, go ahead. OVER", groupID (group _caller)]);
	sleep 7;
	_caller sideChat "We have successfully removed the threat. OVER";
	sleep 8;
	if ("TOUR_objCiv" call A2S_taskState == "failed") then
	{
		TOUR_HQ sideChat (format ["HQ: Great job %1! But we have reports of civilian casulaties... Less trigger happy next time soldier! OVER", groupID (group _caller)]);
	}else
	{
		TOUR_HQ sideChat (format ["HQ: Great job %1! Second Battalion are an hour away... Hold up at the FOB, we got some cool beers shipping in for you! OVER", groupID (group _caller)]);
	};
	sleep 12;
	if ("TOUR_objCiv" call A2S_taskState == "failed") then
	{	
		_caller sideChat (format ["Sorry HQ it will not happen again... %1 OUT", groupID (group _caller)]);
	}else
	{
		_caller sideChat (format ["You read my mind HQ... %1 OUT", groupID (group _caller)]);
	};
	sleep 2;
	enableradio false;
	sleep 3;
	
	if (isServer) then 
	{
		if ("TOUR_objCiv" call A2S_taskState != "failed") then
		{
			["TOUR_objCiv", "SUCCEEDED"] call A2S_setTaskState;
			"TOUR_objCiv" call A2S_taskCommit;
			sleep 2;
			"complete" remoteExecCall ["BIS_fnc_endMissionServer", 0, true];
		}else
		{
			"civDead" remoteExecCall ["BIS_fnc_endMissionServer", 0, true];
		};
	};
};

if (("TOUR_objBomb" call A2S_taskState == "SUCCEEDED")&&("TOUR_objEnemy" call A2S_taskState != "SUCCEEDED")) then
{
	enableradio true;
	sleep 2;
	_caller sideChat (format ["HQ, this is %1, do you read? OVER", groupID (group _caller)]);
	sleep 7;
	TOUR_HQ sideChat (format ["This is HQ, we read you %1, go ahead. OVER", groupID (group _caller)]);
	sleep 7;
	_caller sideChat "We were unable to seize the oil field. OVER";
	sleep 8;
	TOUR_HQ sideChat (format ["HQ: Damn it %1! Second Battalion are an hour away... Hold up at the FOB, we will see if they can do your job for you! OVER", groupID (group _caller)]);
	sleep 12;
	_caller sideChat (format ["You read my mind HQ... %1 OUT", groupID (group _caller)]);
	sleep 2;
	enableradio false;
	sleep 3;
	
	if (isServer) then 
	{
		if ("TOUR_objCiv" call A2S_taskState != "failed") then
		{
			["TOUR_objCiv", "SUCCEEDED"] call A2S_setTaskState;
			"TOUR_objCiv" call A2S_taskCommit;
		};

		if ("TOUR_objEnemy" call A2S_taskState != "SUCCEEDED") then
		{
			["TOUR_objEnemy", "FAILED"] call A2S_setTaskState;
			"TOUR_objEnemy" call A2S_taskCommit;
		};
		"partial" remoteExecCall ["BIS_fnc_endMissionServer", 0, true];

	};
};