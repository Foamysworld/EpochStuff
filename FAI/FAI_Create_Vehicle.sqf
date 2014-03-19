/*
	File Name: FAI_Create_Vehicle.sqf
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
	_aiVehicle = [_aivehicle_spawn_pos,_loot_pos,100] execVM "\z\addons\dayz_server\addons\FMission\FAI\FAI_Create_Vehicle.sqf";
	
*/

private ["_aispawnpos","_aigroup","_patrol_pos","_patrol_radius","_vehicletype","_aiVehicle","_aiVehicleObj","_aiVehicleCrew","_aiVehicleGroup"];

_aiVehicle = objNull;
_aigroup = createGroup EAST;
_aispawnpos = _this select 0;
_patrol_pos = this select 1;
_patrol_radius = _this select 2;


_vehicletype = ["ArmoredSUV_PMC_DZ","GAZ_Vodnik_DZ","HMMWV_M1151_M2_CZ_DES_EP1_DZ"] call BIS_fnc_selectRandom;

if (_vehicletype == "ArmoredSUV_PMC_DZ") then
	{
	_aiVehicle = [_aispawnpos, 180, _vehicletype, _aigroup] call BIS_fnc_spawnVehicle;
	[_aigroup, _aispawnpos, _patrol_radius] call BIS_fnc_taskPatrol;
	};
	
if (_vehicletype == "GAZ_Vodnik_DZ") then
	{
	_aiVehicle = [_aispawnpos, 180, _vehicletype, _aigroup] call BIS_fnc_spawnVehicle;
	[_aigroup, _aispawnpos, _patrol_radius] call BIS_fnc_taskPatrol;
	};

if (_vehicletype == "HMMWV_M1151_M2_CZ_DES_EP1_DZ") then
	{
	_aiVehicle = [_aispawnpos, 180, _vehicletype, _aigroup] call BIS_fnc_spawnVehicle;
	[_aigroup, _aispawnpos, _patrol_radius] call BIS_fnc_taskPatrol;
	};	

// Report results to RPT File
diag_log format ["FAI Vehicle 1.0: -=%1=- Spawned @ Location: %2 | Patrol Radius: %3m",_vehicletype,_patrol_pos,_patrol_radius];	

waitUntil 
{
(!EPOCH_MISSION_RUNNING)
};

_aiVehicleObj = _aiVehicle select 0;
_aiVehicleCrew = _aiVehicle select 1;
_aiVehicleGroup = _aiVehicle select 2;

{ deleteVehicle _x } forEach (crew _aiVehicleObj); deleteVehicle _aiVehicleObj;

diag_log("FAI Vehicle 1.0: AI Vehicle Deleted");