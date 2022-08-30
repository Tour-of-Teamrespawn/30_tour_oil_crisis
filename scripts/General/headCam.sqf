if (isServer) then
{
	TOUR_tv1 setVariable ["TOUR_pipEffect", 0, true];
	TOUR_tv2 setVariable ["TOUR_pipEffect", 0, true];
	waitUntil {{(side _x != sideLogic)} count (playableUnits + switchableUnits) > 0};
	_units = [];
	{
		if (side _x != sideLogic) then
		{
			_units = _units + [_x];
		};
	}forEach (playableUnits + switchableUnits);
	TOUR_camPlayer1 = _units select 0;
	TOUR_camPlayer2 = _units select 0;
	[TOUR_camPlayer1, {TOUR_camPlayer1 = _this}] remoteExec ["BIS_fnc_Spawn", 0, false];
	[TOUR_camPlayer2, {TOUR_camPlayer2 = _this}] remoteExec ["BIS_fnc_Spawn", 0, false];
};

if (!isDedicated) then
{
	waitUntil {!isNil "TOUR_camPlayer1" && !isNil "TOUR_camPlayer2"};

	TOUR_tv1 setObjectTexture [0, "#(argb,512,512,1)r2t(headcam1,1)"];
	TOUR_cam_1 = "camera" camCreate [0,0,0];
	TOUR_cam_1 cameraEffect ["Internal", "Back", "headcam1"];
	TOUR_cam_1 attachTo [TOUR_camPlayer1, [0.1,-0.05,0.125], "head", true];
	TOUR_cam_1 camSetFov 1;
	"headcam1" setPiPEffect [0];
	
	TOUR_tv2 setObjectTexture [0, "#(argb,512,512,1)r2t(headcam2,1)"];
	TOUR_cam_2 = "camera" camCreate [0,0,0];
	TOUR_cam_2 cameraEffect ["Internal", "Back", "headcam2"];
	TOUR_cam_2 attachTo [TOUR_camPlayer2, [0.1,-0.05,0.125], "head", true];
	TOUR_cam_2 camSetFov 1;
	"headcam2" setPiPEffect [0];
	
	TOUR_fnc_camSwitchUnit1 = 
	{
		private ["_control", "_key", "_shift", "_ctrl", "_alt", "_units"];
		_control = _this select 0;
		_key = _this select 1;
		_shift = _this select 2;
		_ctrl = _this select 3;
		_alt = _this select 4;
		if (
				((_key == 200)or(_key == 208))
				&& !(_shift)&& !(_ctrl)&& !(_alt)
				&& (cursorTarget == TOUR_tv1)
				&& (player distance TOUR_tv1 < 2.5)
		) then
		{
			_oldUnit = false;
			_units = [];
			{
				if (side _x != sideLogic) then
				{
					_units = _units + [_x];
				};
			}forEach (playableUnits + switchableUnits);
			_total = count _units;
			
			{
				if (_x == TOUR_camPlayer1) then
				{
					_oldUnit = true;
				};

				if ((_key == 208) && _oldUnit) exitWith
				{
					// pressing down
					if ((_forEachIndex + 1) == _total) then
					{
						TOUR_camPlayer1 = _units select 0;
					}else
					{
						TOUR_camPlayer1 = _units select (_forEachIndex + 1);
					};
				};
				
				if ((_key == 200) && _oldUnit) exitWith
				{
					// pressing up
					if ((_forEachIndex - 1) == -1) then
					{
						TOUR_camPlayer1 = _units select (_total -1);
					}else
					{
						TOUR_camPlayer1 = _units select (_forEachIndex - 1);
					};
				};
			}forEach _units;
			
			[TOUR_camPlayer1, {TOUR_camPlayer1 = _this; TOUR_cam_1 attachTo [TOUR_camPlayer1, [0.1,-0.05,0.125], "head", true];TOUR_cam_1 cameraEffect ["Internal", "Back", "headcam1"];}] remoteExec ["BIS_fnc_Spawn", 0, false];
			
			_textHint = parseText format
			["
				<t size='1.25' font='puristaMedium' color='#0080ff' align='center' valign='top'>HEAD CAMERA:</t>
				<br/>
				<br/>
				<t size='1.25' font='puristaMedium' align='center' color='#3cb371' valign='top'>INFO!</t>
				<br/>
				<br/>
				<t size='0.85' font='TahomaB' color='#D0D0D0' align='center' valign='top'>Viewing:<br/><br/>%1<br/>%2</t>
			",name TOUR_camPlayer1, groupID group TOUR_camPlayer1];
			hint _textHint;
		};
		
		if (
				((_key == 203)or(_key == 205))
				&& !(_shift)&& !(_ctrl)&& !(_alt)
				&& (cursorTarget == TOUR_tv1)
				&& (player distance TOUR_tv1 < 2.5)
		) then
		{
			_effect = TOUR_tv1 getVariable "TOUR_pipEffect";
			
			if (_key == 205) then
			{
				_effect = _effect + 1;
			};
			if (_key == 203) then
			{
				_effect = _effect - 1;
			};		
			if (_effect < 0) then
			{
				_effect = 1;
			};
			if (_effect > 1) then
			{
				_effect = 0;
			};	
			TOUR_tv1 setVariable ["TOUR_pipEffect", _effect];
			[_effect, {"headcam1" setPiPEffect [_this];}] remoteExec ["BIS_fnc_Spawn", 0, false];
		};
	};	
	
	TOUR_fnc_camSwitchUnit2 = 
	{
		private ["_control", "_key", "_shift", "_ctrl", "_alt"];
		_control = _this select 0;
		_key = _this select 1;
		_shift = _this select 2;
		_ctrl = _this select 3;
		_alt = _this select 4;
		if (
				((_key == 200)or(_key == 208))
				&& !(_shift)&& !(_ctrl)&& !(_alt)
				&& (cursorTarget == TOUR_tv2)
				&& (player distance TOUR_tv2 < 2.5)
		) then
		{
			_oldUnit = false;
			_units = [];
			{
				if (side _x != sideLogic) then
				{
					_units = _units + [_x];
				};
			}forEach (playableUnits + switchableUnits);
			_total = count _units;
			
			{
				if (_x == TOUR_camPlayer2) then
				{
					_oldUnit = true;
				};

				if ((_key == 208) && _oldUnit) exitWith
				{
					// pressing down
					if ((_forEachIndex + 1) == _total) then
					{
						TOUR_camPlayer2 = _units select 0;
					}else
					{
						TOUR_camPlayer2 = _units select (_forEachIndex + 1);
					};
				};
				
				if ((_key == 200) && _oldUnit) exitWith
				{
					// pressing up
					if ((_forEachIndex - 1) == -1) then
					{
						TOUR_camPlayer2 = _units select (_total -1);
					}else
					{
						TOUR_camPlayer2 = _units select (_forEachIndex - 1);
					};
				};
			}forEach _units;
			
			[TOUR_camPlayer2, {TOUR_camPlayer2 = _this; TOUR_cam_2 attachTo [TOUR_camPlayer2, [0.1,-0.05,0.125], "head", true];TOUR_cam_2 cameraEffect ["Internal", "Back", "headcam2"];}] remoteExec ["BIS_fnc_Spawn", 0, false];
			
			_textHint = parseText format
			["
				<t size='1.25' font='puristaMedium' color='#0080ff' align='center' valign='top'>HEAD CAMERA:</t>
				<br/>
				<br/>
				<t size='1.25' font='puristaMedium' align='center' color='#3cb371' valign='top'>INFO!</t>
				<br/>
				<br/>
				<t size='0.85' font='TahomaB' color='#D0D0D0' align='center' valign='top'>Viewing:<br/><br/>%1<br/>%2</t>
			",name TOUR_camPlayer2, groupID group TOUR_camPlayer2];
			hint _textHint;
		};
		
		if (
				((_key == 203)or(_key == 205))
				&& !(_shift)&& !(_ctrl)&& !(_alt)
				&& (cursorTarget == TOUR_tv2)
				&& (player distance TOUR_tv2 < 2.5)
		) then
		{
			_effect = TOUR_tv2 getVariable "TOUR_pipEffect";
			
			if (_key == 205) then
			{
				_effect = _effect + 1;
			};
			if (_key == 203) then
			{
				_effect = _effect - 1;
			};		
			if (_effect < 0) then
			{
				_effect = 1;
			};
			if (_effect > 1) then
			{
				_effect = 0;
			};	
			TOUR_tv2 setVariable ["TOUR_pipEffect", _effect];
			[_effect, {"headcam2" setPiPEffect [_this];}] remoteExec ["BIS_fnc_Spawn", 0, false];
		};
	};

	waitUntil {!isNull (findDisplay 46)};	
	(findDisplay 46) displayAddEventHandler ["keyDown", "_this CALL TOUR_fnc_camSwitchUnit1"];
	(findDisplay 46) displayAddEventHandler ["keyDown", "_this CALL TOUR_fnc_camSwitchUnit2"];
};