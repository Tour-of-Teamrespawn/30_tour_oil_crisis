_pos = _this select 0;

if (isServer) then 
{
	_object_array = nearestObjects [_pos,["house","Land_Ind_Oil_Tower_EP1", "Land_Ind_Oil_Pump_EP1"],250];
	hint str _object_array;
	{
		if (damage _x < 1) then 
		{
			sleep 0.7;_secondary = "Bo_Mk82" createVehicle [getposATL _x select 0, getPosATL _x select 1, 0.3];_x setdamage 1;
			if ((_x iskindof "Land_Ind_Oil_Tower_EP1")or(_x iskindof "Land_Ind_Oil_Pump_EP1")) then
			{
				_s = "LAND_HELIPADempty_F" createVehicleLocal _pos;
				_s setPos _pos;
				[_s,10,time,false,true] spawn BIS_Effects_Burn;
			};
		};
	}foreach _object_array;
	BIS_Effects_Burn=compile preprocessFile "\ca\Data\ParticleEffects\SCRIPTS\destruction\burn.sqf";
	TDMC_bombs_detonated = true;
}else
{
	_object_array = nearestObjects [_pos,["Land_Ind_Oil_Tower_EP1", "Land_Ind_Oil_Pump_EP1"],250];
	{
		sleep 0.7;_x setdamage 1;
		if ((_x iskindof "Land_Ind_Oil_Tower_EP1")or(_x iskindof "Land_Ind_Oil_Pump_EP1")) then
		{
			_s = "HeliHEmpty" createVehicleLocal _pos;
			_s setPos _pos;
			[_s,10,time,false,true] spawn BIS_Effects_Burn;
		};
	}foreach _object_array;
	BIS_Effects_Burn=compile preprocessFile "\ca\Data\ParticleEffects\SCRIPTS\destruction\burn.sqf";
};
		