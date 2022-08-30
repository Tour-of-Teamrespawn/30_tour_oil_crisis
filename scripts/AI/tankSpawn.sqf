if (TOUR_retreat) exitwith {}; 

sleep 10;

_grptank = creategroup EAST;
_amount = ceil random 3;

switch (floor random 4) do
{

	case 0:
	{
		[(getMarkerPos "TOUR_mkrTankSpawn_1"), 180, "UK3CB_TKA_O_T55", _grptank] call bis_fnc_spawnvehicle;
		if (_amount >= 2) then { [(getMarkerPos "TOUR_mkrTankSpawn_2"), 180, "UK3CB_TKA_O_T55", _grptank] call bis_fnc_spawnvehicle; };
		if (_amount == 3) then { [(getMarkerPos "TOUR_mkrTankSpawn_3"), 180, "UK3CB_TKA_O_T55", _grptank] call bis_fnc_spawnvehicle; };
	};
	
	case 1:
	{
		[(getMarkerPos "TOUR_mkrTankSpawn_1"), 180, "UK3CB_TKA_O_T72A", _grptank] call bis_fnc_spawnvehicle;
		if (_amount >= 2) then { [(getMarkerPos "TOUR_mkrTankSpawn_2"), 180, "UK3CB_TKA_O_T72A", _grptank] call bis_fnc_spawnvehicle; };
	};
	
	case 2:
	{
		[(getMarkerPos "TOUR_mkrTankSpawn_1"), 180, "UK3CB_TKA_O_BTR60", _grptank] call bis_fnc_spawnvehicle;
		if (_amount >= 2) then { [(getMarkerPos "TOUR_mkrTankSpawn_2"), 180, "UK3CB_TKA_O_BTR60", _grptank] call bis_fnc_spawnvehicle; };
		if (_amount == 3) then { [(getMarkerPos "TOUR_mkrTankSpawn_3"), 180, "UK3CB_TKA_O_BTR60", _grptank] call bis_fnc_spawnvehicle; };
	};
	
	case 3:
	{
		[(getMarkerPos "TOUR_mkrTankSpawn_1"), 180, "UK3CB_TKA_O_Hilux_Dshkm", _grptank] call bis_fnc_spawnvehicle;
		if (_amount >= 2) then { [(getMarkerPos "TOUR_mkrTankSpawn_2"), 180, "UK3CB_TKA_O_Hilux_Spg9", _grptank] call bis_fnc_spawnvehicle; };
		if (_amount == 3) then { [(getMarkerPos "TOUR_mkrTankSpawn_3"), 180, "UK3CB_TKA_O_Hilux_PKM", _grptank] call bis_fnc_spawnvehicle; };
	};
	
};

sleep 5;

{
	_x call TOUR_fnc_loadouts;
}forEach units _grptank;	

_wp1 = _grptank addwaypoint [getmarkerpos "TOUR_mkrTankMove_1", 0];
_wp1 setWaypointType "MOVE";
_wp1 setWaypointBehaviour "AWARE";
_wp1 setWaypointSpeed "NORMAL";
_wp1 setWaypointCombatMode "RED";

_wp2 = _grptank addwaypoint [getmarkerpos "TOUR_mkrTankMove_2", 0];
_wp2 setWaypointType "MOVE";
_wp2 setWaypointBehaviour "AWARE";
_wp2 setWaypointSpeed "NORMAL";
_wp2 setWaypointCombatMode "RED";

_wp3 = _grptank addwaypoint [getmarkerpos "TOUR_mkrTankMove_3", 0];
_wp3 setWaypointType "MOVE";
_wp3 setWaypointBehaviour "AWARE";
_wp3 setWaypointSpeed "NORMAL";
_wp3 setWaypointCombatMode "RED";

_wp4 = _grptank addwaypoint [getmarkerpos "TOUR_mkrTankMove_4", 400];
_wp4 setWaypointType "MOVE";
_wp4 setWaypointBehaviour "AWARE";
_wp4 setWaypointSpeed "NORMAL";
_wp4 setWaypointCombatMode "RED";

_wp5 = _grptank addwaypoint [getmarkerpos "TOUR_mkrTankMove_5", 400];
_wp5 setWaypointType "MOVE";
_wp5 setWaypointBehaviour "AWARE";
_wp5 setWaypointSpeed "NORMAL";
_wp5 setWaypointCombatMode "RED";

_wp6 = _grptank addwaypoint [getmarkerpos "TOUR_mkrTankMove_4", 300];
_wp6 setWaypointType "CYCLE";
_wp6 setWaypointBehaviour "AWARE";
_wp6 setWaypointSpeed "NORMAL";
_wp6 setWaypointCombatMode "RED";

sleep 120;

while {true} do
{
	if ( ({(alive _x)or(canstand _x)}count units _grptank) <= 2) exitwith{ };
	{
		if ((getMarkerPos "TOUR_mkrTankSpawn_1" distance (vehicle _x)) < 150) then
		{
			if (!isNull vehicle _x) then
			{
				_vehicle = vehicle _x;
				{
					deleteVehicle _x;
				}forEach crew _vehicle;
				deleteVehicle _vehicle;
			};
		};
	}forEach units _grpTank;
	sleep 10;
};

[] spawn
{
	sleep 100;
	sleep (random 300);
	execVM "scripts\AI\tankspawn.sqf";
};

waituntil {(({alive _x}count units _grptank) < 1)};
deletegroup _grptank;




