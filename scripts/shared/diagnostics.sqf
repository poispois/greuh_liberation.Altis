private [ "_source" ];

_source = "";
if ( isServer ) then {
	_source = "Server";
} else {
	_source = name player;
};

while { true } do {
	diag_log format [ "Source: %1 - Time: %2 - FPS: %3 - Total units: %4 - Hostile units: %5 - Local units: %6 - Vehicles: %7 - Unitcap: %8",
	_source,
	time,
	diag_fps,
	count allUnits,
	{ side group _x == EAST || side group _x == RESISTANCE } count allUnits,
	{ local _x } count allUnits,
	count vehicles,
	GRLIB_sector_cap ];
	sleep 60;
};