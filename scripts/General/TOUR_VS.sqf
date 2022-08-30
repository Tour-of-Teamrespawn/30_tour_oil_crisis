TOUR_VS_code =
{
	_vehicle = _this select 0;
	if (isNil {player getVariable "TOUR_VS_pilot"}) then 
	{
		_ran = [(+0.0075), (-0.0075)];
		_randirarray = [(+0.1), (-0.1)];
		while {vehicle player == _vehicle} do
		{
			if (player == driver _vehicle) then
			{
				while {player == driver _vehicle} do 
				{
					waitUntil {(getPosATL _vehicle select 2 > 1)or(player != driver _vehicle)&&(canMove _vehicle)};
					_timer = 3;
					_ran1 = _ran call BIS_fnc_selectrandom;
					_ran2 = _ran call BIS_fnc_selectrandom;
					_ran4 = _randirarray call BIS_fnc_selectrandom;
					while {(player == driver _vehicle)&&(_timer > 0)&&(canMove _vehicle)} do 
					{	
						_element1 = ((vectorUp _vehicle) select 0)+ _ran1;
						_element2 = ((vectorUp _vehicle) select 1)+ _ran2;
						_vehicle setdir ((getDir _vehicle) + _ran4);
						_vehicle setvectorup [_element1,_element2,1];
						_timer = _timer - 0.01;
						sleep 0.01;
					};
				};
			};
			sleep 0.5;
		};
	};
};

if (!isDedicated) then
{
	{
		_x addEventHandler ["getIn", {[(_this select 0)]spawn TOUR_VS_code;}];	
	}forEach _this;
};