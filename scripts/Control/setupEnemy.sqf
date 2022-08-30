TOUR_detect_trigger = createTrigger["EmptyDetector", getMarkerPos "TOUR_mkrAO"]; 
TOUR_detect_trigger setTriggerArea[1400,900,40,false];
TOUR_detect_trigger setTriggerActivation["WEST","EAST D",false];
TOUR_detect_trigger setTriggerStatements["this", "TOUR_detected_in_fields = true; null = execvm 'scripts\AI\enemyspawn.sqf';null = execvm 'scripts\AI\enemyspawn.sqf'; null = execVM 'scripts\AI\tankspawn.sqf';", ""];

execVM "scripts\AI\setupEnemy.sqf";

2 execVM "scripts\AI\setupVehicle.sqf";