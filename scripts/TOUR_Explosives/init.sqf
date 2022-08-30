waituntil {!isnil "BIS_fnc_init"};
waitUntil {player==player};
if (!isDedicated) then
{
	if (isNil "TOUR_EXPLOSIVES_scriptran") then
	{
		execFSM "scripts\TOUR_EXPLOSIVES\TOUR_EXPLOSIVES_MAIN.fsm";
		player createDiarySubject ["About", "About"];
		player createDiaryRecord ["About", ["BOMB Defusal", 

		"<br/>
		Developer: Mr.Ben
		<br/>
		Version: 2.0
		<br/>
		<br/>Credits: Thanks to all Tour members for testing and feedback.
		<br />
		<br />
		 - Bombs are C4 mounted on top of flamable barrels.
		 <br />
		 <br />
		  - Once close to an bomb, you will have an action to defuse it. When ready, click the action and follow the instructions in the dialog. Defusal of a bomb can be done by working out a sequence of 8 arrows. If the sequence is wrong, you will have to start again, and remember the progress you had made. Aborting the defusal process (Esc), or running out of time, will likely result in detonation of the bomb.
		  <br />
		  <br />
		  - In order to defuse an bomb, you MUST have a toolkit. If you are not an expert, less time will be given for the defusal process.
		"]];
	};
};

TOUR_EXPLOSIVES_scriptran = true;