private ["_marker", "_pos", "_groups", "_civs", "_posArray", "_buildings", "_buildingsnew", "_presence"];

_point = (_this select 0);
_distance = (_this select 1);
_number = (_this select 2);

_presence = 0;
_posArray = [];
_buildings = [];
_buildingsnew = [];
_groups = [];
_civs = [];
_array =  ["UK3CB_TKC_C_CIV", "UK3CB_TKC_C_CIV","UK3CB_TKC_C_CIV", "UK3CB_TKC_C_SPOT", "UK3CB_TKC_C_WORKER"];

{
	_buildings set [count _buildings, _x];
}forEach (nearestObjects [_point,["Building","House"], _distance]);

_posArray = [];

if (count _buildings > 0) then
{
	{
		if ((count ([(_buildings select _forEachIndex)] call BIS_fnc_buildingPositions)) > 5) then {_posArray = _posArray + [(([(_buildings select _forEachIndex)] call BIS_fnc_buildingPositions) call BIS_fnc_selectRandom)];};
	}forEach _buildings;
};
_civCountGlobalTotal = 0;

for "_i" from 1 to _number do
{
	_pos = (_posArray call BIS_fnc_selectRandom);
	_posArray = _posArray - [_pos];
	_type = _array call BIS_fnc_selectRandom;
	_grp = createGroup CIVILIAN;
	_groups = _groups + [_grp];
	_unit = _grp createUnit [_type, _pos, [], 0, "NONE"];
	_civs = _civs + [_unit];
	_civCountGlobalTotal = _civCountGlobalTotal + 1;
	_unit call Tour_fnc_garbageEH;
	_unit call TOUR_fnc_loadouts;
	[_unit, _posArray] execFSM "scripts\ambientLife\civilianControl.fsm";
};
