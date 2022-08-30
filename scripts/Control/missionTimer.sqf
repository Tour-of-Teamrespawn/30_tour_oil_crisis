sleep 5400;
sleep (random 1500);
TOUR_retreat = true;

[] spawn {
			{
				if ((side _x == EAST)&&(_x == leader group _x)) then 
				{
					
					{
						_x setwaypointposition [getmarkerpos "TOUR_mkrRetreat", 100];
						_x setwaypointbehaviour "CARELESS";
						_x setwaypointcombatmode "BLUE";
						_x setwaypointtype "MOVE";
						_x setwaypointspeed "FULL";
					}foreach waypoints group _x;
				};
			}foreach allunits;
			
		};

sleep 300;

if ( (({!isnull _x} count (TOUR_core getVariable "TOUR_bombs")) > 0) ) then
{
	{
		[_x] spawn 
		{
			_bomb = _this select 0;
			_pos = [getpos _bomb select 0, getpos _bomb select 1, 0];
			deletevehicle _bomb;
			_barrel = _pos nearestObject "Land_MetalBarrel_F";
			deletevehicle _barrel;
			_boom = "Bo_GBU12_LGB" createVehicle _pos;
			[_pos, "scripts\TOUR_explosives\bombsingleexplosion.sqf"] remoteExec ["BIS_fnc_execVM", 0, true];
		};
	}foreach (TOUR_core getVariable "TOUR_bombs");	
};