/*
	File Name: XXXXX.sqf
	File Created: X/X/XXXX
	File Version: X
	File Author: X 
	File Last Edit Date: X/X/XXXX
	File Description: XXXXXX

*/

// CHECK FOR ANOTHER MISSION RUNNING START ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	if (isNil "EPOCH_MISSION_RUNNING") then 
	{
	EPOCH_MISSION_RUNNING = false;
	};

	if (EPOCH_MISSION_RUNNING) exitWith 
	{
	diag_log("MISSION already running");
	};

// CHECK FOR ANOTHER MISSION RUNNING END ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

private ["_missionSpawnChance", "_spawnMarker", "_spawnRadius", "_markerRadius", "_markerColor", "_item", "_debug", "_start_time", "_loot", "_loot_lists", "_loot_box", "_wait_time", "_spawnRoll", "_position", "_loot_pos", "_loot_box"];

diag_log("MISSION: Mission Name - Script Started");

_missionSpawnChance =  .50; //Set Spawn Chance Here 1 = always
_spawnRoll = random 1;

diag_log("MISSION: Mission Name - Checking EventSpawnChance");
if (_spawnRoll > _missionSpawnChance) exitWith {};

sleep .5;
diag_log("MISSION: Mission Name - Mission SpawnChance Success");

sleep .5;
diag_log("MISSION: Mission Name - Mission Script Started");

EPOCH_MISSION_RUNNING = true;


/*
// Edit Loot Box Contents Below
// Format is:
// 1st row = Weapons, Tools ( Compass, etc)
// 2nd row = Ammo, Food items etc
// 3rd row = Backpacks

The loot example below has 2 loadouts to choose from, you can add as many as you want.
Each addition will use a block like this:
[
["DMR","NVGoggles","Binocular_Vector"],
["20Rnd_762x51_DMR","20Rnd_762x51_DMR","20Rnd_762x51_DMR","ItemSodaMdew","ItemSodaR4z0r","ItemAntibiotic"],
["DZ_Backpack_EP1"]
], <---- The , is NOT needed on last loot block, see example below where the , is only used to separate the 
first block from the second block. There is no , at the end of the second block as it is the last block in 
the list.

*/

//---------------------------------------------------------------------------------

_loot_box = "GuerillaCacheBox";
_loot_lists = [
[
["DMR","NVGoggles","Binocular_Vector"],
["20Rnd_762x51_DMR","20Rnd_762x51_DMR","20Rnd_762x51_DMR","ItemSodaMdew","ItemSodaR4z0r","ItemAntibiotic"],
["DZ_Backpack_EP1"]
],
[
["M4A1_AIM_SD_CAMO","ItemGPS","Binocular"],
["30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","ItemSodaRbull"],
["DZ_ALICE_Pack_EP1"]
]
];

//---------------------------------------------------------------------------------

_loot = _loot_lists call BIS_fnc_selectRandom;

mission_despawn_timer = 1200;
_wait_time = 900;
_start_time = time;
_spawnRadius = 5000;
_spawnMarker = 'center';
_markerRadius = 350; // Radius the loot can spawn and used for the marker
_markerColor = "ColorBlue"; // Set the Marker Color Here

_position = [getMarkerPos _spawnMarker,0,_spawnRadius,10,0,20,0] call BIS_fnc_findSafePos;
_loot_pos = [_position,0,(_markerRadius - 100),10,0,20,0] call BIS_fnc_findSafePos;

//---------------------------------------------------------------------------------
// Add Mission Body STARTS Here
// Add a base?
// Add some AI to patrol?
// Add some Vehicle and Heli patrols?


// Create a loot box?
		// Create loot box
		diag_log("MISSION: Hostage Rescue - Hostages survived creating loot box");
		_loot_box = createVehicle [_loot_box,_loot_pos,[], 0, "NONE"];
		_loot_box setPos _loot_pos;
		clearMagazineCargoGlobal _loot_box;
		clearWeaponCargoGlobal _loot_box;
		clearBackpackCargoGlobal _loot_box;
				 
		// Add loot
		diag_log("MISSION: Hostage Rescue - Loot box created, adding loot to loot box");
		{
		_loot_box addWeaponCargoGlobal [_x,1];
		} forEach (_loot select 0);
		{
		_loot_box addMagazineCargoGlobal [_x,1];
		} forEach (_loot select 1);
		{
		_loot_box addBackpackCargoGlobal [_x,1];
		} forEach (_loot select 2);

// Wait for awhile so loot can be collected?
sleep _wait_time;


// Mission Body ENDS here
// ---------------------------------------------------------------------------------


// Add additional deleteVehicle _xxx; for each item that needs to be deleted.
// Add additional deleteVehicle _xxgroup; to delete the AI units
// Clean up
		EPOCH_MISSION_RUNNING = false;
		
		deleteVehicle _loot_box;
		{ deleteVehicle _x } forEach units _targetgroup;
		deleteGroup _targetgroup;
		
		
		diag_log("MISSION: Mission Name - Script Finished");	