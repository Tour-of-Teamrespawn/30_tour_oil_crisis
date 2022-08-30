[  
	TOUR_Medic,  
	"Heal",  
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",  
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revivemedic_ca.paa",  
	"(player distance TOUR_medic < 3) && (isNil {TOUR_medic getvariable 'Operating'})",  
	"(player distance TOUR_medic < 3) && (isNil {TOUR_medic getvariable 'Operating'})",  
	{},  
	{},  
	{  
		private ["_patient"];
		TOUR_medic setVariable ["Operating", true];
		_patient = player;
		{
			if (_x != TOUR_medic) exitWith
			{
				_patient = _x;
			};
		}forEach (nearestObjects [TOUR_stretcher, ["man"], 10]); 
		[_patient, 
		{
			_this switchMove "Acts_InjuredLyingRifle01";    
			if !(isDedicated) then
			{
				if (player == _this) then
				{
					_this setpos (TOUR_stretcher modelToWOrld [-1,0.9,-0.4]);
					_this setdir (getDir TOUR_stretcher) + 255;  
				};
			};
			sleep 2;
			if (isServer) then
			{
				TOUR_medic setpos (TOUR_stretcher modelToWorld [-1.16,-0.07,-0.92]);
			};
			sleep 2;
			TOUR_medic playAction "medicOther";  
			sleep 7; 
			TOUR_medic playAction "medic";  
			sleep 7;  
			if (alive _this) then  
			{ 
				if !(isDedicated) then
				{
					if (player == _this) then
					{
						sleep 3;
						[_this] call ace_medical_treatment_fnc_fullHealLocal;
						_this setpos (TOUR_stretcher modelToWOrld [-1,2,-0.8])
					};
				};
				TOUR_medic playAction "playerstand";
				_this switchMove "stand"
			}; 	
			if (isServer) then
			{
				TOUR_medic setVariable ["Operating", nil];
			};
		}]remoteExec ["BIS_fnc_Spawn", 0, false];
	},  
	{},  
	[],  
	3,  
	3,  
	false,  
	false  
] call BIS_fnc_holdActionAdd;