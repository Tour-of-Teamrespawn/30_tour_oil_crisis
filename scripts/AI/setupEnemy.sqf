private ["_faction", "_marker", "_types_array", "_class_type", "_group_type", "_number", "_rndpos", "_safepos", "_grp", "_pat_distance", "_initdone"];

_faction = "UK3CB_TKA_O";
_marker = "TOUR_mkrAO";
_skill = 1;
_initdone = false;

private ["_marker", "_checkdistance", "_positions", "_listsafe", "_blacklist", "_possiblepos", "_found", "_listsafeinf", "_markerDB"];

_positions = 6;

_checkdistance = 1000;

if (((markerSize _marker) select 0) > ((markerSize _marker) select 1)) then
{
	_checkdistance = (markerSize _marker) select 0;
}else
{
	_checkdistance = (markerSize _marker) select 1;
};

_listsafeinf = [];

while {count _listsafeinf < _positions} do
{
	{
		_p = [(_x select 0) select 0,(_x select 0) select 1, 0];
		if ((_p inArea _marker)&&({_p distance _x < 350}count _listsafeinf == 0)) then
		{
			_listsafeinf set [count _listsafeinf, [(_x select 0) select 0,(_x select 0) select 1, 0 ]];
		};
	}forEach (selectBestPlaces [(getMarkerPos _marker), _checkdistance,"(1 - houses) * (1 - sea)", 10, 1]);
};
/*
{
	_markerDB = createMarkerLocal [(format ["TDMC_positionsSelectorMarker_%1", (_foreachindex + 1)]), _x];
	_markerDB setMarkertype "hd_dot";
	_markerDB setmarkercolor "colorred";
}forEach _listsafeinf;
*/
for "_i" from 1 to _positions do
{
	_group_type = 				
	[
		["infantry", "UK3CB_TKA_O_AA_FireTeam"],
		["infantry", "UK3CB_TKA_O_AT_FireTeam"],
		["infantry", "UK3CB_TKA_O_UGL_FireTeam"],
		["infantry", "UK3CB_TKA_O_MG_FireTeam"],
		["infantry", "UK3CB_TKA_O_RIF_FireTeam"],
		["infantry", "UK3CB_TKA_O_AA_FireTeam"],
		["infantry", "UK3CB_TKA_O_AT_FireTeam"],
		["infantry", "UK3CB_TKA_O_UGL_FireTeam"],
		["infantry", "UK3CB_TKA_O_MG_FireTeam"],
		["infantry", "UK3CB_TKA_O_RIF_FireTeam"],
		["infantry", "UK3CB_TKA_O_SniperTeam"]
	];
	_pos = _listsafeinf call BIS_fnc_selectRandom;
	_listsafeinf = _listsafeinf - [_pos];
	_group_type = _group_type call BIS_fnc_selectRandom;
	_grp = [_pos, EAST, (configFile >> "CfgGroups" >> "EAST" >> _faction >> (_group_type select 0) >> (_group_type select 1))] call BIS_fnc_spawnGroup;
	waitUntil {(count units _grp > 0)};
	{
		//sort out accuracy and skill and loadouts if needed
		_x call Tour_fnc_garbageEH;
		_x call TOUR_fnc_loadouts;
	}forEach units _grp;
	[_grp, _pos, 120]spawn TOUR_fnc_rndpatrol;

};