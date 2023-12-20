/obj/structure/ghost_pod_glacial
	name = "Private Gateway"
	desc = "A gateway linked to private network for allowing one to teleport easily. Only Allows for travel to."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "tele0"
/obj/structure/ghost_pod_glacial/attack_ghost(var/mob/observer/dead/user)
	var/choice = tgui_alert(user, "Are you certain you wish to jump to here?", "Private Gateway", list("Yes", "No"))
	var/client/picked_client = user.client
	if((!choice || choice == "No") && picked_client)
		return

	glacial_gateway(picked_client)

/obj/structure/ghost_pod_glacial/proc/glacial_gateway(client/picked_client)
	if(!istype(picked_client))
		return
	var/spawnloc
	spawnloc = get_turf(src)
	var/mob/living/carbon/human/new_character
	new_character = new(spawnloc)
	if(!new_character)
		to_chat(picked_client, "Something went wrong and spawning failed.")
		return
	var/player_key = picked_client.key
	//VOREStation Add - Needed for persistence
	var/picked_ckey = picked_client.ckey
	var/picked_slot = picked_client.prefs.default_slot
	picked_client.prefs.copy_to(new_character)
	if(new_character.dna)
		new_character.dna.ResetUIFrom(new_character)
		new_character.sync_organ_dna()
	new_character.key = player_key
	//Were they any particular special role? If so, copy.
	if(new_character.mind)
		var/datum/antagonist/antag_data = get_antag_data(new_character.mind.special_role)
		if(antag_data)
			antag_data.add_antagonist(new_character.mind)
			antag_data.place_mob(new_character)
	//VOREStation Add - Required for persistence
	if(new_character.mind)
		new_character.mind.loaded_from_ckey = picked_ckey
		new_character.mind.loaded_from_slot = picked_slot
	//VOREStation Add End
	for(var/lang in picked_client.prefs.alternate_languages)
		var/datum/language/chosen_language = GLOB.all_languages[lang]
		if(chosen_language)
			if(is_lang_whitelisted(src,chosen_language) || (new_character.species && (chosen_language.name in new_character.species.secondary_langs)))
				new_character.add_language(lang)
	job_master.EquipRank(new_character, USELESS_JOB, 1)
	if(new_character.mind)
		new_character.mind.assigned_role = USELESS_JOB
		new_character.mind.role_alt_title = job_master.GetPlayerAltTitle(new_character, USELESS_JOB)
	new_character.regenerate_icons()
	new_character.update_transform()
	return new_character


//custom beds stuff because not making a new folder
/obj/item/weapon/bedsheet/New()
	update_transform()

#define BIG_BLANKET_CREATE(x)	x/big/icon_scale_x = 2.2;x/big/icon_scale_y = 2.2
#define HUGE_BLANKET_CREATE(x)	x/huge/icon_scale_x = 3.3;x/huge/icon_scale_y = 3.3
#define MEGA_BLANKET_CREATE(x)	x/mega/icon_scale_x = 9.9;x/mega/icon_scale_y = 9.9
#define CROW_BLANKET_CREATE(x)  x/crow/icon_scale_x = 1.6;x/crow/icon_scale_y = 1.6
BIG_BLANKET_CREATE(/obj/item/weapon/bedsheet/bluedouble)
BIG_BLANKET_CREATE(/obj/item/weapon/bedsheet/browndouble)
BIG_BLANKET_CREATE(/obj/item/weapon/bedsheet/captaindouble)
BIG_BLANKET_CREATE(/obj/item/weapon/bedsheet/clowndouble)
BIG_BLANKET_CREATE(/obj/item/weapon/bedsheet/cosmosdouble)
BIG_BLANKET_CREATE(/obj/item/weapon/bedsheet/double)
BIG_BLANKET_CREATE(/obj/item/weapon/bedsheet/greendouble)
BIG_BLANKET_CREATE(/obj/item/weapon/bedsheet/hopdouble)
BIG_BLANKET_CREATE(/obj/item/weapon/bedsheet/hosdouble)
BIG_BLANKET_CREATE(/obj/item/weapon/bedsheet/iandouble)
BIG_BLANKET_CREATE(/obj/item/weapon/bedsheet/mimedouble)
BIG_BLANKET_CREATE(/obj/item/weapon/bedsheet/orangedouble)
BIG_BLANKET_CREATE(/obj/item/weapon/bedsheet/piratedouble)
BIG_BLANKET_CREATE(/obj/item/weapon/bedsheet/purpledouble)
BIG_BLANKET_CREATE(/obj/item/weapon/bedsheet/rainbowdouble)
BIG_BLANKET_CREATE(/obj/item/weapon/bedsheet/rddouble)
BIG_BLANKET_CREATE(/obj/item/weapon/bedsheet/reddouble)
BIG_BLANKET_CREATE(/obj/item/weapon/bedsheet/yellowdouble)
HUGE_BLANKET_CREATE(/obj/item/weapon/bedsheet/bluedouble)
HUGE_BLANKET_CREATE(/obj/item/weapon/bedsheet/browndouble)
HUGE_BLANKET_CREATE(/obj/item/weapon/bedsheet/captaindouble)
HUGE_BLANKET_CREATE(/obj/item/weapon/bedsheet/clowndouble)
HUGE_BLANKET_CREATE(/obj/item/weapon/bedsheet/cosmosdouble)
HUGE_BLANKET_CREATE(/obj/item/weapon/bedsheet/double)
HUGE_BLANKET_CREATE(/obj/item/weapon/bedsheet/greendouble)
HUGE_BLANKET_CREATE(/obj/item/weapon/bedsheet/hopdouble)
HUGE_BLANKET_CREATE(/obj/item/weapon/bedsheet/hosdouble)
HUGE_BLANKET_CREATE(/obj/item/weapon/bedsheet/iandouble)
HUGE_BLANKET_CREATE(/obj/item/weapon/bedsheet/mimedouble)
HUGE_BLANKET_CREATE(/obj/item/weapon/bedsheet/orangedouble)
HUGE_BLANKET_CREATE(/obj/item/weapon/bedsheet/piratedouble)
HUGE_BLANKET_CREATE(/obj/item/weapon/bedsheet/purpledouble)
HUGE_BLANKET_CREATE(/obj/item/weapon/bedsheet/rainbowdouble)
HUGE_BLANKET_CREATE(/obj/item/weapon/bedsheet/rddouble)
HUGE_BLANKET_CREATE(/obj/item/weapon/bedsheet/reddouble)
HUGE_BLANKET_CREATE(/obj/item/weapon/bedsheet/yellowdouble)

CROW_BLANKET_CREATE(/obj/item/weapon/bedsheet/piratedouble)
//Giant Beds
/obj/structure/bed/double/big
	icon_scale_x = 2
	icon_scale_y = 2

/obj/structure/bed/double/huge
	icon_scale_x = 3
	icon_scale_y = 3

/obj/structure/bed/double/crow
	icon_scale_x = 1.5
	icon_scale_y = 1.5

/*
/obj/structure/bed/double/mega
	icon_scale_x = 9
	icon_scale_y = 9
*/
/obj/structure/bed/double/big/New(var/newloc)
	..(newloc,"wood","cotton")
	update_transform()

/obj/structure/bed/double/huge/New(var/newloc)
	..(newloc,"wood","cotton")
	update_transform()
/*
/obj/structure/bed/double/mega/New(var/newloc)
	..(newloc,"wood","cotton")
	update_transform()
*/

/obj/structure/bed/double/crow/New(var/newloc)
	..(newloc,"wood","cotton")
	update_transform()

/obj/structure/bed/double/big/post_buckle_mob(mob/living/M as mob)
	if(M.buckled == src)
		M.pixel_y = (25 + pixel_y)
		M.old_y = (25 + pixel_y)
		M.pixel_x = (pixel_x)
		M.old_x = (pixel_x)
	else
		M.pixel_y = 0
		M.old_y = 0
		M.pixel_x = 0
		M.old_x = 0

/obj/structure/bed/double/huge/post_buckle_mob(mob/living/M as mob)
	if(M.buckled == src)
		M.pixel_y = (37 + pixel_y)
		M.old_y = (37 + pixel_y)
		M.pixel_x = (pixel_x)
		M.old_x = (pixel_x)
	else
		M.pixel_y = 0
		M.old_y = 0
		M.pixel_x = 0
		M.old_x = 0

/obj/structure/bed/double/crow/post_buckle_mob(mob/living/M as mob)
	if(M.buckled == src)
		M.pixel_y = (19 + pixel_y)
		M.old_y = (19 + pixel_y)
		M.pixel_x = (pixel_x)
		M.old_x = (pixel_x)
	else
		M.pixel_y = 0
		M.old_y = 0
		M.pixel_x = 0
		M.old_x = 0

/*
/obj/structure/bed/double/mega/post_buckle_mob(mob/living/M as mob)
	if(M.buckled == src)
		M.pixel_y = (109 + pixel_y)
		M.old_y = (109 + pixel_y)
		M.pixel_x = (pixel_x)
		M.old_x = (pixel_x)
	else
		M.pixel_y = 0
		M.old_y = 0
		M.pixel_x = 0
		M.old_x = 0
*/


/turf/simulated/floor/water/glace_hotspring
	name = "Sauna"
	desc = "A Artificially maintained Sauna pool, continuously pumped and filtered hot for your pleasure!"
	edge_blending_priority = -2
	movement_cost = 4
	depth = 2
	water_state = "water_shallow"
	outdoors = FALSE

/turf/simulated/floor/water/hotspring/Entered(atom/movable/AM, atom/oldloc)
	if(istype(AM, /mob/living))
		var/mob/living/L = AM
		L.update_water()
		if(L.check_submerged() <= 0)
			return
		if(!istype(oldloc, /turf/simulated/floor/water/glace_hotspring))
			to_chat(L, "<span class='warning'>You feel an overwhelming wave of warmth from entering \the [src]!</span>")
	AM.water_act(5)
	..()

/turf/simulated/floor/ramptop
	name = "stairs"
	icon = 'icons/obj/structures/multiz.dmi'
	icon_state = "stair_u"


/obj/structure/fitness/weightlifter/crow
	icon_scale_x = 1.5
	icon_scale_y = 1.5
/obj/structure/fitness/weightlifter/crow/New()
	update_transform()
/obj/machinery/fitness/heavy/lifter/crow
	icon_scale_x = 1.5
	icon_scale_y = 1.5
/obj/machinery/fitness/heavy/lifter/crow/New()
	update_transform()
