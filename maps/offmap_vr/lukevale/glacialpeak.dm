/datum/map_template/om_ships/glacial
	name = "Offmap Ship - Glacial Peak (New Z)"
	desc = "Offmap spawn ship, The Glacial Peak"
	mappath = 'glacialpeak.dmm'


//Areas
/area/glace
	name = "\improper PES Glacial Peak"
	icon = 'icons/turf/areas_vr_talon.dmi'
	icon_state = "dark"
	requires_power = 1
	has_gravity = 1
	flags = RAD_SHIELDED
	dynamic_lighting = TRUE
	limit_mob_size = FALSE

//End of Areas

/obj/effect/overmap/visitable/ship/glace
	name = "PES Glacial Peak"
	desc = "Spacefaring vessel. Friendly IFF detected."
	scanner_desc = @{"[i]Registration[/i]: PES Glacial Pea
[i]Class[/i]: Frigate
[i]Transponder[/i]: Transmitting (CIV)
[b]Notice[/b]: Centeral Command Vessal"}
	color = "#aacccc"
	vessel_mass = 90000
	vessel_size = SHIP_SIZE_LARGE
//	initial_generic_waypoints = list("glacial_fore", "glacial_aft")
//	initial_restricted_waypoints = list("The IceBreaker" = list("omship_ship_icebreak"))
	fore_dir = NORTH
	known = TRUE
