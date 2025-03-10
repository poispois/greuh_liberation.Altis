private [ "_sleeptime", "_target_player", "_target_pos" ];

if ( isNil "infantry_weight" ) then { infantry_weight = 33 };
if ( isNil "armor_weight" ) then { armor_weight = 33 };
if ( isNil "air_weight" ) then { air_weight = 33 };

sleep 1800;

while { GRLIB_endgame == 0 } do {

	_sleeptime = 2700 / ([] call  F_adaptiveOpforFactor);

	if ( combat_readiness >= 80 ) then { _sleeptime = _sleeptime * 0.75 };
	if ( combat_readiness >= 90 ) then { _sleeptime = _sleeptime * 0.75 };
	if ( combat_readiness >= 95 ) then { _sleeptime = _sleeptime * 0.75 };

	sleep _sleeptime;

	waitUntil {
		sleep 5;
	 	combat_readiness >= 80 &&
	 	(armor_weight >= 80 || air_weight >= 80);

	 };

	 _target_player = objNull;
	 {
	 	if (!(isNull _target_player)) exitWith {};

	 	if (( armor_weight >= 75 ) && ((vehicle _x) isKindOf "Tank")) then {
	 		_target_player = _x;
	 	};

	 	if (( air_weight >= 75 ) && ((vehicle _x) isKindOf "Air")) then {
	 		_target_player = _x;
	 	};

	 } foreach allPlayers;

	 if (!(isNull _target_player)) then {
	 	_target_pos = [99999, getpos _target_player ] call F_getNearestSector;
	 	if ( _target_pos != "" ) then {
	 		[ _target_pos ] spawn spawn_air;
	 	};
	 };
};