/*
PARAMS:
	0: array of possible bomb positions <INTEGER>
	1: Minimal guaranteed bomb count <INTEGER>
	2: Maximal bomb count <INTEGER>
*/

_bombPosCount = _this select 0;//[position 1, 2, 3, 4, 5, ...];
_bombCountMin = _this select 1;//6;
_bombCountMax = _this select 2;//10;
_pos = [0,0,0];

//DEBUG:
//for "_i" from 1 to _bombPosCount do
//{
//	_pos = getMarkerPos format ["bomb_%1", _i];
//	_mark = "FlagCarrierSmall" createVehicle _pos;
//	_mark setPos _pos;
//};
//END

_bombs = [];
_pos = [0,0,0];

for "_i" from 1 to (_bombCountMin + ceil (random (_bombCountMax - _bombCountMin))) do
{
	_pos = _bombPosCount call BIS_fnc_selectRandom;
	_bombPosCount = _bombPosCount - [_pos];

	_sequence = "";
	for "_i" from 1 to 8 do
	{
		if (floor (random 2) == 0) then
		{
			_sequence = _sequence + "l";
		}
		else
		{
			_sequence = _sequence + "r";
		};
	};

	_barrel = "Land_MetalBarrel_F" createVehicle _pos;
	_barrel setPos _pos;
	_barrel setVectorUp [0,0,1];
	_barrel enablesimulation false;
	_bomb = "Explosive" createVehicle _pos;
	_bomb setpos (_barrel modelToWorld [0,0,0.42]);
	_bomb setVectorUp [0,0,1];
	_bomb enableSimulation false;
	_bomb setVariable ["TOUR_EXPLOSIVES_bombSequence", [_sequence, (15 + (ceil random 10))], true];
	_bomb setVariable ["TOUR_EXPLOSIVES_bombActive", true, true];
	[_barrel, _bomb] execVM "scripts\TOUR_explosives\bombdamage.sqf";
	_bombs set [count _bombs, _bomb];
};
TOUR_bomb_array = _bombs;