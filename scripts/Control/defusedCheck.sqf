while {( (({!isnull _x} count (TOUR_core getVariable "TOUR_bombs")) >= 1)&& !(TOUR_core getVariable "TOUR_task_explosion") )} do
{
	sleep 3;
};
sleep 2;
hint str (TOUR_core getVariable "TOUR_task_explosion");
if !(TOUR_core getVariable "TOUR_task_explosion") then 
{
	["TOUR_objBomb", "SUCCEEDED"] call A2S_setTaskState;
	"TOUR_objBomb" call A2S_taskCommit;
	sleep 2;
	"TOUR_objBomb" call A2S_taskHint;
}else
{
	["TOUR_objBomb", "FAILED"] call A2S_setTaskState;
	"TOUR_objBomb" call A2S_taskCommit;
	sleep 2;
	"TOUR_objBomb" call A2S_taskHint;
};
