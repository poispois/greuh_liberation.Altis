private [ "_dialog", "_fob" ];

dorepackage = 0;

_dialog = createDialog "liberation_repackage_fob";
waitUntil { dialog };

while { dialog && alive player && dorepackage == 0 } do {
	sleep 0.1;
};

if ( dorepackage > 0 ) then {
	closeDialog 0;
	waitUntil { !dialog };

	_fob = [] call F_getNearestFob;

	if ( count _fob > 0 ) then {
		GRLIB_all_fobs = GRLIB_all_fobs - [ _fob ];
		publicVariable "GRLIB_all_fobs";
	};

	{ deleteVehicle _x }  foreach ( (getpos player) nearobjects [ FOB_typename, 250 ]);

	sleep 0.5;

	_spawnpos = [0,0,0];
	while { surfaceIsWater _spawnpos } do {
		_spawnpos = ( getpos player ) findEmptyPosition [10, 250, 'B_Heli_Transport_01_F'];
		if ( count _spawnpos == 0 ) then { _spawnpos = [0,0,0]; };
	};

	if ( dorepackage == 1 ) then {
		FOB_box_typename createVehicle _spawnpos;
	};

	if ( dorepackage == 2 ) then {
		FOB_truck_typename createVehicle _spawnpos;
	};

	hint localize "STR_FOB_REPACKAGE_HINT";

};