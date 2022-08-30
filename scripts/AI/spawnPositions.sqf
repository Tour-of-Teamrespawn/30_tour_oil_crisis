// spawn points for standard mission
private ["_mkr", "_checkdistance", "_positions", "_listsafe", "_blacklist", "_possiblepos", "_found", "_listsafeinf", "_mkrDB"];

_mkr = _this select 0;
_positions = (_this select 1);

_checkdistance = 1000;

if (((markerSize _mkr) select 0) > ((markerSize _mkr) select 1)) then
{
	_checkdistance = (markerSize _mkr) select 0;
}else
{
	_checkdistance = (markerSize _mkr) select 1;
};

_blacklist = [];
_possiblepos = [];
_found = false;

_listsafeinf = [];
{
	if ((_x select 0) inArea _mkr) then
	{
		_listsafeinf set [count _listsafeinf, (_x select 0)];
	};
}forEach (selectBestPlaces [(getMarkerPos _mkr), _checkdistance,"(1 + forest) * (1 - houses) * (1 - sea)", 10, _positions]);


{
	_mkrDB = createMarkerLocal [(format ["TDMC_positionsselectormarker_%1", (_foreachindex + 1)]), _x];
	_mkrDB setMarkertype "hd_dot";
	_mkrDB setmarkercolor "colorred";
}forEach _listsafe + _listsafeinf;

TOUR_infantryPositions = _listsafeinf;