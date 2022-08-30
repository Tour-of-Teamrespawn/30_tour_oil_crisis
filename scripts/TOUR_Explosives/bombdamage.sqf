_barrel = _this select 0;
_bomb = _this select 1;

_barrel addEventHandler ["HIT", 
{
	(_this select 0) enableSimulation true;
	if (damage (_this select 0) > 0.3)	 then
	{
		[(_this select 0)]spawn
		{
			private ["_pos", "_bomb"];
				_pos = [getposATL (_this select 0) select 0, getposATL (_this select 0) select 1, 0.15];
				deletevehicle (_this select 0);
				_bomb = ((getposATL (_this select 0)) nearestobject "explosive");
				if (!isNull _bomb) then
				{
					deletevehicle _bomb;
				};
				_boom = "Bo_GBU12_LGB" createVehicle _pos;
				[_pos, "scripts\TOUR_explosives\bombsingleexplosion.sqf"] remoteExec ["BIS_fnc_execVM"];
			//[nil, nil, rEXECVM, "scripts\TOUR_explosives\bombsingleexplosion.sqf", _pos] call RE;
		};
	};
}];