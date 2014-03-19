/*
	File Name: FAI_Create_Heli.sqf
	File Created: 2/26/2014
	File Version: 1.0
	File Author: Foamy 
	File Last Edit Date: 2/26/2014
	File Description: Foamy AI Create Vehicle Script
	
	Variables:
	1. Position
	2. Patrol Position
	3. Patrol Radius

	Example:
	_aiHeli = [_aiheli_spawn_pos,_loot_pos,250] execVM "\z\addons\dayz_server\addons\FAI\FMission\FAI_Create_Heli.sqf";
	
*/

private ["_aispawnpos","_aigroup","_aiHeli","_patrol_radius","_helitype","_aiVehicleObj","_aiVehicleCrew","_aiVehicleGroup"];

_aiHeli = objNull;
_aigroup = createGroup EAST;
_aispawnpos = _this select 0;
_patrol_pos = this select 1;
_patrol_radius = _this select 2;

	_aiHeli = [_aispawnpos, 180, "UH1H_DZ", _aigroup] call BIS_fnc_spawnVehicle;
	[_aigroup, _patrol_pos, _patrol_radius] call BIS_fnc_taskPatrol;
	_helitype = "UH1H_DZ";
	
// Report results to RPT File
diag_log format ["FAI Heli 1.0: -=%1=- Spawned @ Location: %2 | Patrol Radius: %3m",_helitype,_aispawnpos,_patrol_radius];

waitUntil 
{
(!EPOCH_MISSION_RUNNING)
};

_aiVehicleObj = _aiHeli select 0;
_aiVehicleCrew = _aiHeli select 1;
_aiVehicleGroup = _aiHeli select 2;

{ deleteVehicle _x } forEach (crew _aiVehicleObj); deleteVehicle _aiVehicleObj;

diag_log("FAI Vehicle 1.0: AI Heli Deleted");	