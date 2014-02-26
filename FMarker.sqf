/*
	File Name: FMarker.sqf
	File Created: 12/29/2013
	File Version: 1.1
	File Author: Foamy 
	File Last Edit Date: 12/29/2013
	File Description: Foamy's Marker System

_null = [_position,_loot_pos,_markerRadius,_markercolor,false] execVM "\z\addons\dayz_server\addons\FMarker\FMarker.sqf";	
*/

private ["_loop", "_color", "_coords", "_radius", "_event_marker", "_start_time", "_lootcords", "_debug_marker", "_debug"];

diag_log("FMarker: Loading Script");

_coords = _this select 0;
_lootcoords = _this select 1;
_radius = _this select 2;
_color = _this select 3;
_debug = _this select 4;

while{EPOCH_MISSION_RUNNING} do
{
_event_marker = createMarker [ format ["loot_event_marker_%1", _start_time], _coords];
_event_marker setMarkerShape "ELLIPSE";
_event_marker setMarkerColor _color;
_event_marker setMarkerAlpha 0.5;
_event_marker setMarkerSize [(_radius + 50), (_radius + 50)];
sleep 15;
deleteMarker _event_marker;

	if (_debug) then 
	{
	_debug_marker = createMarker [ format ["loot_event_debug_marker_%1", _start_time], _lootcoords];
	_debug_marker setMarkerShape "ICON";
	_debug_marker setMarkerType "mil_dot";
	_debug_marker setMarkerColor _color;
	_debug_marker setMarkerAlpha 1;
	sleep 15;
	deleteMarker _debug_marker;
	};
};
diag_log("FMarker: Closing Script");
