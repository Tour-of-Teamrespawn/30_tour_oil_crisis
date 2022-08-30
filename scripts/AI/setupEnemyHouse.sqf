/*
	ENMEY HOUSE SCRIPT
	by Mr.Ben
	
	params passed to script through an array:
	0 = marker name, string
	1 = side, side

*/

private ["_centrepos", "_point", "_array_type", "_skill", "_side", "_pos", "_test", "_buildingsnew", "_buildings", "_building", "_grp", "_unit", "_size", "_type", "_posarray", "_count", "_min", "_max"];

_point = _this select 0;
_size = _this select 1;
_side = _this select 2;
_min = _this select 3;
_max = _this select 4;

_array_type = 
[
	"UK3CB_TKA_O_SL",
	"UK3CB_TKA_O_TL",
	"UK3CB_TKA_O_MD",
	"UK3CB_TKA_O_MG",
	"UK3CB_TKA_O_MG_ASST",
	"UK3CB_TKA_O_AR",
	"UK3CB_TKA_O_LAT",
	"UK3CB_TKA_O_AT",
	"UK3CB_TKA_O_AT_ASST",
	"UK3CB_TKA_O_AA",
	"UK3CB_TKA_O_AA_ASST",
	"UK3CB_TKA_O_MK",
	"UK3CB_TKA_O_SNI",
	"UK3CB_TKA_O_SPOT",
	"UK3CB_TKA_O_ENG",
	"UK3CB_TKA_O_DEM",
	"UK3CB_TKA_O_RIF_1",
	"UK3CB_TKA_O_RIF_2",
	"UK3CB_TKA_O_GL"
];

_pos = [0,0,0];
_test = 0;
_buildingsnew = [];
_posarray = [];

_positions = [];
_buildings = [];

{
	_buildings set [count _buildings, _x];
}forEach (nearestObjects [_point,["Building","House"], _size]);

if ((count _buildings) == 0) exitWith
{
	_pos
};

{
	_building = _buildings select _forEachIndex;
	_test = 0;
	while {_test < 50} do {if (format ["%1", _building buildingPos _test] != "[0,0,0]") then {_posarray set [count _posarray, _building buildingPos _test];};_test = _test + 1};

}forEach _buildings;

if ((count _posarray) < _max) then
{
	_max = count _posarray;
};

if (_min > _max) then
{
	_min = _max;
};

if (_max < 1) then
{
	_max = 1;
	_min = 1;
};

if (count _posarray == 0) exitWith {};

for "_i" from 1 to (_min + (ceil (random (_max - _min)))) do
{
	_pos = [0,0,0];
	_pos = (_posarray call BIS_fnc_selectRandom);
	_posarray = _posarray - [_pos];
	_type = _array_type call BIS_fnc_selectRandom;
	if (typeName _type == "ARRAY") then
	{
		_type = _type select 1;
	};
	_grp = createGroup _side;
	waitUntil {!isNull _grp};
	_unit = _grp createUnit [_type, _pos, [], ceil random 360, "NONE"];
	_unit setPos _pos;
	_unit setDir (_pos getDir ((nearestObjects [_point,["Building","House"], 50]) select 0));
	_unit call Tour_fnc_garbageEH;
	_unit call TOUR_fnc_loadouts;
	_unit setVariable ["lambs_danger_disableAI", true];
	_unit addEventHandler ["Firednear",{_this call TDMC_fnc_houseunitactive;}]; 
	_unit addEventHandler ["HIT",{_this call TDMC_fnc_houseunitactive;}];
};
