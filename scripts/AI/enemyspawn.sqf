if (TOUR_retreat) exitwith {}; 
_enemyCount = 0;

_types = 				
[
	["infantry", "UK3CB_TKA_O_AA_Squad"],
	["infantry", "UK3CB_TKA_O_AT_Squad"],
	["infantry", "UK3CB_TKA_O_AR_Squad"],
	["infantry", "UK3CB_TKA_O_MG_Squad"],
	["infantry", "UK3CB_TKA_O_MK_Squad"],
	["infantry", "UK3CB_TKA_O_RIF_Squad"]
];
_pos = getmarkerpos format ["TOUR_mkrEnemySpawn_%1", (ceil (random 7))];
_type = _types call BIS_fnc_selectRandom;
_grpenemy = [_pos, EAST, (configFile >> "CfgGroups" >> "East" >> "UK3CB_TKA_O" >> (_type select 0) >> (_type select 1))] call BIS_fnc_spawnGroup;
waitUntil {count units _grpenemy > 4};
sleep 1;

{
	_x call TOUR_fnc_loadouts;
}forEach units _grpenemy;	

_wp1 = _grpenemy addwaypoint [getmarkerpos "TOUR_mkrEnemyWP_1", 300];
_wp1 setWaypointType "MOVE";
_wp1 setWaypointBehaviour "AWARE";
_wp1 setWaypointSpeed "NORMAL";
_wp1 setWaypointCombatMode "RED";

_wp2 = _grpenemy addwaypoint [getmarkerpos "TOUR_mkrEnemyWP_2", 300];
_wp2 setWaypointType "MOVE";
_wp2 setWaypointBehaviour "AWARE";
_wp2 setWaypointSpeed "NORMAL";
_wp2 setWaypointCombatMode "RED";

_wp3 = _grpenemy addwaypoint [getmarkerpos "TOUR_mkrEnemyWP_1", 300];
_wp3 setWaypointType "CYCLE";
_wp3 setWaypointBehaviour "AWARE";
_wp3 setWaypointSpeed "NORMAL";
_wp3 setWaypointCombatMode "RED";

if (random 2 >= 1) then
{
	_wp1 setwaypointposition [(getmarkerpos "TOUR_mkrEnemyWP_2"), 0];
	_wp2 setwaypointposition [(getmarkerpos "TOUR_mkrEnemyWP_1"), 0];
	_wp3 setwaypointposition [(getmarkerpos "TOUR_mkrEnemyWP_2"), 0];
};

while {true} do
{
	if ( ({(alive _x)or(canstand _x)}count units _grpenemy) <= 2) exitwith{ };
	sleep 10;
};

[] spawn
{
	sleep 100;
	sleep (random 300);
	execVM "scripts\AI\enemySpawn.sqf";
};

waituntil {(({alive _x}count units _grpenemy) < 1)};
deletegroup _grpenemy;


