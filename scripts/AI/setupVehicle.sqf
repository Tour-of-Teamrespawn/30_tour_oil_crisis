for "_i" from 1 to _this do
{
	_positions = [];

	_unit_type = 
	[
		"UK3CB_TKA_O_Hilux_Dshkm",
		"UK3CB_TKA_O_Hilux_GMG",
		"UK3CB_TKA_O_Hilux_PKM",
		"UK3CB_TKA_O_Hilux_Spg9",
		"UK3CB_TKA_O_BTR60",
		"UK3CB_TKA_O_BTR60",
		"UK3CB_TKA_O_BTR60"
	];

	_roads = (getMarkerPos "TOUR_mkrAO") nearRoads 1300;

	{
		_positions set [count _positions, getPos _x];
	}forEach _roads;

	_pos = _positions call BIS_fnc_SelectRandom;

	_unit = (_unit_type call BIS_fnc_SelectRandom) createVehicle _pos;
	_grpenemy = createVehicleCrew _unit;

	sleep 1;

	{
		_x call TOUR_fnc_loadouts;
	}forEach units _grpenemy;	

	_wp1 = _grpenemy addwaypoint [(_positions call BIS_fnc_SelectRandom), 0];
	_wp1 setWaypointType "MOVE";
	_wp1 setWaypointBehaviour "AWARE";
	_wp1 setWaypointSpeed "NORMAL";
	_wp1 setWaypointCombatMode "RED";

	_wp2 = _grpenemy addwaypoint [(_positions call BIS_fnc_SelectRandom), 0];
	_wp2 setWaypointType "MOVE";
	_wp2 setWaypointBehaviour "AWARE";
	_wp2 setWaypointSpeed "NORMAL";
	_wp2 setWaypointCombatMode "RED";

	_wp3 = _grpenemy addwaypoint [(_positions call BIS_fnc_SelectRandom), 0];
	_wp3 setWaypointType "MOVE";
	_wp3 setWaypointBehaviour "AWARE";
	_wp3 setWaypointSpeed "NORMAL";
	_wp3 setWaypointCombatMode "RED";

	_wp4 = _grpenemy addwaypoint [(_positions call BIS_fnc_SelectRandom), 0];
	_wp4 setWaypointType "MOVE";
	_wp4 setWaypointBehaviour "AWARE";
	_wp4 setWaypointSpeed "NORMAL";
	_wp4 setWaypointCombatMode "RED";

	_wp4 = _grpenemy addwaypoint [(_positions call BIS_fnc_SelectRandom), 0];
	_wp4 setWaypointType "CYCLE";
	_wp4 setWaypointBehaviour "AWARE";
	_wp4 setWaypointSpeed "NORMAL";
	_wp4 setWaypointCombatMode "RED";
};

