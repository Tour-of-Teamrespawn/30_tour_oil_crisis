_bomb = (nearestobjects [vehicle player, ["explosive"], 10]) select 0;
_guy = _this select 1;
_id = _this select 2;

_sequence = (_bomb getVariable "TOUR_EXPLOSIVES_bombSequence") select 0;
_timeLimit = (_bomb getVariable "TOUR_EXPLOSIVES_bombSequence") select 1;
_ok = true;
if (isNil {_guy getVariable "TOUR_IED_Expert"}) then
{
	_timeLimit = _timeLimit / 2;
	_ok = false;
	if (createDialog "TOUR_EXPLOSIVES_bombDefuseQ") then
	{
		waitUntil {isNull (findDisplay 314258)};
		if (TOUR_EXPLOSIVES_defuseAgree) then
		{
			_ok = true;
		};
	};
};
TOUR_EXPLOSIVES_bombDefuseCurrent = _bomb;
TOUR_EXPLOSIVES_defuseStart = false;

if (_ok) then
{
	if (!createDialog "TOUR_EXPLOSIVES_bombDefuse") then
	{
		hint "ERROR!\nCould not create TOUR_EXPLOSIVES_bombDefuse dialog";
	}
	else
	{
		for "_i" from (count (toArray _sequence) + 1) to 8 do
		{
			ctrlShow [10 + _i, false];
			ctrlShow [20 + _i, false];
		};
		waitUntil {isNull (findDisplay 314259)};
		if (TOUR_EXPLOSIVES_defuseStart) then
		{
			if (!createDialog "TOUR_EXPLOSIVES_bombDefuse") then
			{
				hint "ERROR!\nCould not create TOUR_EXPLOSIVES_bombDefuse dialog";
			}
			else
			{
				TOUR_EXPLOSIVES_bombDefuseCurrent setVariable ["TOUR_EXPLOSIVES_bombDefusedOk", false];
				waituntil {!isnil {TOUR_EXPLOSIVES_bombDefuseCurrent getVariable "TOUR_EXPLOSIVES_bombDefusedOk"}};
				TOUR_EXPLOSIVES_bombDefuseCurrent setVariable ["TOUR_EXPLOSIVES_bombActive", false, true];
				for "_i" from (count (toArray _sequence) + 1) to 8 do
				{
					ctrlShow [10 + _i, false];
					ctrlShow [20 + _i, false];
				};
				ctrlEnable [1, false];
				ctrlEnable [2, false];
				_dmg = damage player;
				_pos = ctrlPosition ((findDisplay 314259) displayCtrl 5);
				((findDisplay 314259) displayCtrl 5) ctrlSetPosition [_pos select 0, _pos select 1, 0, _pos select 3];
				((findDisplay 314259) displayCtrl 5) ctrlCommit _timeLimit;
				
				waitUntil {isNull _bomb || isNull (findDisplay 314259) || _dmg > damage player || (ctrlPosition ((findDisplay 314259) displayCtrl 5)) select 2 == 0};
				
				if (isNull _bomb) then
				{
					closeDialog 314259;
				};
				if !(_bomb getVariable "TOUR_EXPLOSIVES_bombDefusedOk") then
				{ //Failed to defuse
					if (!isNull (findDisplay 314259)) then
					{
						closeDialog 314259;
					};
					
					if (random 1 >= 0.75) then
					{ //Luck of the Irish
						TOUR_EXPLOSIVES_bombDefuseCurrent setVariable ["TOUR_EXPLOSIVES_bombActive", true, true];
					}
					else
					{ //Bye bye
						_bomb execVM "scripts\TOUR_explosives\bombDetonate.sqf";
					};
				}
				else
				{ //Defused
					deleteVehicle _bomb;
				};
			};
		}else
		{
			hint "error";
		};
	};
};
