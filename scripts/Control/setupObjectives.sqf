TOUR_core setVariable ["TOUR_task_radio", false, true];
TOUR_core setVariable ["TOUR_task_defuse", false, true];
TOUR_core setVariable ["TOUR_task_sieze", false, true];
TOUR_core setVariable ["TOUR_task_explosion", false, true];

["TOUR_objBomb", {"Disarm Explosives"}] call A2S_createSimpleTask;
["TOUR_objBomb", {"Locate and defuse 5 bombs within the <marker name=""TOUR_mkrAO"">oil fields</marker>."}, {"Disarm Explosives"}, {"Disarm Explosives"}] call A2S_setSimpleTaskDescription;
"TOUR_objBomb" call A2S_taskCommit;

["TOUR_objEnemy", {"Eliminate Hostiles"}] call A2S_createSimpleTask;
["TOUR_objEnemy", {"Eliminate Iraqi presence in the <marker name=""TOUR_mkrAO"">oil fields</marker>."}, {"Eliminate Hostiles"}, {"Eliminate Hostiles"}] call A2S_setSimpleTaskDescription;
"TOUR_objEnemy" call A2S_taskCommit;

["TOUR_objCiv", {"Protect Civilians"}] call A2S_createSimpleTask;
["TOUR_objCiv", {"Ensure there are no civilian casulaties"}, {"Protect Civilians"}, {"Protect Civilians"}] call A2S_setSimpleTaskDescription;
"TOUR_objCiv" call A2S_taskCommit;

TOUR_sieze_trigger = createTrigger["EmptyDetector", getMarkerPos "TOUR_mkrAO"]; 
TOUR_sieze_trigger setTriggerArea[1300,800,40,false];
TOUR_sieze_trigger setTriggerActivation["ANY","PRESENT",false];
TOUR_sieze_trigger setTriggerStatements["(({(side _x == WEST)&&(_x in thislist)} count allunits)>(({(side _x == EAST)&&(_x in thislist)} count allunits)*3))", "['TOUR_objEnemy', 'SUCCEEDED'] call A2S_setTaskState;'TOUR_objEnemy' call A2S_taskCommit; 'TOUR_objEnemy' call A2S_taskHint;", ""];
