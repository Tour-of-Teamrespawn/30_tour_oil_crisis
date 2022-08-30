_bomb = _this;

TOUR_core setVariable ["TOUR_task_explosion", true, true];

_pos = [getposATL _bomb select 0, getposATL _bomb select 1, 0.15];
_barrel = _pos nearestObject "Barrel1";
deletevehicle _barrel;
deletevehicle _bomb;
_boom = "Bo_GBU12_LGB" createVehicle _pos;
[_pos, "scripts\TOUR_explosives\bombsingleexplosion.sqf"] remoteExec ["BIS_fnc_execVM", 0, true];