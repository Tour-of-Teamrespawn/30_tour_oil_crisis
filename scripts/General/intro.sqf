if (!isdedicated) then 
{
	if (time > 5) exitWith 
	{
		execVM "scripts\general\dust.sqf";
		sleep 5;
		doStop player;
		if (alive player) then
		{
			player playAction "stand";
		};	
	};
	waituntil {player==player};
	cutText ["Loading Intro","BLACK FADED", 5];	
	_pos1  = [getmarkerpos "TOUR_mkrIntro_1" select 0, getmarkerpos "TOUR_mkrIntro_1" select 1, 2];
	_pos3  = [getmarkerpos "TOUR_mkrIntro_3" select 0, getmarkerpos "TOUR_mkrIntro_3" select 1, 2];
	
	_cam1 = "camera" camCreate _pos1;
	_cam1 camprepareTarget _pos3;
	_cam1 camCommitprepared 0;
	_cam1 cameraEffect ["internal", "back"];

	
	0 fadeSound 0;
	"dynamicBlur" ppEffectEnable true;
	"dynamicBlur" ppEffectAdjust [5];
	"dynamicBlur" ppEffectCommit 0;
	
	sleep 7;
	
	playsound "TOUR_introMusic";
	cutText [" ","BLACK IN", 5];
	5 fadeSound 1;
	"dynamicBlur" ppEffectAdjust [0];
	"dynamicBlur" ppEffectCommit 5;

	sleep 5;
		
	setwind [0.201112,0.204166,true];
	_ran = ceil random 5;
	playsound format ["wind%1",_ran];
	_obj = _cam1;
	_pos = position _obj;

	//--- Dust
	setwind [0.201112*2,0.204166*2,false];
	_velocity = [random 10,random 10,-1];
	_color = [1.0, 0.9, 0.8];
	_alpha = 0.02 + random 0.02;
	_ps = "#particlesource" createVehicleLocal _pos;  
	_ps setParticleParams [["\Ca\Data\ParticleEffects\Universal\universal.p3d", 16, 12, 8], "", "Billboard", 1, 3, [0, 0, -6], _velocity, 1, 1.275, 1, 0, [9], [_color + [0], _color + [_alpha], _color + [0]], [1000], 1, 0, "", "", _obj];
	_ps setParticleRandom [3, [30, 30, 0], [0, 0, 0], 1, 0, [0, 0, 0, 0.01], 0, 0];
	_ps setParticleCircle [0.5, [0, 0, 0]];
	_ps setDropInterval 0.0001;

	sleep (random 1);
	deletevehicle _ps;
		
		
	sleep 1;
		
	[] spawn
	{
	
		sleep 2;
	
 		_text = ["N","o","r","t","h","e","r","n"," ","T","a","k","i","s","t","a","n"];
 		_display = "";
 		_pointer = 0;
 		_sleepTime = 0.1;

 		while {_pointer < count _text} do
 		{
 		 	_display = _display + (_text select _pointer);
 		 	titleText [_display,"PLAIN down",_sleepTime];
 		 	_pointer = _pointer + 1;
 		 	if (_pointer == count _text) then
  			{
 	  			cutText [_display,"PLAIN down",1];
  			}
  			else
  			{
   				playSound "TOUR_key_noise";
  			};
 			sleep _sleepTime;
		};
		
	};
	
	sleep 8;
	
		setwind [0.201112,0.204166,true];
		_ran = ceil random 5;
		playsound format ["wind%1",_ran];
		_obj = _cam1;
		_pos = position _obj;

		//--- Dust
		setwind [0.201112*2,0.204166*2,false];
		_velocity = [random 10,random 10,-1];
		_color = [1.0, 0.9, 0.8];
		_alpha = 0.02 + random 0.02;
		_ps = "#particlesource" createVehicleLocal _pos;  
		_ps setParticleParams [["\Ca\Data\ParticleEffects\Universal\universal.p3d", 16, 12, 8], "", "Billboard", 1, 3, [0, 0, -6], _velocity, 1, 1.275, 1, 0, [9], [_color + [0], _color + [_alpha], _color + [0]], [1000], 1, 0, "", "", _obj];
		_ps setParticleRandom [3, [30, 30, 0], [0, 0, 0], 1, 0, [0, 0, 0, 0.01], 0, 0];
		_ps setParticleCircle [0.5, [0, 0, 0]];
		_ps setDropInterval 0.0001;

		sleep (random 1);
		deletevehicle _ps;	
	
	cutText [" ","BLACK OUT", 2];

	sleep 2.1;
	_pos2 = [getmarkerpos "TOUR_mkrIntro_2" select 0,getmarkerpos "TOUR_mkrIntro_2" select 1, 30];
	_cam1 camSetPos _pos2;
	_cam1 camCommit 0; 
	_cam1 camprepareTarget getmarkerpos "TOUR_mkrBomb_30"; 
	_cam1 camCommitprepared 0;
	sleep 2.1;
	sleep 0.2;
	cutText [" ","BLACK IN", 2];

	_pos3 = [getmarkerpos "TOUR_mkrIntro_4" select 0,getmarkerpos "TOUR_mkrIntro_4" select 1, 70];
	_cam1 camprepareTarget _pos3; 
	_cam1 camCommitprepared 27;
	sleep 5;
	
		setwind [0.201112,0.204166,true];
		_ran = ceil random 5;
		playsound format ["wind%1",_ran];
		_obj = _cam1;
		_pos = position _obj;

		//--- Dust
		setwind [0.201112*2,0.204166*2,false];
		_velocity = [random 10,random 10,-1];
		_color = [1.0, 0.9, 0.8];
		_alpha = 0.02 + random 0.02;
		_ps = "#particlesource" createVehicleLocal _pos;  
		_ps setParticleParams [["\Ca\Data\ParticleEffects\Universal\universal.p3d", 16, 12, 8], "", "Billboard", 1, 3, [0, 0, -6], _velocity, 1, 1.275, 1, 0, [9], [_color + [0], _color + [_alpha], _color + [0]], [1000], 1, 0, "", "", _obj];
		_ps setParticleRandom [3, [30, 30, 0], [0, 0, 0], 1, 0, [0, 0, 0, 0.01], 0, 0];
		_ps setParticleCircle [0.5, [0, 0, 0]];
		_ps setDropInterval 0.0001;

		sleep (random 1);
		deletevehicle _ps;
	
	
	sleep 1;
	[]spawn {
		_text = ["P","a","r","-","e"," ","S","i","a","h"," ","O","i","l"," ","F","i","e","l","d","s","\n","1","7","3","0"," ","H","o","u","r","s"];
 		_display = "";
 		_pointer = 0;
 		_sleepTime = 0.1;

 		while {_pointer < count _text} do
 		{
 		 	_display = _display + (_text select _pointer);
 	 		titleText [_display,"PLAIN down",_sleepTime];
 	 		_pointer = _pointer + 1;
 	 		if (_pointer == count _text) then
  			{
 	  			cutText [_display,"PLAIN down",1];
  			}
  			else
  			{
   				playSound "TOUR_key_noise";
  			};
 			sleep _sleepTime;
		};
	};
	sleep 6;
	
			setwind [0.201112,0.204166,true];
		_ran = ceil random 5;
		playsound format ["wind%1",_ran];
		_obj = _cam1;
		_pos = position _obj;

		//--- Dust
		setwind [0.201112*2,0.204166*2,false];
		_velocity = [random 10,random 10,-1];
		_color = [1.0, 0.9, 0.8];
		_alpha = 0.02 + random 0.02;
		_ps = "#particlesource" createVehicleLocal _pos;  
		_ps setParticleParams [["\Ca\Data\ParticleEffects\Universal\universal.p3d", 16, 12, 8], "", "Billboard", 1, 3, [0, 0, -6], _velocity, 1, 1.275, 1, 0, [9], [_color + [0], _color + [_alpha], _color + [0]], [1000], 1, 0, "", "", _obj];
		_ps setParticleRandom [3, [30, 30, 0], [0, 0, 0], 1, 0, [0, 0, 0, 0.01], 0, 0];
		_ps setParticleCircle [0.5, [0, 0, 0]];
		_ps setDropInterval 0.0001;

		sleep (random 1);
		deletevehicle _ps;

		
		sleep 8;
		
	"dynamicBlur" ppEffectAdjust [2];
	"dynamicBlur" ppEffectCommit 5;
	sleep 0.5;
	cutText ["[Tour] Oil Crisis","BLACK OUT", 5];
	sleep 8;
	cutText ["","BLACK FADED", 0];
	sleep 1;
	_cam1 cameraEffect ["TERMINATE", "back"];
	camdestroy _cam1;
	sleep 3;
	
	_date = date;
	_year = _date select 0;
	_month = _date select 1;
	_day = _date select 2;
	_hour = _date select 3;
	_min = _date select 4;
	_text_date = [];

	if (_min < 10) then 
	{ 
		_text_date = format ["%1-%2-%3  %4h0%5m", _month, _day, _year, _hour, _min]; 
	} 
	else 
	{  
		if (_min == 60) then
		{
			_hour = _hour + 1;
			_min = 0;
			_text_date = format ["%1-%2-%3  %4h0%5m", _month, _day, _year, _hour, _min];
		}
		else
		{
			_text_date = format ["%1-%2-%3  %4h%5m", _month, _day, _year, _hour, _min]; 
		};
	};

	_text_1 = "Day 18";
	_text_2 = "Takistan War";
	sleep 2;
	[_text_1, _text_date, _text_2] execVM "scripts\general\fn_infoText.sqf";
	sleep 2.5;
	player playAction "stand";
	sleep 2;
	"dynamicBlur" ppEffectAdjust [0];
	"dynamicBlur" ppEffectCommit 3.5;
	sleep 0.5;
	cutText ["", "BLACK IN", 5];
			
	execVM "scripts\general\dust.sqf";
}else
{
	sleep 10;
};
//if (isServer) then {execVM "scripts\AI\start_patrols.sqf";};