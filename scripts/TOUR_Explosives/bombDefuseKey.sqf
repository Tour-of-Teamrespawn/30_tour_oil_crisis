private ["_key", "_dir", "_targetSq", "_curSq"];
if (TOUR_EXPLOSIVES_defuseStart) then
{
	_key = _this select 1;
	if ((_key != 203)&&(_key != 205)) exitWith {}; //not arrow

	if (_key == 203) then //Arrow left
	{
		_dir = "l";
	}
	else
	{
		if (_key == 205) then //Arrow right
		{
			_dir = "r";
		};
	};
	
	_targetSq = (TOUR_EXPLOSIVES_bombDefuseCurrent getVariable "TOUR_EXPLOSIVES_bombSequence") select 0;
	_curSq = TOUR_EXPLOSIVES_defuseSequence + _dir;
	_lastIx = (count (toArray _curSq)) - 1;
	
	if (_dir == toString [(toArray _targetSq) select _lastIx]) then
	{
		TOUR_EXPLOSIVES_defuseSequence = _curSq;
		ctrlSetText [20 + _lastIx + 1, format["Scripts\TOUR_Explosives\dlg\arrow%1.paa", _dir]];
		
		if (_curSq == _targetSq) then
		{
			TOUR_EXPLOSIVES_bombDefuseCurrent setVariable ["TOUR_EXPLOSIVES_bombDefusedOk", true];
			waituntil {!isnil {TOUR_EXPLOSIVES_bombDefuseCurrent getVariable "TOUR_EXPLOSIVES_bombDefusedOk"}};
			closeDialog 0;
		};
	}
	else
	{
		TOUR_EXPLOSIVES_defuseSequence = "";
		for "_i" from 1 to (count (toArray _targetSq) + 1) do
		{
			ctrlSetText [20 + _i, "Scripts\TOUR_Explosives\dlg\unknown.paa"];
		};
	};
};
