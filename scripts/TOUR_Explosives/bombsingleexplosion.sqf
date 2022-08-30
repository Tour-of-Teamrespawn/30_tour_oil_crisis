_pos = _this;
waitUntil {!isNil "TOUR_fnc_Burn"};
_object_array = (nearestObjects [_pos,["house","Land_Ind_Oil_Tower_EP1", "Land_Ind_Oil_Pump_EP1"],300]);
if (isServer) then
{
	TOUR_core setVariable ["TOUR_task_explosion", true, true];
	{
		if (damage _x < 1) then 
		{
			_pos = getPosATL _x;
			sleep 0.7; _x setdamage 1;
			if ((_x iskindof "Land_Ind_Oil_Tower_EP1")or(_x iskindof "Land_Ind_Oil_Pump_EP1")) then
			{
				_secondary = "Bo_Mk82" createVehicle [getposATL _x select 0, getPosATL _x select 1, 0.3];
				_s = "LAND_HELIPADempty_F" createVehicleLocal _pos;
				_s setPos _pos;
				[_s,10,time,false,true] spawn TOUR_fnc_Burn;
			};
		};
	}foreach _object_array;
	
}else
{
	{
		_pos = getPosATL _x;
		sleep 0.7;_x setdamage 1;
		if ((_x iskindof "Land_Ind_Oil_Tower_EP1")or(_x iskindof "Land_Ind_Oil_Pump_EP1")) then
		{
			_s = "LAND_HELIPADempty_F" createVehicleLocal _pos;
			_s setPos _pos;
			[_s,10,time,false,true] spawn TOUR_fnc_Burn;
		};
	}foreach _object_array;
};