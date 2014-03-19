/*
	File Name: FMission_Launcher.sqf
	File Created: 12/25/2013
	File Version: 1.0
	File Author: Foamy 
	File Last Edit Date: 2/2/2014
	File Description: Foamy Missions Launcher

Variables to set:
_eventspawnChance = xx; <--- is the % chance it will spawn (example: .50 = 50%)

*/

private ["_spawnRoll", "_eventSpawnChance", "_scriptselected", "_scriptslist"];

_eventSpawnChance =  1;
_spawnRoll = random 1;
diag_log("Checking Spawn Chance");
if (_spawnRoll > _eventSpawnChance and !_debug) exitWith {};

diag_log("Spawn Chance Success");

diag_log("Selecting script and launching");

_scriptslist = 
		[
		"\z\addons\dayz_server\addons\Fmission\Missions\Foamy\FMission_Hostage_Rescue.sqf",
		"\z\addons\dayz_server\addons\Fmission\Missions\Foamy\mission_name.sqf",
		"\z\addons\dayz_server\addons\Fmission\Missions\Foamy\mission_name.sqf",
		"\z\addons\dayz_server\addons\Fmission\Missions\Foamy\mission_name.sqf"
		];
_scriptselected = _scriptslist select (floor(random(count _scriptslist)));
[] execVM _scriptselected;
