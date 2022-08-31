/* 
###MISSION_VERSION 2.1
*/

_d = execVM "scripts\debugRPT.sqf";
waitUntil {scriptDone _d};

_p = execVM "params.sqf";
waitUntil {scriptDone _p};

_a = TOUR_Core execVM "a2s_multitask.sqf";
waitUntil {scriptDone _a};
TOUR_IED_jammers = [];
TOUR_IED_triggermen = [];

setViewDistance 2500;

enableRadio false;
{
	_x setVariable ["BIS_noCoreConversations",true];
} forEach allUnits;

TOUR_HQ = [WEST, "HQ"];
TOUR_detected_in_fields = false;
TOUR_retreat = false;

_fn = execVM "scripts\functions\functions_init.sqf";
waitUntil {scriptDone _fn};

setwind [0.201112,0.204166,true];

if (isServer) then
{
	_g = execVM "scripts\control\garbageLoop.sqf";

	_bombPositions = [];
	for "_i" from 1 to 70 do
	{
		if ((str (getMarkerPos (format ["TOUR_mkrBomb_%1", _i]))) != "[0,0,0]") then
		{
			_bombPositions set [count _bombPositions, (getMarkerPos (format ["TOUR_mkrBomb_%1", _i]))];
		};
	};

	_b = [_bombPositions, 5, 5] execVM "scripts\TOUR_Explosives\bombsCreate.sqf";
	waitUntil {scriptDone _b};
	TOUR_core setVariable ["TOUR_bombs", TOUR_bomb_array, true];

	_o = execVM "scripts\control\setupObjectives.sqf";
	waitUntil {scriptDone _o};

	_d = execVM "scripts\control\defusedCheck.sqf";

	_cp1 = [[9875.67,11518.5,0], 250, 3] execVM "scripts\ambientLife\createPedestrians.sqf";
	
	_cp2 = [[10515.3,11085.1,0], 250, 2] execVM "scripts\ambientLife\createPedestrians.sqf";
	
	_cd1 = 5 execVM "scripts\ambientLife\createVehicles.sqf";
	
	_cd2 = 5 execVM "scripts\ambientLife\createVehicles.sqf";
	
	_t = execVM "scripts\control\missionTimer.sqf";
	
	_e =  execVM "scripts\control\setupEnemy.sqf";
	
	_cp = [[8409.12,11024.2,0], 800, EAST, 10, 15] execVM "scripts\ai\setupEnemyHouse.sqf";
	
	_cp = [[9362.81,10027.4,0], 100, EAST, 5, 8] execVM "scripts\ai\setupEnemyHouse.sqf";
	
	[group TOUR_serviceCrew_1, getMarkerPos "TOUR_mkrHeli", "air", 5] execFSM"scripts\TOUR_service\service.fsm";
	
	[group TOUR_serviceCrew_3, getMarkerPos "TOUR_mkrVeh", "land", 5] execFSM"scripts\TOUR_service\service.fsm";
	
	execVM "scripts\control\endingDead.sqf";
};

[]spawn
{
	sleep 0.1;
	[2500,200,1,0] execVM "scripts\general\smooth_view.sqf";
};

if (isDedicated) then
{
	execVM "scripts\general\headCam.sqf";	
};

if (!isDedicated) then
{
	[] call A2S_tasksSync;
	
	#include "briefing.hpp";

	doStop player;
	
	[] execVM "scripts\TOUR_Explosives\init.sqf";
	
	_l = player execVM "scripts\loadouts\init.sqf";
	
	_int = execVM "scripts\general\intro.sqf";
	execVM "scripts\general\medicTent.sqf";
	
	waitUntil {scriptDone _int};
	sleep 10;
	execVM "scripts\general\headCam.sqf";

	_actionStaticRadioPickup = 	["Call HQ","Call HQ","",
					{
						execVM "scripts\control\call_HQ.sqf";
					},
					{
						!(TOUR_core getVariable "TOUR_task_radio") && (player==leader group player) && ({(alive _x)&&((vehicle _x) distance (getMarkerPos "TOUR_mkrFOB") > 100)}count (playableUnits + switchableUnits) == 0)		
					}
				] call ace_interact_menu_fnc_createAction;
				
	[TOUR_Radio, 0, ["ACE_MainActions"], _actionStaticRadioPickup ]spawn ace_interact_menu_fnc_addActionToObject;

	waitUntil {(player distance (getMarkerPos "TOUR_mkrFOB") > 150)};

	private _text = "<t font='PuristaBold' size='2.5'>30 [Tour] Oil Crisis</t><br /><t font='PuristaBold' size='1.25'>by Mr.Ben</t>";
	[parseText _text, true, nil, 7, 0.7, 0] spawn BIS_fnc_textTiles;

};




