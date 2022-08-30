if (!isServer) exitwith {};
if (TOUR_retreat) exitwith {};
TOUR_detected_in_fields = true;

null = execvm "scripts\AI\enemyspawn.sqf";
null = execvm "scripts\AI\enemyspawn.sqf";
null = execVM "scripts\AI\tankspawn.sqf";