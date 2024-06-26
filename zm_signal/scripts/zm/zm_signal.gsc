#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\compass;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#using scripts\shared\spawner_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#insert scripts\zm\_zm_utility.gsh;

#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;

#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_utility;

//Perks
#using scripts\zm\_zm_pack_a_punch;
#using scripts\zm\_zm_pack_a_punch_util;
#using scripts\zm\_zm_perk_additionalprimaryweapon;
#using scripts\zm\_zm_perk_doubletap2;
#using scripts\zm\_zm_perk_deadshot;
#using scripts\zm\_zm_perk_juggernaut;
#using scripts\zm\_zm_perk_quick_revive;
#using scripts\zm\_zm_perk_sleight_of_hand;
#using scripts\zm\_zm_perk_staminup;
#using scripts\zm\_zm_perk_electric_cherry;
#using scripts\zm\_zm_perk_widows_wine;
#using scripts\zm\_zm_perk_vulture_aid;
#using scripts\zm\logical\perks\_zm_perk_ffyl;
#using scripts\zm\logical\perks\_zm_perk_icu;
#using scripts\zm\logical\perks\_zm_perk_tactiquilla;





// ASTRO ZOMBIE
#using scripts\zm\_zm_ai_astro;

// MARGWA
#using scripts\zm\_hb21_zm_ai_margwa;


// CIVIL PROTECTOR
#using scripts\zm\zm_zod_robot;




//Powerups
#using scripts\zm\_zm_powerup_double_points;
#using scripts\zm\_zm_powerup_carpenter;
#using scripts\zm\_zm_powerup_fire_sale;
#using scripts\zm\_zm_powerup_free_perk;
#using scripts\zm\_zm_powerup_full_ammo;
#using scripts\zm\_zm_powerup_insta_kill;
#using scripts\zm\_zm_powerup_nuke;
//#using scripts\zm\_zm_powerup_weapon_minigun;

// Sphynx's Craftables
#using scripts\Sphynx\_zm_sphynx_util;

//Box
#using scripts\zm\_hb21_zm_magicbox;

//T6 HUD
#using scripts\zm\_zm_t6_deathanim;

//Traps
#using scripts\zm\_zm_trap_electric;

#using scripts\zm\zm_usermap;


// Sphynx's Craftables
	#using scripts\Sphynx\craftables\_zm_craft_gravityspikes;

#using scripts\_redspace\rs_o_jump_pad;


#using scripts\zm\growing_soulbox;


#using scripts\zm\_zm_perks;


#using scripts\zm\_hb21_zm_behavior;



// NSZ Kino Teleporter
#using scripts\_NSZ\nsz_kino_teleporter;


// NSZ Buyable Ending
#using scripts\_NSZ\nsz_buyable_ending;


// DRAGONHEADS
#using scripts\zm\zm_castle_weap_quest;




//*****************************************************************************
// MAIN
//*****************************************************************************

function main()
{	

		// NSZ Temp Wall Buys
	level thread buyable_ending::init();

	

	zm_usermap::main();

	// changing starting points
level.player_starting_points = 1500;
	level.perk_purchase_limit = 20;

	 level._zombie_custom_add_weapons =&custom_add_weapons;
 level.pack_a_punch_camo_index = 121;
 level.pack_a_punch_camo_index = 122;
 level.pack_a_punch_camo_index = 123;
    level.pack_a_punch_camo_index_number_variants = 3;

	
	level._zombie_custom_add_weapons =&custom_add_weapons;
	
	//Setup the levels Zombie Zone Volumes
	level.zones = [];
	level.zone_manager_init_func =&usermap_test_zone_init;
	init_zones[0] = "start_zone";
	level thread zm_zonemgr::manage_zones( init_zones );

	level.pathdist_type = PATHDIST_ORIGINAL;

	thread zm_sphynx_util::change_delay_between_rounds( 0.1 );
	thread zm_sphynx_util::enable_non_stop_dog_spawning(8, 5, 18, 24);
	thread zm_sphynx_util::enable_player_voice_lines();
	

	
	

	thread MusicToggle();
	thread eeDoor();
	thread hideEE();
	thread Hold_position();
	thread teleport_zombies_init();
	thread Moon_easter_egg();
	thread player_teleporter_init();
	thread keys_ee();
	thread cofee();
	thread shoot_challenge();
	thread plants();
	thread tv();
	thread side_quest();
	thread final_step_1_init();
	thread backrooms_ee();
	thread corpsy_init();
	thread radio_ee();
	thread floor_is_lava();
	thread quest_2_ending();
	thread crashing_ship_function();
	thread build_signal();
	thread teddys_ee();

	grow_soul::init(  );

	spawner::add_archetype_spawn_function( "zombie", &test );

		// NSZ Kino Teleporter
	level thread nsz_kino_teleporter::init(); 


	

}


function usermap_test_zone_init()
{
	zm_zonemgr::add_adjacent_zone("start_zone", "zone_1", "start_zone_zone_1" );
    zm_zonemgr::add_adjacent_zone("zone_1", "zone_2", "zone_1_zone_2" );
    zm_zonemgr::add_adjacent_zone("zone_1", "zone_br", "zone_1_zone_br" );
    zm_zonemgr::add_adjacent_zone("zone_2", "zone_3", "zone_2_zone_3" );
    zm_zonemgr::add_adjacent_zone("zone_3", "zone_4", "zone_3_zone_4" );
    zm_zonemgr::add_adjacent_zone("zone_4", "zone_5", "zone_4_zone_5" );
    zm_zonemgr::add_adjacent_zone("zone_5", "zone_6", "zone_5_zone_6" );
    zm_zonemgr::add_adjacent_zone("zone_6", "zone_7", "zone_6_zone_7" );
    zm_zonemgr::add_adjacent_zone("zone_7", "zone_8", "zone_7_zone_8" );
    zm_zonemgr::add_adjacent_zone("zone_8", "zone_9", "zone_8_zone_9" );
    zm_zonemgr::add_adjacent_zone("zone_9", "zone_10", "zone_9_zone_10" );
    zm_zonemgr::add_adjacent_zone("zone_9", "zone_11", "zone_9_zone_11" );
    zm_zonemgr::add_adjacent_zone("zone_7", "zone_final", "zone_7_zone_final" );
    zm_zonemgr::add_adjacent_zone("zone_3", "zone_final", "zone_3_zone_final" );
    zm_zonemgr::add_adjacent_zone("zone_final", "zone_pre", "zone_final_zone_pre" );
    zm_zonemgr::add_adjacent_zone("break_zone", "zone_2_end", "break_zone_zone_2_end" );


	//level flag::init( "always_on" );
	//level flag::set( "always_on" );
}	

function custom_add_weapons()
{
	zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_levelcommon_weapons.csv", 1);
}

function test()
{
    self hb21_zm_behavior::enable_side_step();
}

///////////////////////////////////////////////////////////////////////////////////////////////
///HINTS
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function current_step0()
{	
	
	thread step_0( " ^1LEVEL 1", 85, 63, 1.2, 5 );
    thread step_0( " Activate and hold 4 positions ", 85, 50, 1.2, 5 );
}
 
function step_0( text, align_x, align_y, font_scale, fade_time )
{
    hud = NewHudElem();
    hud.foreground = true;
    hud.fontScale = font_scale;
    hud.sort = 1;
    hud.hidewheninmenu = false;
    hud.alignX = "left";
    hud.alignY = "bottom";
    hud.horzAlign = "left";
    hud.vertAlign = "bottom";
    hud.x = align_x;
    hud.y = hud.y - align_y;
    hud.alpha = 1;
    hud SetText( text );
   level waittill("end_step_0");
    hud Destroy();
    thread current_step1();
}

///////////////////////////

function current_step1()
{
	thread step_1( " ^1LEVEL 2", 85, 73, 1.2, 5 );
    thread step_1( " Activate 4 levers (in order) / Shoot 4 cells ", 85, 60, 1.2, 5 );
    thread step_1( " Activate 4 runes in order (this step reset if wrong) // hints > front > pillars ", 85, 50, 1.2, 5 );
}
 
function step_1( text, align_x, align_y, font_scale, fade_time )
{
    hud = NewHudElem();
    hud.foreground = true;
    hud.fontScale = font_scale;
    hud.sort = 1;
    hud.hidewheninmenu = false;
    hud.alignX = "left";
    hud.alignY = "bottom";
    hud.horzAlign = "left";
    hud.vertAlign = "bottom";
    hud.x = align_x;
    hud.y = hud.y - align_y;
    hud.alpha = 1;
    hud SetText( text );
   level waittill("end_step_1");
    hud Destroy();
    thread current_step2();
}

/////////////////////////////////////

function current_step2()
{
	thread step_2( " ^1LEVEL 3", 85, 63, 1.2, 5 );
    thread step_2( " Shoot 10 targets ", 85, 50, 1.2, 5 );
}
 
function step_2( text, align_x, align_y, font_scale, fade_time )
{
    hud = NewHudElem();
    hud.foreground = true;
    hud.fontScale = font_scale;
    hud.sort = 1;
    hud.hidewheninmenu = false;
    hud.alignX = "left";
    hud.alignY = "bottom";
    hud.horzAlign = "left";
    hud.vertAlign = "bottom";
    hud.x = align_x;
    hud.y = hud.y - align_y;
    hud.alpha = 1;
    hud SetText( text );
   level waittill("end_step_2");
    hud Destroy();
    thread current_step3();
}

/////////////////////////////////////

function current_step3()
{
	thread step_3( " ^1LEVEL 4", 85, 63, 1.2, 5 );
    thread step_3( " Fill 8 soulboxes ", 85, 50, 1.2, 5 );
}
 
function step_3( text, align_x, align_y, font_scale, fade_time )
{
    hud = NewHudElem();
    hud.foreground = true;
    hud.fontScale = font_scale;
    hud.sort = 1;
    hud.hidewheninmenu = false;
    hud.alignX = "left";
    hud.alignY = "bottom";
    hud.horzAlign = "left";
    hud.vertAlign = "bottom";
    hud.x = align_x;
    hud.y = hud.y - align_y;
    hud.alpha = 1;
    hud SetText( text );
   level waittill("end_step_3");
    hud Destroy();

    thread current_step4();
    
}

//////////////////////////////////////

function current_step4()
{
	thread step_4( " ^1LEVEL 5", 85, 73, 1.2, 5 );
    thread step_4( " Find & place 4 canisters / Find & place 4 nitrogen tank / Activate canisters /", 85, 60, 1.2, 5 );
    thread step_4( " Find Shovel / Digup relic / find 5 seeds (Moon) ", 85, 50, 1.2, 5 );
}
 
function step_4( text, align_x, align_y, font_scale, fade_time )
{
    hud = NewHudElem();
    hud.foreground = true;
    hud.fontScale = font_scale;
    hud.sort = 1;
    hud.hidewheninmenu = false;
    hud.alignX = "left";
    hud.alignY = "bottom";
    hud.horzAlign = "left";
    hud.vertAlign = "bottom";
    hud.x = align_x;
    hud.y = hud.y - align_y;
    hud.alpha = 1;
    hud SetText( text );
   level waittill("end_step_4");
    hud Destroy();

    
    
}


//////////////////////////////////////

function current_step5()
{
	
    thread step_5( " ^1Something is above the dome on moon... ", 85, 50, 1.2, 5 );
}
 
function step_5( text, align_x, align_y, font_scale, fade_time )
{
    hud = NewHudElem();
    hud.foreground = true;
    hud.fontScale = font_scale;
    hud.sort = 1;
    hud.hidewheninmenu = false;
    hud.alignX = "left";
    hud.alignY = "bottom";
    hud.horzAlign = "left";
    hud.vertAlign = "bottom";
    hud.x = align_x;
    hud.y = hud.y - align_y;
    hud.alpha = 1;
    hud SetText( text );
   level waittill("end_step_5");
    hud Destroy();

    
    
}


//////////////////////////////////////

function current_step6()
{
	
    thread step_6( " ^1Launch the second mission at the H.Q ", 85, 50, 1.2, 5 );
}
 
function step_6( text, align_x, align_y, font_scale, fade_time )
{
    hud = NewHudElem();
    hud.foreground = true;
    hud.fontScale = font_scale;
    hud.sort = 1;
    hud.hidewheninmenu = false;
    hud.alignX = "left";
    hud.alignY = "bottom";
    hud.horzAlign = "left";
    hud.vertAlign = "bottom";
    hud.x = align_x;
    hud.y = hud.y - align_y;
    hud.alpha = 1;
    hud SetText( text );
   level waittill("end_step_6");
    hud Destroy();

    
    
}

//////////////////////////////////////////////
//JUKEBOX
/////////////////////////////////////////////

function MusicToggle()
{
	jukebox = GetEnt("soundLoc","targetname");
	jukebox.numberOfSongs = 2;
	jukebox.previousSongNum = 0;
	
    trig = GetEnt("musTrigger", "targetname");
    trig SetCursorHint("HINT_NOICON");
	trig SetHintString("Turn on the power first!");
	level waittill("power_on");
	model = GetEnt("jukeboxModel","targetname");
	model SetModel("cp_town_jukebox");
    
    while(isdefined(self))
    {
        str_concat = ( IS_TRUE(level.copyright_music_enabled) ? "disable": "enable" );
		trig SetHintString("Press ^3[{+activate}]^7 to &&1 music", str_concat);
        trig waittill("trigger", player);
        level.copyright_music_enabled = ( IS_TRUE(level.copyright_music_enabled) ? false : true );

		if(level.copyright_music_enabled == false)
		{
			jukebox thread endSong();
		}
		else
		{
			wait(0.1);
			jukebox thread JukeBoxRandom();
		}
    }
}

function JukeBoxRandom()
{
	self endon("endRandom");

    while(isdefined(self))
    {
		self.songNum = RandomIntRange(0,self.numberOfSongs);
		if(self.previousSongNum != self.songNum)
		{
			self.previousSongNum = self.songNum;
			self PlaySoundWithNotify("jukesong" + self.songNum, "endMus");
			self waittill("endMus");
			wait(0.5);
		}
	}
}

function endSong()
{
	for(i=0; i < self.numberOfSongs; i++)
	{
		self StopSound("jukesong" + i);
	}
	self flag::set("endRandom");
}





///////////////////////////////////////////
//Easter egg QUIGMIRE
///////////////////////////////////////////

function hideEE()
{
	level waittill("initial_blackscreen_passed");

	level.rune1 = GetEnt("rune1","targetname");
	level.rune1 Hide();

	level.rune2 = GetEnt("rune2","targetname");
	level.rune2 Hide();

	level.rune3 = GetEnt("rune3","targetname");
	level.rune3 Hide();

	level.rune4 = GetEnt("rune4","targetname");
	level.rune4 Hide();

	////////////////


		level.shootmodel1 = GetEntArray("shootmodel1", "targetname");
		foreach(model in level.shootmodel1)
		{
			model Hide();
			
		}

		
		level.shootmodel2 = GetEntArray("shootmodel2", "targetname");
		foreach(model in level.shootmodel2)
		{
			model Hide();
			
		}
		
		level.shootmodel3 = GetEntArray("shootmodel3", "targetname");
		foreach(model in level.shootmodel3)
		{
			model Hide();
			
		}
		
		level.shootmodel4 = GetEntArray("shootmodel4", "targetname");
		foreach(model in level.shootmodel4)
		{
			model Hide();
			
		}
		
		

		//////////

		level.shoottrig1 = GetEnt("shoottrig1", "targetname");
		level.shoottrig1 Hide();

		level.shoottrig2 = GetEnt("shoottrig2", "targetname");
		level.shoottrig2 Hide();

		level.shoottrig3 = GetEnt("shoottrig3", "targetname");
		level.shoottrig3 Hide();

		level.shoottrig4 = GetEnt("shoottrig4", "targetname");
		level.shoottrig4 Hide();


///////////////////
level.rightrunesmodel = GetEntArray("rightrunes", "targetname");
level.wrongrunesmodel = GetEntArray("wrongrunes", "targetname");

///////////////////


//////////////////
	level.rightrunetrig1 = GetEnt("right1", "targetname");
	level.rightrunetrig1 SetHintString("Press ^3[{+activate}]^7 to activate the rune");	
	level.rightrunetrig1 SetCursorHint("HINT_INTERACT");
	level.rightrunetrig1 Hide(); 
	//////
	level.rightrunetrig2 = GetEnt("right2", "targetname");
	level.rightrunetrig2 SetHintString("Press ^3[{+activate}]^7 to activate the rune");	
	level.rightrunetrig2 SetCursorHint("HINT_INTERACT");
	level.rightrunetrig2 Hide();
	//////
	level.rightrunetrig3 = GetEnt("right3", "targetname");
	level.rightrunetrig3 SetHintString("Press ^3[{+activate}]^7 to activate the rune");	
	level.rightrunetrig3 SetCursorHint("HINT_INTERACT");
	level.rightrunetrig3 Hide();
	//////
	level.rightrunetrig4 = GetEnt("right4", "targetname");
	level.rightrunetrig4 SetHintString("Press ^3[{+activate}]^7 to activate the rune");	
	level.rightrunetrig4 SetCursorHint("HINT_INTERACT");
	level.rightrunetrig4 Hide();
	//////
	level.rightrunetrig5 = GetEnt("right5", "targetname");
	level.rightrunetrig5 SetHintString("Press ^3[{+activate}]^7 to activate the rune");	
	level.rightrunetrig5 SetCursorHint("HINT_INTERACT");
	level.rightrunetrig5 Hide();
	//////
	level.rightrunetrig6 = GetEnt("right6", "targetname");
	level.rightrunetrig6 SetHintString("Press ^3[{+activate}]^7 to activate the rune");	
	level.rightrunetrig6 SetCursorHint("HINT_INTERACT");
	level.rightrunetrig6 Hide();
	/////
	level.rightrunetrig7 = GetEnt("right7", "targetname");
	level.rightrunetrig7 SetHintString("Press ^3[{+activate}]^7 to activate the rune");	
	level.rightrunetrig7 SetCursorHint("HINT_INTERACT");
	level.rightrunetrig7 Hide();
	/////
	level.rightrunetrig8 = GetEnt("right8", "targetname");
	level.rightrunetrig8 SetHintString("Press ^3[{+activate}]^7 to activate the rune");	
	level.rightrunetrig8 SetCursorHint("HINT_INTERACT");
	level.rightrunetrig8 Hide();
	/////
	level.rightrunetrig9 = GetEnt("right9", "targetname");
	level.rightrunetrig9 SetHintString("Press ^3[{+activate}]^7 to activate the rune");	
	level.rightrunetrig9 SetCursorHint("HINT_INTERACT");
	level.rightrunetrig9 Hide();
	/////
	level.rightrunetrig10 = GetEnt("right10", "targetname");
	level.rightrunetrig10 SetHintString("Press ^3[{+activate}]^7 to activate the rune");	
	level.rightrunetrig10 SetCursorHint("HINT_INTERACT");
	level.rightrunetrig10 Hide();
	/////
	level.rightrunetrig11 = GetEnt("right11", "targetname");
	level.rightrunetrig11 SetHintString("Press ^3[{+activate}]^7 to activate the rune");	
	level.rightrunetrig11 SetCursorHint("HINT_INTERACT");
	level.rightrunetrig11 Hide();
	/////
	level.rightrunetrig12 = GetEnt("right12", "targetname");
	level.rightrunetrig12 SetHintString("Press ^3[{+activate}]^7 to activate the rune");	
	level.rightrunetrig12 SetCursorHint("HINT_INTERACT");
	level.rightrunetrig12 Hide();
	/////
	level.rightrunetrig13 = GetEnt("right13", "targetname");
	level.rightrunetrig13 SetHintString("Press ^3[{+activate}]^7 to activate the rune");	
	level.rightrunetrig13 SetCursorHint("HINT_INTERACT");
	level.rightrunetrig13 Hide();
	/////
	level.rightrunetrig14 = GetEnt("right14", "targetname");
	level.rightrunetrig14 SetHintString("Press ^3[{+activate}]^7 to activate the rune");	
	level.rightrunetrig14 SetCursorHint("HINT_INTERACT");
	level.rightrunetrig14 Hide();
	/////
	level.rightrunetrig15 = GetEnt("right15", "targetname");
	level.rightrunetrig15 SetHintString("Press ^3[{+activate}]^7 to activate the rune");	
	level.rightrunetrig15 SetCursorHint("HINT_INTERACT");
	level.rightrunetrig15 Hide();
	/////
	level.rightrunetrig16 = GetEnt("right16", "targetname");
	level.rightrunetrig16 SetHintString("Press ^3[{+activate}]^7 to activate the rune");	
	level.rightrunetrig16 SetCursorHint("HINT_INTERACT");
	level.rightrunetrig16 Hide();

	thread activatepillar1();

}
////////hints



function activatepillar1()
{
	exploder::exploder("lever_1");
	level.trig1 = GetEnt("levertrig1", "targetname");
	level.trig1 SetHintString("Press ^3[{+activate}]^7 to activate the lever");	
	level.trig1 SetCursorHint("HINT_INTERACT");
		
	level.model = GetEnt("pillar1","targetname");

	level.trig1 waittill("trigger", player);
	exploder::kill_exploder("lever_1");
	level.model MoveZ(90,3);
	player PlaySound("movingrock");
	wait(3);
	IPrintLnBold("a secret pillar has appeared");

	level.trig1 Hide();

	wait(1);

	IPrintLnBold("levers 1/4");

	thread activatepillar2();

}

function activatepillar2()
{
	exploder::exploder("lever_2");
	level.trig2 = GetEnt("levertrig2", "targetname");
	level.trig2 SetHintString("Press ^3[{+activate}]^7 to activate the lever");	
	level.trig2 SetCursorHint("HINT_INTERACT");
	level.trig2 Show();
		
	level.model2 = GetEnt("pillar2","targetname");

	level.trig2 waittill("trigger", player);
	exploder::kill_exploder("lever_2");
	level.model2 MoveZ(90,3);
	player PlaySound("movingrock");
	wait(3);
	IPrintLnBold("a secret pillar has appeared");

	level.trig2 Hide();

	wait(1);

	IPrintLnBold("levers 2/4");

	thread activatepillar3();

}


function activatepillar3()
{
	exploder::exploder("lever_3");
	level.trig3 = GetEnt("levertrig3", "targetname");
	level.trig3 SetHintString("Press ^3[{+activate}]^7 to activate the lever");	
	level.trig3 SetCursorHint("HINT_INTERACT");
	level.trig3 Show();
		
	level.model3 = GetEnt("pillar3","targetname");

	level.trig3 waittill("trigger", player);
	exploder::kill_exploder("lever_3");
	level.model3 MoveZ(90,3);
	player PlaySound("movingrock");
	wait(3);
	IPrintLnBold("a secret pillar has appeared");

	level.trig3 Hide();

	wait(1);

	IPrintLnBold("levers 3/4");

	thread activatepillar4();

}


function activatepillar4()
{
	exploder::exploder("lever_4");
	level.trig4 = GetEnt("levertrig4", "targetname");
	level.trig4 SetHintString("Press ^3[{+activate}]^7 to activate the lever");	
	level.trig4 SetCursorHint("HINT_INTERACT");
	level.trig4 Show();
		
	level.model4 = GetEnt("pillar4","targetname");

	level.trig4 waittill("trigger", player);
	exploder::kill_exploder("lever_4");
	level.model4 MoveZ(90,3);
	player PlaySound("movingrock");
	wait(3);
	IPrintLnBold("all the pillars have been deployed");

	IPrintLnBold("neutralize energy cells 0/4 (shootable)");


	level.trig4 Hide();

	
	

	thread shootable1();

}



function shootable1()
{

	foreach(model in level.shootmodel1)
		{
			model Show();
			
		}
	
	level.shoottrig1 Show();

		level.shoottrig1 waittill("trigger", player);
		IPrintLnBold("cells 1/4");
		player PlaySound("eclat");
		IPrintLn("Trigger 1 Shot");

		foreach(model in level.shootmodel1)
		{
			model Hide();
			
		}
		
		level.shoottrig1 Hide();


		level.rune1 Show();

		thread shootable2();
			
}



function shootable2()
{
	foreach(model in level.shootmodel2)
		{
			model Show();
			
		}

	level.shoottrig2 Show();

	level.shoottrig2 waittill("trigger", player);
	IPrintLnBold("cells 2/4");
	player PlaySound("eclat");

	foreach(model in level.shootmodel2)
		{
			model Hide();
			
		}
	
	level.shoottrig2 Hide();


	level.rune2 Show();

	thread shootable3();

}

function shootable3()
{
	foreach(model in level.shootmodel3)
		{
			model Show();
		}

	level.shoottrig3 Show();

	level.shoottrig3 waittill("trigger", player);
	IPrintLnBold("cells 3/4");
	player PlaySound("eclat");

	foreach(model in level.shootmodel3)
		{
			model Hide();
		}
	
	level.shoottrig3 Hide();


	level.rune3 Show();

	thread shootable4();

}

function shootable4()
{
	foreach(model in level.shootmodel4)
		{
			model Show();
		}

	level.shoottrig4 Show();

	level.shoottrig4 waittill("trigger", player);
	IPrintLnBold("cells 4/4");
	player PlaySound("eclat");

	foreach(model in level.shootmodel4)
		{
			model Hide();
		}
	
	level.shoottrig4 Hide();


	level.rune4 Show();

	IPrintLnBold(" good job, now activate the runes in order... (hint > front > pillars)");

	exploder::exploder("pillar_1");
	exploder::exploder("pillar_2");
	exploder::exploder("pillar_3");
	exploder::exploder("pillar_4");

	

	thread rune1();
	thread rune2();
	thread rune3();
	thread rune4();
	

}

///////////////////////////
//RUNE STEP 1

function rune1()
{
	

	level.rightrunetrig1 Show();

	level.rightrunetrig1 waittill("trigger", player);

	IPrintLnBold("right rune 1/4");

	level.rightrunetrig1 Hide();
	level.rightrunetrig2 Hide();
	level.rightrunetrig3 Hide();
	level.rightrunetrig4 Hide();

	thread rune5();
	thread rune6();
	thread rune7();
	thread rune8();
	
	
}


function rune2()
{		

	

	

	level.rightrunetrig2 Show();

	level.rightrunetrig2 waittill("trigger", player);


	level.rightrunetrig1 Hide();
	level.rightrunetrig2 Hide();
	level.rightrunetrig3 Hide();
	level.rightrunetrig4 Hide();

	thread resetsystem();
	
}

function rune3()
{	
	
	

	level.rightrunetrig3 Show();

	level.rightrunetrig3 waittill("trigger", player);


	level.rightrunetrig1 Hide();
	level.rightrunetrig2 Hide();
	level.rightrunetrig3 Hide();
	level.rightrunetrig4 Hide();

	thread resetsystem();

	
}

function rune4()
{	
	
	

	

	level.rightrunetrig4 Show();

	level.rightrunetrig4 waittill("trigger", player);
	

	level.rightrunetrig1 Hide();
	level.rightrunetrig2 Hide();
	level.rightrunetrig3 Hide();
	level.rightrunetrig4 Hide();

	thread resetsystem();
	
	
}

//////////////////////////////////
//RUNE STEP 2

function rune5()
{
	

	level.rightrunetrig5 Show();

	level.rightrunetrig5 waittill("trigger", player);

	IPrintLnBold("right rune 2/4");

	level.rightrunetrig5 Hide();
	level.rightrunetrig6 Hide();
	level.rightrunetrig7 Hide();
	level.rightrunetrig8 Hide();

	thread rune9();
	thread rune10();
	thread rune11();
	thread rune12();
	
	
}

function rune6()
{		

	

	

	level.rightrunetrig6 Show();

	level.rightrunetrig6 waittill("trigger", player);


	level.rightrunetrig5 Hide();
	level.rightrunetrig6 Hide();
	level.rightrunetrig7 Hide();
	level.rightrunetrig8 Hide();

	thread resetsystem();
	
}

function rune7()
{	
	
	

	level.rightrunetrig7 Show();

	level.rightrunetrig7 waittill("trigger", player);


	level.rightrunetrig5 Hide();
	level.rightrunetrig6 Hide();
	level.rightrunetrig7 Hide();
	level.rightrunetrig8 Hide();

	thread resetsystem();

	
}

function rune8()
{	
	
	

	

	level.rightrunetrig8 Show();

	level.rightrunetrig8 waittill("trigger", player);
	

	level.rightrunetrig5 Hide();
	level.rightrunetrig6 Hide();
	level.rightrunetrig7 Hide();
	level.rightrunetrig8 Hide();

	thread resetsystem();
	
	
}


//////////////////////////////////
//RUNE STEEP 3

function rune9()
{
	

	level.rightrunetrig9 Show();

	level.rightrunetrig9 waittill("trigger", player);

	IPrintLnBold("right rune 3/4");

	level.rightrunetrig9 Hide();
	level.rightrunetrig10 Hide();
	level.rightrunetrig11 Hide();
	level.rightrunetrig12 Hide();

	thread rune13();
	thread rune14();
	thread rune15();
	thread rune16();
	
	
}

function rune10()
{		

	

	

	level.rightrunetrig10 Show();

	level.rightrunetrig10 waittill("trigger", player);


	level.rightrunetrig9 Hide();
	level.rightrunetrig10 Hide();
	level.rightrunetrig11 Hide();
	level.rightrunetrig12 Hide();

	thread resetsystem();
	
}

function rune11()
{	
	
	

	level.rightrunetrig11 Show();

	level.rightrunetrig11 waittill("trigger", player);


	level.rightrunetrig9 Hide();
	level.rightrunetrig10 Hide();
	level.rightrunetrig11 Hide();
	level.rightrunetrig12 Hide();

	thread resetsystem();

	
}

function rune12()
{	
	
	

	

	level.rightrunetrig12 Show();

	level.rightrunetrig12 waittill("trigger", player);
	

	level.rightrunetrig9 Hide();
	level.rightrunetrig10 Hide();
	level.rightrunetrig11 Hide();
	level.rightrunetrig12 Hide();

	thread resetsystem();
	
	
}


//////////////////////////////////
//RUNE STEEP 3

function rune13()
{
	

	level.rightrunetrig13 Show();

	level.rightrunetrig13 waittill("trigger", player);

	IPrintLnBold("right rune 4/4");

	level.rightrunetrig13 Hide();
	level.rightrunetrig14 Hide();
	level.rightrunetrig15 Hide();
	level.rightrunetrig16 Hide();

	thread rewardenigma();
	
	
}

function rune14()
{		

	

	

	level.rightrunetrig14 Show();

	level.rightrunetrig14 waittill("trigger", player);


	level.rightrunetrig13 Hide();
	level.rightrunetrig14 Hide();
	level.rightrunetrig15 Hide();
	level.rightrunetrig16 Hide();

	thread resetsystem();
	
}

function rune15()
{	
	
	

	level.rightrunetrig15 Show();

	level.rightrunetrig15 waittill("trigger", player);


	level.rightrunetrig13 Hide();
	level.rightrunetrig14 Hide();
	level.rightrunetrig15 Hide();
	level.rightrunetrig16 Hide();

	thread resetsystem();

	
}

function rune16()
{	
	
	

	

	level.rightrunetrig16 Show();

	level.rightrunetrig16 waittill("trigger", player);
	

	level.rightrunetrig13 Hide();
	level.rightrunetrig14 Hide();
	level.rightrunetrig15 Hide();
	level.rightrunetrig16 Hide();

	thread resetsystem();
	
	
}


function resetsystem()
{
	

	IPrintLnBold("wrong rune order, reset all runes...(try again from the first one)");


	thread rune1();
	

}

function rewardenigma()
{	
	exploder::kill_exploder("pillar_1");
	exploder::kill_exploder("pillar_2");
	exploder::kill_exploder("pillar_3");
	exploder::kill_exploder("pillar_4");

	level.rightrunetrig1 Delete(); 
	level.rightrunetrig2 Delete();
	level.rightrunetrig3 Delete();
	level.rightrunetrig4 Delete();
	level.rightrunetrig5 Delete();
	level.rightrunetrig6 Delete();
	level.rightrunetrig7 Delete();
	level.rightrunetrig8 Delete();
	level.rightrunetrig9 Delete();
	level.rightrunetrig10 Delete();
	level.rightrunetrig11 Delete();
	level.rightrunetrig12 Delete();
	level.rightrunetrig13 Delete();
	level.rightrunetrig14 Delete();
	level.rightrunetrig15 Delete();
	level.rightrunetrig16 Delete();

	foreach(player in GetPlayers())
		{	
			player PlaySound("win_chall");
			
		}

	levelmodel = GetEnt("pillarend", "targetname");
	brushmodel = GetEnt("brushend", "targetname");

	levelmodel Delete();
	brushmodel Delete();

	
	
	
}


///////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////// 

//SNOW CAVE 

function eeDoor()
{

	level waittill("initial_blackscreen_passed");

	level.ee_models1 = GetEnt("ee_model", "targetname");
	level.ee_trigs1 = GetEnt("ee_trig", "targetname");


	level.ee_models2 = GetEnt("ee_model2", "targetname");
	level.ee_trigs2 = GetEnt("ee_trig2", "targetname");
	level.ee_models2 Hide();
	level.ee_trigs2 Hide();


	level.ee_models3 = GetEnt("ee_model3", "targetname");
	level.ee_trigs3 = GetEnt("ee_trig3", "targetname");
	level.ee_models3 Hide();
	level.ee_trigs3 Hide();


	level.ee_models4 = GetEnt("ee_model4", "targetname");
	level.ee_trigs4 = GetEnt("ee_trig4", "targetname");
	level.ee_models4 Hide();
	level.ee_trigs4 Hide();


	level.ee_models5 = GetEnt("ee_model5", "targetname");
	level.ee_trigs5 = GetEnt("ee_trig5", "targetname");
	level.ee_models5 Hide();
	level.ee_trigs5 Hide();


	level.ee_models6 = GetEnt("ee_model6", "targetname");
	level.ee_trigs6 = GetEnt("ee_trig6", "targetname");
	level.ee_models6 Hide();
	level.ee_trigs6 Hide();


	level.ee_models7 = GetEnt("ee_model7", "targetname");
	level.ee_trigs7 = GetEnt("ee_trig7", "targetname");
	level.ee_models7 Hide();
	level.ee_trigs7 Hide();


	level.ee_models8 = GetEnt("ee_model8", "targetname");
	level.ee_trigs8 = GetEnt("ee_trig8", "targetname");
	level.ee_models8 Hide();
	level.ee_trigs8 Hide();


	level.ee_models9 = GetEnt("ee_model9", "targetname");
	level.ee_trigs9 = GetEnt("ee_trig9", "targetname");
	level.ee_models9 Hide();
	level.ee_trigs9 Hide();



	level.ee_models10 = GetEnt("ee_model10", "targetname");
	level.ee_trigs10 = GetEnt("ee_trig10", "targetname");
	level.ee_models10 Hide();
	level.ee_trigs10 Hide();

	
thread shoot1();

	
}

function shoot1()
{
	level.ee_trigs1 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("1/10");

	level.ee_models1 Delete();
	level.ee_trigs1 Delete();

	thread shoot2();
}

function shoot2()
{
	level.ee_models2 Show();
	level.ee_trigs2 Show();

	level.ee_trigs2 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("2/10");

	level.ee_models2 Delete();
	level.ee_trigs2 Delete();

	thread shoot3();

}

function shoot3()
{
	level.ee_models3 Show();
	level.ee_trigs3 Show();

	level.ee_trigs3 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("3/10");

	level.ee_models3 Delete();
	level.ee_trigs3 Delete();

	thread shoot4();

}

function shoot4()
{
	level.ee_models4 Show();
	level.ee_trigs4 Show();

	level.ee_trigs4 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("4/10");

	level.ee_models4 Delete();
	level.ee_trigs4 Delete();

	thread shoot5();

}

function shoot5()
{
	level.ee_models5 Show();
	level.ee_trigs5 Show();

	level.ee_trigs5 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("5/10");

	level.ee_models5 Delete();
	level.ee_trigs5 Delete();

	thread shoot6();

}

function shoot6()
{
	level.ee_models6 Show();
	level.ee_trigs6 Show();

	level.ee_trigs6 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("6/10");

	level.ee_models6 Delete();
	level.ee_trigs6 Delete();

	thread shoot7();

}

function shoot7()
{
	level.ee_models7 Show();
	level.ee_trigs7 Show();

	level.ee_trigs7 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("7/10");

	level.ee_models7 Delete();
	level.ee_trigs7 Delete();

	thread shoot8();

}

function shoot8()
{
	level.ee_models8 Show();
	level.ee_trigs8 Show();

	level.ee_trigs8 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("8/10");

	level.ee_models8 Delete();
	level.ee_trigs8 Delete();

	thread shoot9();

}

function shoot9()
{
	level.ee_models9 Show();
	level.ee_trigs9 Show();

	level.ee_trigs9 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("9/10");

	level.ee_models9 Delete();
	level.ee_trigs9 Delete();

	thread shoot10();

}

function shoot10()
{
	level.ee_models10 Show();
	level.ee_trigs10 Show();

	level.ee_trigs10 waittill("trigger", player);

	player PlaySound("eclat");

	level.ee_models10 Delete();
	level.ee_trigs10 Delete();

	
	thread shootable_door_ee_complete();

}

function shootable_door_ee_complete()
{
	
	objDoor = GetEnt("ee_door", "targetname");
	objDoor Delete();
	objClip = GetEnt("ee_clip", "targetname");
	objClip Delete();
	iPrintLnBold("All shootables found! The secret door is open!");
	
}


////////////////////////////////////////////////////////////////////////////////////
//Zombie TP
/////////////////////////////////////////////////////////////////////////////////////

function teleport_zombies_init()
{
    teleport_trig = GetEntArray( "teleport_zombies", "targetname" );
    for (i = 0; i < teleport_trig.size; i++)
    {
        teleport_trig[i] thread teleport_zombies();
    }
}

function teleport_zombies()
{
    teleport_destination = GetEnt( self.target, "targetname" );
    while(1)
    {
        zombs = getaispeciesarray("axis","all");
        for(k=0;k<zombs.size;k++)
        {
            if( zombs[k] IsTouching( self ) )
            {
                zombs[k] ForceTeleport( teleport_destination.origin );
            }
        }
        wait(0.01);
    }
}

////////////////////////////////////////////////////////////////
//EE Hold positions
///////////////////////////////////////////////////////////////



function Hold_position()

{
	level waittill("initial_blackscreen_passed");


//////////////

level.holdoor = GetEnt("holdoor", "targetname");
level.holdoor_clip = GetEnt("holdoor_clip", "targetname");

/////////////

	level.hold_model_1 = GetEnt("hold_model_1", "targetname");
	level.hold_model_1 Hide();

	level.hold_clip_1 = GetEntArray("hold_clip_1", "targetname");
	foreach(brushmodel in level.hold_clip_1)
	{
		brushmodel Hide();
	}

	level.holdon_model_1 = GetEnt("holdon_model_1", "targetname");
	level.holdon_model_1 Show();

	level.holdon_trig_1 = GetEnt("holdon_trig_1", "targetname");
	level.holdon_trig_1 SetHintString("Press ^3[{+activate}]^7 to activate the challenge");
	level.holdon_trig_1 SetCursorHint("HINT_INTERACT");
	level.holdon_trig_1 Show();

//////////////

	level.hold_model_2 = GetEnt("hold_model_2", "targetname");
	level.hold_model_2 Hide();

	level.hold_clip_2 = GetEntArray("hold_clip_2", "targetname");
	foreach(brushmodel in level.hold_clip_2)
	{
		brushmodel Hide();
	}

	level.holdon_model_2 = GetEnt("holdon_model_2", "targetname");
	level.holdon_model_2 Hide();

	level.holdon_trig_2 = GetEnt("holdon_trig_2", "targetname");
	level.holdon_trig_2 SetHintString("Press ^3[{+activate}]^7 to activate the challenge");
	level.holdon_trig_2 SetCursorHint("HINT_INTERACT");
	level.holdon_trig_2 Hide();

//////////////

	level.hold_model_3 = GetEnt("hold_model_3", "targetname");
	level.hold_model_3 Hide();

	level.hold_clip_3 = GetEntArray("hold_clip_3", "targetname");
	foreach(brushmodel in level.hold_clip_3)
	{
		brushmodel Hide();
	}

	level.holdon_model_3 = GetEnt("holdon_model_3", "targetname");
	level.holdon_model_3 Hide();

	level.holdon_trig_3 = GetEnt("holdon_trig_3", "targetname");
	level.holdon_trig_3 SetHintString("Press ^3[{+activate}]^7 to activate the challenge");
	level.holdon_trig_3 SetCursorHint("HINT_INTERACT");
	level.holdon_trig_3 Hide();

//////////////

	level.hold_model_4 = GetEnt("hold_model_4", "targetname");
	level.hold_model_4 Hide();

	level.hold_clip_4 = GetEntArray("hold_clip_4", "targetname");
	foreach(brushmodel in level.hold_clip_4)
	{
		brushmodel Hide();
	}

	level.holdon_model_4 = GetEnt("holdon_model_4", "targetname");
	level.holdon_model_4 Hide();

	level.holdon_trig_4 = GetEnt("holdon_trig_4", "targetname");
	level.holdon_trig_4 SetHintString("Press ^3[{+activate}]^7 to activate the challenge");
	level.holdon_trig_4 SetCursorHint("HINT_INTERACT");
	level.holdon_trig_4 Hide();


	thread Hold_position_1();


}

////////////////

function Hold_position_1()
{
	level.holdon_trig_1 waittill("trigger", player);
	

	IPrintLnBold("Hold the position 1/4 for 30s !");

	level.holdon_model_1 Hide();
	level.holdon_trig_1 Delete();

	level.hold_model_1 Show();
	foreach(brushmodel in level.hold_clip_1)
	{
		brushmodel Show();
	}
	


		wait(30);

		level.hold_model_1 Delete();
		foreach(brushmodel in level.hold_clip_1)
	{
		brushmodel Delete();
	}

		IPrintLnBold("nice, now, find the next position");

		wait(1);

		

	
	thread Hold_position_2();

}

function Hold_position_2()
{	
	

	level.holdon_model_2 Show();
	level.holdon_trig_2 Show();

	level.holdon_trig_2 waittill("trigger", player);

	IPrintLnBold("Hold the position 2/4 for 30s !");

	level.holdon_model_2 Delete();
	level.holdon_trig_2 Delete();

	level.hold_model_2 Show();
	foreach(brushmodel in level.hold_clip_2)
	{
		brushmodel Show();
	}

		wait(30);

		level.hold_model_2 Delete();
		foreach(brushmodel in level.hold_clip_2)
	{
		brushmodel Delete();
	}

		IPrintLnBold("nice, now, find the next position");

		wait(1);

		

	thread Hold_position_3();


}


function Hold_position_3()
{	
	

	level.holdon_model_3 Show();
	level.holdon_trig_3 Show();

	level.holdon_trig_3 waittill("trigger", player);

	IPrintLnBold("Hold the position 3/4 for 30s !");


	level.holdon_model_3 Delete();
	level.holdon_trig_3 Delete();


	level.hold_model_3 Show();
	foreach(brushmodel in level.hold_clip_3)
	{
		brushmodel Show();
	}

		wait(30);

		level.hold_model_3 Delete();
		foreach(brushmodel in level.hold_clip_3)
	{
		brushmodel Delete();
	}


	IPrintLnBold("nice, now, find the last position");

		

		wait(1);

		

	thread Hold_position_4();
}

function Hold_position_4()
{	

	

	level.holdon_model_4 Show();
	level.holdon_trig_4 Show();

	level.holdon_trig_4 waittill("trigger", player);

	IPrintLnBold("Hold the position 4/4 for 30s !");


	level.holdon_model_4 Delete();
	level.holdon_trig_4 Delete();


	level.hold_model_4 Show();
	foreach(brushmodel in level.hold_clip_4)
	{
		brushmodel Show();
	}

		wait(30);

		level.hold_model_4 Delete();
		foreach(brushmodel in level.hold_clip_4)
	{
		brushmodel Delete();
	}

		IPrintLnBold("good job ! go to the next area...");

		wait(1);

	thread Unlock_door();
}

function Unlock_door()
{
	
	level.holdoor Delete();
	level.holdoor_clip Delete();
	
}





////////////////////////////////////////////////////////////////////////////////
//MOON EASTER EGG
////////////////////////////////////////////////////////////////////////////////

function Moon_easter_egg()
{
	level waittill("initial_blackscreen_passed");
	/////////////////////////////////////
	//CANISTER PICKUP (start at function Pickup_cani() )






	////////////////////////////////////
	//PLACE CANISTER 


	level.place_canisters = GetEntArray("place_canister", "targetname");
	foreach(model in level.place_canisters)
	{
		model Hide();
	}



	level.place_cani_trig = GetEntArray("place_canister_trig", "targetname");
	foreach(trig in level.place_cani_trig)
	{
		trig SetHintString("missing canisters, you must find 4 canisters...");
		trig SetCursorHint("HINT_NOICON");

	}
	

	///////////////////////////////////
	//FUEL PICKUP



	level.fuel_model = GetEntArray("fuel_model", "targetname");
	foreach(model in level.fuel_model)
	{
		model Hide();
	}

	level.fuel_trig = GetEntArray("fuel_trig", "targetname");
	foreach(trig in level.fuel_trig)
	{
		trig Hide();
	}



	///////////////////////////////////
	//PLACE FUEL

	level.place_fuel_trig = GetEntArray("place_fuel_trig", "targetname");
	foreach(trig in level.place_fuel_trig)
	{
		trig Hide();
	}

	/////////////////////////////////
	//CANISTERS UP

	level.cani_up_trig = GetEnt("cani_up", "targetname");

	level.cani_up_trig SetHintString("Press ^3[{+activate}]^7 to activate canisters");
	level.cani_up_trig SetCursorHint("HINT_NOICON");
	level.cani_up_trig Hide();



	//////////////////////////////////
	//LIQUID 

	level.liquid_model = GetEntArray("liquid_model", "targetname");
	level.liquid_trig = GetEnt("liquid_trig", "targetname");
	level.liquid_trig Hide();


	/////////////////////////////////
	//SHOVEL

	level.clod0_trig = GetEnt("clod0_trig","targetname");
	level.clod0_trig Hide();

	level.shovel_trig = GetEnt("shovel_trig", "targetname");
	level.shovel_trig SetHintString("Press ^3[{+activate}]^7 to pickup the shovel");
	level.shovel_trig SetCursorHint("HINT_NOICON");

	level.shovel_trig Hide();

	////////////////////////////////
	//DIG UP

	level.clod1_trig = GetEnt("clod1_trig", "targetname");
	level.clod1_trig Hide();

	level.clod2_trig = GetEnt("clod2_trig", "targetname");
	level.clod2_trig Hide();

	level.clod3_trig = GetEnt("clod3_trig", "targetname");
	level.clod3_trig Hide();



	/////////////////////////////////
	//PICKUP RELIC

	level.relic_model = GetEnt("relic_model", "targetname");
	level.relic_model Hide();

	level.relic_trig = GetEnt("relic_trig", "targetname");
	level.relic_trig SetHintString("Press ^3[{+activate}]^7 to take the relic");
	level.relic_trig SetCursorHint("HINT_NOICON");
	level.relic_trig Hide();

	////////////////////////////////
	//PLACE RELIC

	level.place_relic = GetEnt("place_relic", "targetname");
	level.place_relic Hide();

	level.place_relic_trig = GetEnt("place_relic_trig", "targetname");
	
	level.place_relic_trig Hide();

	///////////////////////////////
	//ACTIVATE PYRAMID

	level.pyramid_trig = GetEnt("pyramid_trig", "targetname");
	level.pyramid_trig SetHintString("Press ^3[{+activate}]^7 to activate de pyramid");
	level.pyramid_trig SetCursorHint("HINT_NOICON");
	level.pyramid_trig Hide();

	
	thread Pickup_cani();
	thread Pickup_canister();

}
/////////////////////////////////////////////////////////////////////////////
//PICKUP CANISTER

function Pickup_cani()
{

	level.canister_collected = 0;

		while(isdefined(self))
        {
            //IF THE NUMBER OF CANISTER COLLECTED IS DIFFERENT OF 4
            if(level.canister_collected == 4)
            {	
            	
            	IPrintLnBold("you get all Canisters, place them near the pyramid");
                thread Place_cani();
       			thread Place_canisters();


                break;
            }
            else
            {
                //WAIT 1 SEC TO VERIFY AGAIN
                wait(1);
            }   
        }

        

}


function Pickup_canister()
{	
	level.cani_models = GetEntArray("canister_model", "targetname");
	cani_trig = GetEntArray("canister_trig", "targetname");

	foreach(trig in cani_trig)
	{
		trig SetHintString("Press ^3[{+activate}]^7 to pickup the canister");
		trig SetCursorHint("HINT_NOICON");

		thread canister(trig);

	}	
}

function canister(trig)
{
		trig.cani_model = ArrayGetClosest(trig.origin, level.cani_models);

		trig waittill("trigger", player);

		level.canister_collected += 1;

		IPrintLnBold("you get 1 canister");

		trig.cani_model Delete();

		trig Delete();
}
	

//////////////////////////////////////////////////////////////////////////////////
//PLACE CANISTER

function Place_cani()
{
	level.CanisterPlaced = 0;

    //THIS IS A INFINITE LOOP / THE LOOP STOP WHEN THE CONDITION CANISTERS COLLECTED ARE 3
    while(isdefined(self))
    {
        //IF THE NUMBER OF ARTEFACT COLLECTED IS EQUAL TO 3
        if(level.CanisterPlaced == 4)
        {
            
            IPrintLnBold("The pyramid need nitrogen (nitrogen tank 0/4)");

            foreach(trig in level.place_fuel_trig)
			{
				trig Show();
				trig SetHintString("missing 4 nitrogen tank...");
				trig SetCursorHint("HINT_NOICON");
			}


           	thread pickup_fuel();
           	thread pickup_fuel_tank();
            break;
        }
        else
        {
            //WAIT 1 SEC TO VERIFY AGAIN
            wait(1);
        }   
    }


	
}

function Place_canisters()
{
	foreach(trig in level.place_cani_trig)
	{
		
		trig SetHintString("Press ^3[{+activate}]^7 to place the canister");
		trig SetCursorHint("HINT_NOICON");

		thread place_canist(trig);
		
	}
		
	
}

function place_canist(trig)
{
	trig.place_cani = ArrayGetClosest(trig.origin, level.place_canisters);

	trig waittill("trigger", player);

	level.CanisterPlaced += 1;

	IPrintLnBold("canister placed");

	trig.place_cani Show();

	trig Delete();

}


///////////////////////////////////////////////////////////////////////////////
//PICKUP FUEL

function pickup_fuel()
{
	level.Fuel_pickedup = 0;

	

	while(isdefined(self))
    {
        //IF THE NUMBER OF ARTEFACT COLLECTED IS EQUAL TO 3
        if(level.Fuel_pickedup == 4)
        {
            
            IPrintLnBold("Good job, use the nitrogen near the canisters");
           	thread place_fuel();
           	thread Place_fuel_tank();
            break;
        }
        else
        {
            //WAIT 1 SEC TO VERIFY AGAIN
            wait(1);
        }   
    }
	
}

function pickup_fuel_tank()
{	
	foreach(model in level.fuel_model)
	{
		model Show();
	}

	foreach(trig in level.fuel_trig)
	{	
		trig Show();
		trig SetHintString("Press ^3[{+activate}]^7 to pickup the nitrogen tank");
		trig SetCursorHint("HINT_NOICON");

		thread fuel_tank(trig);

	}	
}

function fuel_tank(trig)
{
	trig.fuel_model = ArrayGetClosest(trig.origin, level.fuel_model);

		trig waittill("trigger", player);

		level.Fuel_pickedup += 1;

		IPrintLnBold("you get 1 nitrogen tank");

		trig.fuel_model Delete();

		trig Delete();
}


////////////////////////////////////////////////////////////////////////////////////////////
///PLACE FUEL

function place_fuel()
{
	level.fuelPlaced = 0;

    //THIS IS A INFINITE LOOP / THE LOOP STOP WHEN THE CONDITION CANISTERS COLLECTED ARE 3
    while(isdefined(self))
    {
        //IF THE NUMBER OF ARTEFACT COLLECTED IS EQUAL TO 3
        if(level.fuelPlaced == 4)
        {
            
            IPrintLnBold("Activate canisters from the pyramid");
           	thread cani_up_trig();
            break;
        }
        else
        {
            //WAIT 1 SEC TO VERIFY AGAIN
            wait(1);
        }   
    }


	
}

function Place_fuel_tank()
{
	foreach(trig in level.place_fuel_trig)
	{
		trig Show();
		trig SetHintString("Press ^3[{+activate}]^7 to use the nitrogen");
		trig SetCursorHint("HINT_NOICON");

		thread place_tank_fuel(trig);
		
	}
		
	
}

function place_tank_fuel(trig)
{

	trig waittill("trigger", player);

	level.fuelPlaced += 1;

	IPrintLnBold("nitrogen used");

	trig Delete();

}

function cani_up_trig()
{
	level.cani_up_trig Show();

	

	level.cani_up_trig waittill("trigger", player);

	wait (0.5);

	level.cani_up_trig Delete();

	thread cani_up();
}

function cani_up()
{
	foreach(model in level.place_canisters)
	{
		foreach(player in GetPlayers())
		{	
			player PlaySound("caniup");
			
		}
		model MoveZ(45,3);
	}

	thread liquid_wait();
}

/////////////////////////////////////////////////////////////////////////////////////////
///WAIT FOR LIQUID

function liquid_wait()
{	
	IPrintLnBold("fuel is loading, please wait...");
	level.liquid_trig Show();
	level.liquid_trig SetHintString("fuel is loading, please wait...");
	level.liquid_trig SetCursorHint("HINT_NOICON");

	foreach(model in level.liquid_model)
	{
		
		wait (5);

		model MoveZ(69,3);
	}

	level.liquid_trig Delete();

	wait (3);

	

	IPrintLnBold("One last thing, grab a shovel and dig up the relic");

	thread grab_shovel();
}

/////////////////////////////////////////////////////////////////////////////////////////
///GRAB SHOVEL

function grab_shovel()
{	

	level.place_relic_trig Show();
	level.place_relic_trig SetHintString("You must find a shovel to dig up the relic...");
	level.place_relic_trig SetCursorHint("HINT_NOICON");

	model = GetEnt("model_shovel", "targetname");

	level.shovel_trig Show();

	exploder::exploder("shovel");

	level.shovel_trig waittill("trigger", player);

	exploder::kill_exploder("shovel");

	

	model Delete();

	level.shovel_trig Delete();

	level.clod0_trig Show();

	thread digup_clod0();
	thread digup_clod1();
	thread digup_clod2();
	thread digup_clod3();


}


function digup_clod0()
{
	model = GetEnt("clod0", "targetname");
	level.clod0_trig Show();
	level.clod0_trig SetHintString("Press ^3[{+activate}]^7 to dig up the clod");

	wait(0.1);

	IPrintLnBold("Nothing here...");
	model Delete();
	level.clod0_trig Delete();

	level.clod1_trig Show();
	level.clod2_trig Show();
	level.clod3_trig Show();

}

///////////////////////////////////////////////////////////////////////////////////////////////
//DIG UP RELIC

function digup_clod1()
{
	model = GetEnt("clod1", "targetname");
	level.clod1_trig SetHintString("Press ^3[{+activate}]^7 to dig up the clod");

	level.clod1_trig waittill("trigger", player);

	IPrintLnBold("Nothing here...");
	model Delete();
	level.clod1_trig Delete();

}

function digup_clod2()
{
	model = GetEnt("clod2", "targetname");
	level.clod2_trig SetHintString("Press ^3[{+activate}]^7 to dig up the clod");

	level.clod2_trig waittill("trigger", player);


	IPrintLnBold("Nothing here...");
	model Delete();
	level.clod2_trig Delete();

}

function digup_clod3()
{
	model = GetEnt("clod3", "targetname");
	level.clod3_trig SetHintString("Press ^3[{+activate}]^7 to dig up the clod");

	level.clod3_trig waittill("trigger", player);


	IPrintLnBold("good job ! take the relic !");
	model Delete();
	level.clod3_trig Delete();

	thread pickup_relic();

}

///////////////////////////////////////////////////////////////////////////////////////
//PICKUP RELIC


function pickup_relic()
{
	level.relic_model Show();
	level.relic_trig Show();

	level.relic_trig waittill("trigger", player);

	IPrintLnBold("come back to the pyramid...");

	level.relic_model Delete();
	level.relic_trig Delete();

	

	thread place_relic();

}

///////////////////////////////////////////////////////////////////////////////////////
//PLACE THE RELIC

function place_relic()
{
	level.place_relic_trig SetHintString("Press ^3[{+activate}]^7 to place the last part of the pyramid");
	level.place_relic_trig SetCursorHint("HINT_NOICON");
	

	level.place_relic_trig waittill("trigger", player);

	

	level.place_relic_trig Delete();

	level.place_relic Show();

	IPrintLnBold("Perfect ! Use the pyramid !");

	thread use_pyramid();


}

///////////////////////////////////////////////////////////////////////////////////////
//USE PYRAMID

function use_pyramid()
{
	level.pyramid_trig Show();

	level.pyramid_trig waittill("trigger", player);

	level notify("end_moon");

	

	foreach(player in GetPlayers())
		{	
			player PlaySound("pyramid");
			
		}

	exploder::exploder("pyramid_shock");

	IPrintLnBold("A signal was emitted by the pyramid ");

	level.pyramid_trig Delete();

	exploder::kill_exploder("pyramid_shock");


	thread open_portal();


}


//////////////////////////////////////////////////////////////////////////////////////
//OPEN PORTAL

function open_portal()
{	
	
	model = GetEnt("tp_model", "targetname");
	clip = GetEnt("tp_clip", "targetname");

	model Delete();
	clip Delete();

	wait(1);

	exploder::exploder("black_hole_fx");

	wait(3);

	IPrintLnBold("You must find 5 seeds to continue...(Moon)");

	wait(5);

	IPrintLnBold(" Less hints from now... ");

	wait(3);

	IPrintLnBold(" But you can check the goals from the HUB ! ");
}

///////////////////////////////////////////////////////
//END MOON EE


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//KEYS EE
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function keys_ee()
{

	level waittill("initial_blackscreen_passed");

	/////////////////////////////////////////////////////////
	///KEY 1
	

	level.key1 = GetEnt("key1", "targetname");
	level.key1 Hide();

	level.place_key1 = GetEnt("place_key1", "targetname");
	level.place_key1 SetHintString("missing key 1 to open the door...");
	level.place_key1 SetCursorHint("HINT_NOICON");

	level.model_key1 = GetEnt("model_key1", "targetname");

	level.trig_key1 = GetEnt("trig_key1", "targetname");
	level.trig_key1 SetHintString("Press ^3[{+activate}]^7 to pickup the key 1");
	level.trig_key1 SetCursorHint("HINT_NOICON");

	level.door_key1 = GetEnt("door_key1", "targetname");
	level.clip_key1 =GetEnt("clip_key1", "targetname");

	exploder::exploder("glow_key1");



	/////////////////////////////////////////////////////////
	///KEY 2
	

	level.key2 = GetEnt("key2", "targetname");
	level.key2 Hide();

	level.place_key2 = GetEnt("place_key2", "targetname");
	level.place_key2 SetHintString("missing key 2 to open the door...");
	level.place_key2 SetCursorHint("HINT_NOICON");

	level.model_key2 = GetEnt("model_key2", "targetname");

	level.trig_key2 = GetEnt("trig_key2", "targetname");
	level.trig_key2 SetHintString("Press ^3[{+activate}]^7 to pickup the key 2");
	level.trig_key2 SetCursorHint("HINT_NOICON");

	level.door_key2 = GetEnt("door_key2", "targetname");
	level.clip_key2 =GetEnt("clip_key2", "targetname");

	exploder::exploder("glow_key2");


	/////////////////////////////////////////////////////////
	///KEY 3
	

	level.key3 = GetEnt("key3", "targetname");
	level.key3 Hide();

	level.place_key3 = GetEnt("place_key3", "targetname");
	level.place_key3 SetHintString("missing key 3 to open the door...");
	level.place_key3 SetCursorHint("HINT_NOICON");

	level.model_key3 = GetEnt("model_key3", "targetname");

	level.trig_key3 = GetEnt("trig_key3", "targetname");
	level.trig_key3 SetHintString("Press ^3[{+activate}]^7 to pickup the key 3");
	level.trig_key3 SetCursorHint("HINT_NOICON");

	level.door_key3 = GetEnt("door_key3", "targetname");
	level.clip_key3 =GetEnt("clip_key3", "targetname");

	exploder::exploder("glow_key3");


	/////////////////////////////////////////////////////////
	///KEY 4
	

	level.key4 = GetEnt("key4", "targetname");
	level.key4 Hide();

	level.place_key4 = GetEnt("place_key4", "targetname");
	level.place_key4 SetHintString("missing key 4 to open the door...");
	level.place_key4 SetCursorHint("HINT_NOICON");

	level.model_key4 = GetEnt("model_key4", "targetname");

	level.trig_key4 = GetEnt("trig_key4", "targetname");
	level.trig_key4 SetHintString("Press ^3[{+activate}]^7 to pickup the key 4");
	level.trig_key4 SetCursorHint("HINT_NOICON");

	level.door_key4 = GetEnt("door_key4", "targetname");
	level.clip_key4 =GetEnt("clip_key4", "targetname");

	exploder::exploder("glow_key4");



	/////////////////////////////////////////////////////////
	///KEY 5
	

	level.key5 = GetEnt("key5", "targetname");
	level.key5 Hide();

	level.place_key5 = GetEnt("place_key5", "targetname");
	level.place_key5 SetHintString("missing key 5 to open the door...");
	level.place_key5 SetCursorHint("HINT_NOICON");

	level.model_key5 = GetEnt("model_key5", "targetname");

	level.trig_key5 = GetEnt("trig_key5", "targetname");
	level.trig_key5 SetHintString("Press ^3[{+activate}]^7 to pickup the key 5");
	level.trig_key5 SetCursorHint("HINT_NOICON");

	level.door_key5 = GetEnt("door_key5", "targetname");
	level.clip_key5 =GetEnt("clip_key5", "targetname");

	exploder::exploder("glow_key5");


//////////////////////////////////////////
//THREAD

thread pickup_key1();
thread pickup_key2();
thread pickup_key3();
thread pickup_key4();
thread pickup_key5();

}

//////////////////////////////////////////
//PICKUP KEYS


function pickup_key1()
{
	level.trig_key1 waittill("trigger", player);

	level.model_key1 Delete();
	level.trig_key1 Delete();

	exploder::kill_exploder("glow_key1");

	thread place_key_1();
	thread current_step0();
}

function pickup_key2()
{
	level.trig_key2 waittill("trigger", player);

	

	level.model_key2 Delete();
	level.trig_key2 Delete();

	exploder::kill_exploder("glow_key2");

	thread place_key_2();
}

function pickup_key3()
{
	level.trig_key3 waittill("trigger", player);

	

	level.model_key3 Delete();
	level.trig_key3 Delete();

	exploder::kill_exploder("glow_key3");

	thread place_key_3();
}

function pickup_key4()
{
	level.trig_key4 waittill("trigger", player);

	

	level.model_key4 Delete();
	level.trig_key4 Delete();

	exploder::kill_exploder("glow_key4");

	thread place_key_4();
}

function pickup_key5()
{
	level.trig_key5 waittill("trigger", player);

	
	

	level.model_key5 Delete();
	level.trig_key5 Delete();

	exploder::kill_exploder("glow_key5");

	thread place_key_5();
}

////////////////////////////////////
//PLACE KEYS

function place_key_1()
{
	level.place_key1 SetHintString("Press ^3[{+activate}]^7 to place the key 1");
	level.place_key1 SetCursorHint("HINT_NOICON");

	level.place_key1 waittill("trigger", player);

	//thread current_step0();

	level.key1 Show();

	level.place_key1 Delete();

	level.door_key1 Delete();
	level.clip_key1 Delete();

}


function place_key_2()
{
	level.place_key2 SetHintString("Press ^3[{+activate}]^7 to place the key 2");
	level.place_key2 SetCursorHint("HINT_NOICON");

	level.place_key2 waittill("trigger", player);

	level notify("end_step_0");

	level.key2 Show();

	level.place_key2 Delete();

	level.door_key2 Delete();
	level.clip_key2 Delete();

	

}

function place_key_3()
{
	level.place_key3 SetHintString("Press ^3[{+activate}]^7 to place the key 3");
	level.place_key3 SetCursorHint("HINT_NOICON");

	level.place_key3 waittill("trigger", player);

	level notify("end_step_1");

	level.key3 Show();

	level.place_key3 Delete();

	level.door_key3 Delete();
	level.clip_key3 Delete();

	

}

function place_key_4()
{
	level.place_key4 SetHintString("Press ^3[{+activate}]^7 to place the key 4");
	level.place_key4 SetCursorHint("HINT_NOICON");

	level.place_key4 waittill("trigger", player);

	level notify("end_step_2");

	level.key4 Show();

	level.place_key4 Delete();

	level.door_key4 Delete();
	level.clip_key4 Delete();

	

}

function place_key_5()
{
	level.place_key5 SetHintString("Press ^3[{+activate}]^7 to place the key 5");
	level.place_key5 SetCursorHint("HINT_NOICON");

	level.place_key5 waittill("trigger", player);

	level notify("end_step_3");

	level.key5 Show();

	level.place_key5 Delete();

	level.door_key5 Delete();
	level.clip_key5 Delete();

	

}

////////////////////////////////////////////////////////
//ENDING KEYS EE



/////////////////////////////////////////////////////////////////////////////////////////
//PLAYER TELEPORTER 

function player_teleporter_init()
{

	player_tp = GetEntArray("teleport_player", "targetname");

	for( i = 0; i < player_tp.size; i++)
	{
		player_tp[i] thread player_teleport();

	}
}

function player_teleport()
{
	destination = GetEnt(self.target, "targetname");
	while(1)
	{
		self waittill("trigger", player);
		player SetOrigin(destination.origin);
		player SetPlayerAngles(destination.angles);

	}

}





/////////////////////////////////////////////////////////////////////////////////////////
//////COFEE EE

function cofee()
{
	level waittill("initial_blackscreen_passed");

	//TAKE MUG

	level.mug1 = GetEnt("mug1", "targetname");

	level.take_mug1 = GetEnt("take_mug1", "targetname");
	level.take_mug1 SetHintString("Press ^3[{+activate}]^7 to take a mug");
	level.take_mug1 SetCursorHint("HINT_NOICON");

	//PLACE MUG

	level.mug2 = GetEnt("mug2", "targetname");
	level.mug2 Hide();

	level.place_mug2 = GetEnt("place_mug2", "targetname");
	level.place_mug2 SetHintString("Press ^3[{+activate}]^7 to place the mug");
	level.place_mug2 SetCursorHint("HINT_NOICON");
	level.place_mug2 Hide();

	//TAKE COFFEE BEANS

	level.coffee_beans = GetEnt("coffee_beans", "targetname");

	level.take_beans = GetEnt("take_beans", "targetname");
	level.take_beans SetHintString("Press ^3[{+activate}]^7 to take the coffee beans");
	level.take_beans SetCursorHint("HINT_NOICON");
	level.take_beans Hide();


	//PLACE BEANS
	level.place_beans = GetEnt("place_beans", "targetname");
	level.place_beans SetHintString("missing coffee beans");
	level.place_beans SetCursorHint("HINT_NOICON");
	level.place_beans Hide();

	//TAKE COFFEE

	level.take_coffee = GetEnt("take_coffee", "targetname");
	level.take_coffee SetHintString("Press ^3[{+activate}]^7 to take your hot coffee");
	level.take_coffee SetCursorHint("HINT_NOICON");
	level.take_coffee Hide();

	///////////////////////////////////////////////////////
	//COFFEE 2 
		//TAKE MUG3

	level.mug3 = GetEnt("mug3", "targetname");

	level.take_mug3 = GetEnt("take_mug3", "targetname");
	level.take_mug3 SetHintString("Press ^3[{+activate}]^7 to take a mug");
	level.take_mug3 SetCursorHint("HINT_NOICON");
	level.take_mug3 Hide();

	//PLACE MUG3

	level.mug4 = GetEnt("mug4", "targetname");
	level.mug4 Hide();

	level.place_mug4 = GetEnt("place_mug4", "targetname");
	level.place_mug4 SetHintString("Press ^3[{+activate}]^7 to place the mug");
	level.place_mug4 SetCursorHint("HINT_NOICON");
	level.place_mug4 Hide();

	//TAKE COFFEE BEANS2

	level.coffee_beans2 = GetEnt("coffee_beans2", "targetname");

	level.take_beans2 = GetEnt("take_beans2", "targetname");
	level.take_beans2 SetHintString("Press ^3[{+activate}]^7 to take the coffee beans");
	level.take_beans2 SetCursorHint("HINT_NOICON");
	level.take_beans2 Hide();


	//PLACE BEANS2
	level.place_beans2 = GetEnt("place_beans2", "targetname");
	level.place_beans2 SetHintString("missing coffee beans");
	level.place_beans2 SetCursorHint("HINT_NOICON");
	level.place_beans2 Hide();

	//TAKE COFFEE2

	level.take_coffee2 = GetEnt("take_coffee2", "targetname");
	level.take_coffee2 SetHintString("Press ^3[{+activate}]^7 to take your hot coffee");
	level.take_coffee2 SetCursorHint("HINT_NOICON");
	level.take_coffee2 Hide();


	//SOUND

	

	//////////////////////////////////////////////////////////

	thread take_mug1();

}

function take_mug1()
{
	level.take_mug1 waittill("trigger", player);

	level.mug1 Delete();
	level.take_mug1 Delete();

	thread place_mug2();
}

function place_mug2()
{
	level.place_mug2 Show();
	
	level.place_mug2 waittill("trigger", player);

	level.place_mug2 Delete();	

	level.mug2 Show();
	level.place_beans Show();

	thread take_beans();


}

function take_beans()
{
	level.take_beans Show();

	level.take_beans waittill("trigger", player);

	level.coffee_beans Delete();
	level.take_beans Delete();

	thread place_beans();

}

function place_beans()
{
	level.place_beans SetHintString("Press ^3[{+activate}]^7 to place the coffee beans");
	level.place_beans SetCursorHint("HINT_NOICON");

	level.place_beans waittill("trigger", player);

	level.place_beans Delete();

	PlaySoundAtPosition( "coffee", player.origin );

	wait(10);

	thread take_coffee();
}

function take_coffee()
{

	level.take_coffee Show();

	level.take_coffee waittill("trigger", player);

	IPrintLnBold("you feel energized");

	player PlaySound("drink_coffee");

	level.mug2 Delete();
	level.take_coffee Delete();

	foreach(player in GetPlayers())
		{
			player zm_perks::give_perk("specialty_staminup");
		}
		wait(0.5);

	

	thread coffee2();

}

//////////////////////////////////////
///too much coffee

function coffee2()
{
	

	//TAKE MUG3

	level.mug3 Show();

	level.take_mug3 = GetEnt("take_mug3", "targetname");
	level.take_mug3 SetHintString("Press ^3[{+activate}]^7 to take a mug");
	level.take_mug3 SetCursorHint("HINT_NOICON");
	level.take_mug3 Show();

	thread take_mug3();

}

function take_mug3()
{
	level.take_mug3 waittill("trigger", player);

	level.mug3 Hide();
	level.take_mug3 Hide();

	thread place_mug4();
}

function place_mug4()
{
	level.place_mug4 Show();
	
	level.place_mug4 waittill("trigger", player);

	level.place_mug4 Hide();	

	level.mug4 Show();

	level.place_beans2 SetHintString("missing coffee beans");
	level.place_beans2 SetCursorHint("HINT_NOICON");
	level.place_beans2 Show();

	thread take_beans2();


}

function take_beans2()
{
	level.take_beans2 Show();

	level.take_beans2 waittill("trigger", player);

	
	level.take_beans2 Hide();

	thread place_beans2();

}

function place_beans2()
{	
	
	level.place_beans2 SetHintString("Press ^3[{+activate}]^7 to place the coffee beans");
	level.place_beans2 SetCursorHint("HINT_NOICON");

	level.place_beans2 waittill("trigger", player);

	level.place_beans2 Hide();

	player PlaySound("coffee");

	wait(10);

	thread take_coffee2();
}

function take_coffee2()
{

	level.take_coffee2 Show();

	level.take_coffee2 waittill("trigger", player);

	player PlaySound("drink_coffee");

	level.mug4 Hide();
	level.take_coffee2 Hide();

	IPrintLnBold("too much coffee !");

			wait(0.5);

	IPrintLnBold("you feel excited");
	thread coffee2();

}


/////////////////////////////////////////////////////////////////////////////////////////
///SHOOT STAND EE


function shoot_challenge()
{	
	//1st

	level.medal_challenge = GetEnt("medal_challenge", "targetname");

	level.medal_challenge SetHintString("Press ^3[{+activate}]^7 to launch the 1st challenge (10s)");
	level.medal_challenge SetCursorHint("HINT_NOICON");

	level.medal_challenge Show();

	//1st

	level.shoot_models = GetEntArray("shoot_model", "targetname");
	foreach(model in level.shoot_models)
	{
		model Hide();
	}

	
	
	
	//1st

	level.medal_trig = GetEntArray("medal_trig", "targetname");
	foreach(trig in level.medal_trig)
	{
		trig Hide();

	}

	

	//2nd

	level.medal_challenge2 = GetEnt("medal_challenge2", "targetname");

	level.medal_challenge2 SetHintString("you must do the 1st challenge");
	level.medal_challenge2 SetCursorHint("HINT_NOICON");

	//2nd
		level.shoot_models2 = GetEntArray("shoot_model2", "targetname");
	foreach(model in level.shoot_models2)
	{
		model Hide();
	}
	
	//2nd

	level.medal_trig2 = GetEntArray("medal_trig2", "targetname");
	foreach(trig in level.medal_trig2)
	{
		trig Hide();

	}

	////3rd

	//2nd

	level.medal_challenge3 = GetEnt("medal_challenge3", "targetname");

	level.medal_challenge3 SetHintString("you must do the 1st challenge");
	level.medal_challenge3 SetCursorHint("HINT_NOICON");

	//2nd
		level.shoot_models3 = GetEntArray("shoot_model3", "targetname");
	foreach(model in level.shoot_models3)
	{
		model Hide();
	}
	
	//2nd

	level.medal_trig3 = GetEntArray("medal_trig3", "targetname");
	foreach(trig in level.medal_trig3)
	{
		trig Hide();

	}

	

	//1st

	level.medal_challenge waittill("trigger", player);

	thread launch_challenge();

}

function launch_challenge()
{	

	level.medal_shooted = 0;

	level.medal_challenge Hide();

	foreach(model in level.shoot_models)
	{
		model Show();
	}
	
	foreach(trig in level.medal_trig)
	{
		trig Show();
		thread medal_trig(trig);

	}
        wait(10);
           
            if(level.medal_shooted == 10)
            {	

            	thread end_challenge();
                
            }
            else
            {
                

                IPrintLnBold("challenge failed, try again (5sec)");
                self endon("stop_chall_1");
                thread restart_chall_1();
                
                
            }   
        


}
	


function medal_trig(trig)
{
	trig.shoot_model = ArrayGetClosest(trig.origin, level.shoot_models);

	trig waittill("trigger", player);

	level.medal_shooted += 1;

	self Hide();

	trig.shoot_model Hide();

}

function end_challenge()
{
	level.medal_challenge Delete();

	

	foreach(model in level.shoot_models)
        {
            model Delete();
        }

    foreach(trig in level.medal_trig)
        {
            trig Delete();
        }

    foreach(player in GetPlayers())
		{	
			player PlaySound("win_chall");
			player zm_perks::give_perk("specialty_deadshot");
		}

		thread shoot_challenge2();
		thread shoot_challenge3();

            	IPrintLnBold("nice shot ! Your aim is more accurate");
}

function restart_chall_1()
{
	level notify("stop_chall_1");
	wait(5);
    thread shoot_challenge();
}

//////////////////////////////////////////////////////////////////////////

function shoot_challenge2()
{	

	level.medal_challenge2 = GetEnt("medal_challenge2", "targetname");

	level.medal_challenge2 SetHintString("Press ^3[{+activate}]^7 to launch the 2nd challenge (10s)");
	level.medal_challenge2 SetCursorHint("HINT_NOICON");

	level.medal_challenge2 Show();

	foreach(model in level.shoot_models2)
	{
		model Hide();
	}
	
	foreach(trig in level.medal_trig2)
	{
		trig Hide();

	}

	thread launch_challenge2();

}


function launch_challenge2()
{	
	level.medal_challenge2 Show();

	level.medal_shooted2 = 0;

	level.medal_challenge2 waittill("trigger", player);

	level.medal_challenge2 Hide();

	foreach(model in level.shoot_models2)
	{
		model Show();
	}
	
	foreach(trig in level.medal_trig2)
	{
		trig Show();
		thread medal_trig2(trig);

	}
        wait(10);
           
            if(level.medal_shooted2 == 10)
            {	
            	
            	thread end_challenge2();
                
            }
            else
            {
            	IPrintLnBold("challenge failed, try again (5sec)");
            	self endon("stop_chall_2");
            	thread restart_chall_2();
            }


}
	

function medal_trig2(trig)
{
	trig.shoot_model2 = ArrayGetClosest(trig.origin, level.shoot_models2);

	trig waittill("trigger", player);

	level.medal_shooted2 += 1;

	self Hide();

	trig.shoot_model2 Hide();

}


function end_challenge2()
{
	

    foreach(player in GetPlayers())
		{
			player PlaySound("win_chall");
			player.score += 10;
		}

            	IPrintLnBold("nice shot ! you've won 10 points");

            	wait(5);

            	thread shoot_challenge2();
}
function restart_chall_2()
{	
	level notify("stop_chall_2");
	wait(5);
    thread shoot_challenge2();
}

///////////////////////////////////////////////////////////////////////

function shoot_challenge3()
{	

	level.medal_challenge3 = GetEnt("medal_challenge3", "targetname");

	level.medal_challenge3 SetHintString("Press ^3[{+activate}]^7 to launch the 3rd challenge (20s)");
	level.medal_challenge3 SetCursorHint("HINT_NOICON");

	level.medal_challenge3 Show();

	foreach(model in level.shoot_models3)
	{
		model Hide();
	}
	
	foreach(trig in level.medal_trig3)
	{
		trig Hide();

	}

	thread launch_challenge3();

}


function launch_challenge3()
{	

	level.medal_shooted3 = 0;

	level.medal_challenge3 waittill("trigger", player);

	level.medal_challenge3 Hide();

	foreach(model in level.shoot_models3)
	{
		model Show();
	}
	
	foreach(trig in level.medal_trig3)
	{
		trig Show();
		thread medal_trig3(trig);

	}
        wait(20);
           
            if(level.medal_shooted3 == 10)
            {	
            	
            	thread end_challenge3();
                
            }
            else
            {
            	IPrintLnBold("challenge failed, try again (5sec)");
            	self endon("stop_chall_3");
            	thread restart_chall_3();
            }


}
	

function medal_trig3(trig)
{
	trig.shoot_model3 = ArrayGetClosest(trig.origin, level.shoot_models3);

	trig waittill("trigger", player);

	level.medal_shooted3 += 1;

	self Hide();

	trig.shoot_model3 Hide();

}


function end_challenge3()
{

	

    foreach(player in GetPlayers())
		{	
			player PlaySound("win_chall");
			player.score += 25;
		}

            	IPrintLnBold("we have a champion here ! you've won 25 points");

            	thread shoot_challenge3();
}

function restart_chall_3()
{	
	level notify("stop_chall_3");
	wait(5);
    thread shoot_challenge3();
}


/////////////////////////////////////////////////////////////////////////////////////////////
////////////EE PLANTS
////////////////////////////////////////////////////////////////////////////////////////////

function plants()
{	

	level waittill("initial_blackscreen_passed");
	///////////////////////////////////////////MODELS

	///SEED MODELS

	level.seeds = GetEntArray("seed", "targetname");
	foreach(model in level.seeds)
	{
		model Hide();
	}

	level.seed_trigs = GetEntArray("seed_trig", "targetname");
	foreach(trig in level.seed_trigs)
	{
		trig Hide();
	}


	//// trig plant to see missing seeds


	///PLANT SEED

	//(little bonsai models)
	level.plants = GetEntArray("plant", "targetname");
	foreach (model in level.plants)
	{
		model Hide();
	}

	//(trig to plant)

	level.plant_trigs = GetEntArray("plant_trig", "targetname");
		foreach(trig in level.plant_trigs)
	{
		trig SetHintString("missing seeds...");
		trig SetCursorHint("HINT_NOICON");
		
	}


	
	///PICKUP WATERING CAN 

	level.water = GetEnt("watercan", "targetname");

	level.water_trig = GetEnt("watercan_trig", "targetname");
	level.water_trig SetHintString("Press ^3[{+activate}]^7 to pickup the watering can");
	level.water_trig SetCursorHint("HINT_NOICON");
	level.water_trig Hide();
	////watering

	level.watering = GetEntArray("watering","targetname");

	foreach(trig in level.watering)
	{
		trig Hide();
	}
	
	///BONSAI
	level.bonsais = GetEntArray("bonsai", "targetname");
	foreach(model in level.bonsais)
	{
		model Hide();
	}

	////COLLECT SAP

	//(activate the systeme to collect the sap)
	level.activate_sap = GetEnt("activate_sap", "targetname");
	level.activate_sap SetHintString("Press ^3[{+activate}]^7 to activate the collect");
	level.activate_sap SetCursorHint("HINT_NOICON");
	level.activate_sap Hide();

	//model sap before mixture
	level.sap0 = GetEnt("sap0", "targetname");
	level.sap0 Hide();

	///trig to use fire to prepare mixture
	level.use_fire = GetEnt("use_fire", "targetname");
	level.use_fire Hide();

	//model sap in the balloon after the mixture
	level.sap = GetEnt("sap", "targetname");
	level.sap Hide();

	///model of the balloon and the mixture
	level.balloon = GetEnt("balloon", "targetname");

	///activate sap

	level.activate_sap = GetEnt("activate_sap", "targetname");
	level.activate_sap Hide();
	
	//collect sap trig
	level.collect_sap = GetEnt("collect_sap", "targetname");
	level.collect_sap Hide();

	//kill the plant

	//weird plant model
	level.kill_plant = GetEntArray("kill_plant", "targetname");

	//weird plant clip
	level.kill_plant_clip = GetEnt("kill_clip", "targetname");

	//weird plant trig
	level.kill_plant_trig = GetEnt("kill_trig", "targetname");
	level.kill_plant_trig SetHintString("this weird plant is blocking the path... ");
	level.kill_plant_trig SetCursorHint("HINT_NOICON");

	/// egg touch model
	level.egg_model = GetEnt("egg_model", "targetname");
	level.egg_model Hide();

	level.egg_trig = GetEnt("egg_trig", "targetname");
	level.egg_trig SetHintString("Press ^3[{+activate}]^7 to touch the big seed");
	level.egg_trig SetCursorHint("HINT_NOICON");
	level.egg_trig Hide();


	////SHIP
	level.ship =GetEnt("ship_model", "targetname");
	level.ship Hide();

	level waittill("end_moon");
	thread seed();
	thread pickup_seed();


}

///////////////////////////////
//PICK UP SEED

function seed()
{	
	

	foreach(model in level.seeds)
	{
		model Show();
	}

	foreach(trig in level.seed_trigs)
	{
		trig Show();
	}



	level.seed_pickedup = 0;

	

	while(isdefined(self))
    {
        //IF THE NUMBER OF ARTEFACT COLLECTED IS EQUAL TO 3
        if(level.seed_pickedup == 5)
        {	

        	exploder::kill_exploder("5_seeds");
            
            IPrintLnBold("you have found all seed, go to the HUB...");
           	thread place_seed();
           	thread plant();
           	
            break;
        }
        else
        {
            //WAIT 1 SEC TO VERIFY AGAIN
            wait(1);
        }   
    }
}

function Pickup_seed()
{	
	level.seeds = GetEntArray("seed", "targetname");

	exploder::exploder("5_seeds");
	


	foreach(trig in level.seed_trigs)
	{
		trig SetHintString("Press ^3[{+activate}]^7 to pickup the seed");
		trig SetCursorHint("HINT_NOICON");

		thread trig_seed(trig);

	}	
}

function trig_seed(trig)
{
		trig.seed_model = ArrayGetClosest(trig.origin, level.seeds);

		trig waittill("trigger", player);

		level.seed_pickedup += 1;

		IPrintLnBold("you get 1 seed");

		trig.seed_model Delete();

		trig Delete();
}

///////////////////////////////////
//PLANT SEEDS


function plant()
{	
	level.seed_placed = 0;

	while(isdefined(self))
	{
		if(level.seed_placed == 5)
        {	
        	
            foreach(trig in level.watering)
            {	
            	trig Show();
            	trig SetHintString("find a watering can on the moon...");
				trig SetCursorHint("HINT_NOICON");
            }

            IPrintLnBold("great ! you will find a watering can on the moon (0/1)");

           
            wait(1);
            level notify("end_step_4");
           	thread pickup_watering_can();
           	
            break;
        }
        else
        {
            //WAIT 1 SEC TO VERIFY AGAIN
            wait(1);
        } 
	}
	  
    
}

function place_seed()
{

		foreach(trig in level.plant_trigs)
	{
		trig SetHintString("Press ^3[{+activate}]^7 to plant the seed");
		trig SetCursorHint("HINT_NOICON");

		thread plant_seed(trig);

	}	

}

function plant_seed(trig)
{
		trig.young_model = ArrayGetClosest(trig.origin, level.plants);

		trig waittill("trigger", player);

		player PlaySound("seed");

		trig.young_model Show();

		level.seed_placed += 1;

		IPrintLnBold("you plant 1 seed");

		trig Delete();
}


////////////////////////////////////////
// PICK UP WATERING CAN



function pickup_watering_can()
{	
	 

	model = GetEnt("watercan", "targetname");

	level.water_trig Show();

	level.water_trig waittill("trigger", player);

	

	IPrintLnBold("come back to watering the young plants");

	model Delete();

	level.water_trig Delete();

	wait(1);
	thread watering_plant();
	thread watering();
}



///////////////////////////////////////
///WATERING PLANT

function watering_plant()
{
	level.plant_watered = 0;

	while(isdefined(self))
	{
		if(level.plant_watered == 5)
        {
            
            IPrintLnBold("good job ! Now, you need to collect their sap (control panel)");
           	thread activate_collect();
           	
            break;
        }
        else
        {
            //WAIT 1 SEC TO VERIFY AGAIN
            wait(1);
        }  
	} 
    
}

function watering()
{
	foreach(trig in level.watering)
	{	
		
		trig SetHintString("Press ^3[{+activate}]^7 to watering the plant");
		trig SetCursorHint("HINT_NOICON");

		thread watering_trig(trig);
	}


		
}

function watering_trig(trig)
{
	trig.big_plant = ArrayGetClosest(trig.origin, level.bonsais);

	trig waittill("trigger", player);

	player PlaySound("Watering");

	level.plant_watered += 1;

	trig.big_plant Show();

	IPrintLnBold("this plant aprecciates your attention...");

	trig Delete();

}

/////////////////////////////////////////////
/////COLLECT SAP

function activate_collect()
{
	
	level.activate_sap Show();

	level.activate_sap waittill("trigger", player);

	

	player PlaySound("activate_sap");

	IPrintLnBold(" perfect ! Use the chemistry kit to create a mixture...");

	level.sap0 Show();

	level.sap Show();

	level.activate_sap Delete();

	thread use_fire();


}

function use_fire()
{
	level.use_fire Show();
	level.use_fire SetHintString("Press ^3[{+activate}]^7 to use the torch");
	level.use_fire SetCursorHint("HINT_NOICON");

	level.use_fire waittill("trigger", player);

	exploder::exploder("flame");

	level.use_fire Delete();

	player PlaySound("torch");

	wait(5);

	player PlaySound("bulles");

	wait(4);

	IPrintLnBold("the mixture is ready");


	thread collect_the_sap();

}

function collect_the_sap()
{

	level.collect_sap Show();
	level.collect_sap SetHintString("Press ^3[{+activate}]^7 to collect the mixture");
	level.collect_sap SetCursorHint("HINT_NOICON");

	level.collect_sap waittill("trigger", player);

	

	exploder::kill_exploder("flame");

	level.collect_sap Delete();

	level.sap Delete();
	level.balloon Delete();

	IPrintLnBold("Now use the mixture on the weird plant in this room...");

	thread kill_plant();

}


//////////////////////////////////////////
///////////KILL THE PLANT 

function kill_plant()
{
	
	level.kill_plant_trig SetHintString("Press ^3[{+activate}]^7 to use the mixture");
	level.kill_plant_trig SetCursorHint("HINT_NOICON");

	level.kill_plant_trig waittill("trigger", player);

	

	player PlaySound("weirdplant");

	foreach(model in level.kill_plant)
	{
		model MoveZ(-1000,3);
	}


	level.kill_plant_clip Delete();

	level.kill_plant_trig Delete();


	thread ending();

}


///////////////////////////////////////////////////
//RADIO

function ending()
{	
	level.radio_trig = GetEnt("radio_trig", "targetname");
	level.radio_trig SetHintString("Press ^3[{+activate}]^7 to read the signal");
	level.radio_trig SetCursorHint("HINT_NOICON");
	


	level.radio_trig waittill("trigger", player);

	foreach(player in GetPlayers())
	{
		player PlaySound("signal");

	}


	exploder::exploder("alarm");

	level.radio_trig Delete();

	IPrintLnBold("something big is approching... ");

	wait(3);

	player PlaySound("pyramid");

	IPrintLnBold("it's responding at the pyramid's signal...");

	wait(3);

	player PlaySound("pyramid");

	IPrintLnBold("they are above the biodome on moon...");

	wait(3);

	IPrintLnBold("go to the moon...");

	level.ship Show();

	level.egg_model Show();

	thread current_step5();

	thread egg();


}

///////////////////////////////////////////
//////EGG

function egg()
{	
	level.alien_clip = GetEnt("alien_clip", "targetname");
	level.alien_model = GetEnt("alien_model", "targetname");



	
	level.egg_trig SetHintString("Press ^3[{+activate}]^7 to touch the big seed");
	level.egg_trig SetCursorHint("HINT_NOICON");
	level.egg_trig Show();
	level.egg_model Show();

	exploder::exploder("egg");

	dome_model = GetEnt("dome", "targetname");

	level.egg_trig waittill("trigger", player);

	level notify("end_step_5");


	level.egg_model Delete();
	level.egg_trig Delete();

	exploder::kill_exploder("egg");

	player PlaySound("pyramid");

	wait(2);

	exploder::exploder("red_points");

	player PlaySound("explosion");

	wait(11);
	exploder::kill_exploder("red_points");
	exploder::exploder("explo_dome1");
	exploder::exploder("explo_dome2");
	exploder::exploder("explo_dome3");
	exploder::exploder("explo_dome4");
	exploder::exploder("explo_dome5");
	exploder::exploder("explo_dome6");
	exploder::exploder("explo_dome7");
	exploder::exploder("explo_dome8");
	exploder::exploder("explo_dome9");
	exploder::exploder("explo_dome10");
	exploder::exploder("explo_dome11");
	exploder::exploder("explo_dome12");
	exploder::exploder("explo_dome13");
	exploder::exploder("explo_dome14");
	exploder::exploder("explo_dome15");
	

	wait(0.5);

	dome_model Delete();

	exploder::kill_exploder("explo_dome1");
	exploder::kill_exploder("explo_dome2");
	exploder::kill_exploder("explo_dome3");
	exploder::kill_exploder("explo_dome4");
	exploder::kill_exploder("explo_dome5");
	exploder::kill_exploder("explo_dome6");
	exploder::kill_exploder("explo_dome7");
	exploder::kill_exploder("explo_dome8");
	exploder::kill_exploder("explo_dome9");
	exploder::kill_exploder("explo_dome10");
	exploder::kill_exploder("explo_dome11");
	exploder::kill_exploder("explo_dome12");
	exploder::kill_exploder("explo_dome13");
	exploder::kill_exploder("explo_dome14");
	exploder::kill_exploder("explo_dome15");

	wait(2);

	player PlaySound("alien_portal");

	exploder::exploder("space_ship1");
	exploder::exploder("space_ship2");
	exploder::exploder("space_ship3");
	exploder::exploder("space_ship4");
	exploder::exploder("space_ship5");
	exploder::exploder("space_ship6");
	exploder::exploder("space_ship7");
	exploder::exploder("space_ship8");
	exploder::exploder("space_ship9");

	wait(2);

	level.alien_clip MoveZ(-150,2);
	level.alien_model MoveZ(-150,2);

	wait(2);

	level.alien_clip Delete();
	level.alien_model Delete();

	foreach(player in GetPlayers())
	{
		player PlaySound("board");

	}

	IPrintLnBold("this is not an invitation...");

	wait(2);

	IPrintLnBold("you must destroy their ship !");

	wait(5);

	thread shield_1();


}

function shield_1()
{	
	//init other shields trigs
	IPrintLnBold("there must be a way to disable the shields...");

	IPrintLnBold("disable shields 0/4");

	exploder::exploder("panel_1");
	//shield 2

	level.shield_off2 = GetEnt("shield_off2", "targetname");
	level.shield_off2 SetHintString("you must destroy generator 1 first");
	level.shield_off2 SetCursorHint("HINT_NOICON");
	
	
	level.generator_trig2 = GetEnt("generator_trig2", "targetname");
	level.generator_trig2 Hide();

	//shield 3

	level.shield_off3 = GetEnt("shield_off3", "targetname");
	level.shield_off3 SetHintString("you must destroy generator 2 first");
	level.shield_off3 SetCursorHint("HINT_NOICON");
	

	
	level.generator_trig3 = GetEnt("generator_trig3", "targetname");
	level.generator_trig3 Hide();

	//shield 4

	level.shield_off4 = GetEnt("shield_off4", "targetname");
	level.shield_off4 SetHintString("you must destroy generator 3 first");
	level.shield_off4 SetCursorHint("HINT_NOICON");
	

	level.generator_trig4 = GetEnt("generator_trig4", "targetname");
	level.generator_trig4 Hide();

	//////////////////////init 1st

	shield1 = GetEnt("shield1", "targetname");
	shield_clip1 = GetEnt("shield_clip1", "targetname");

	shield_off1 = GetEnt("shield_off1", "targetname");
	shield_off1 SetHintString("Press ^3[{+activate}]^7 to disable shield 1");
	shield_off1 SetCursorHint("HINT_NOICON");

	generator1 = GetEnt("generator1", "targetname");
	
	generator_trig1 = GetEnt("generator_trig1", "targetname");
	generator_trig1 Hide();


	///////////////////////desactivate

	shield_off1 waittill("trigger", player);

	exploder::kill_exploder("panel_1");

	IPrintLnBold("The shield 1 is disable");
	IPrintLnBold("A grenade can break the generator");

	shield_off1 Delete();

	shield1 Delete();
	shield_clip1 Delete();

	generator_trig1 Show();

	/////////////////////destroy

	generator_trig1 waittill("trigger", player);


	exploder::exploder("gen_explo1");

	foreach(player in GetPlayers()) 
	{
		player PlaySound("gen_explo");
	}    

	generator1 Delete();
	generator_trig1 Delete();

	IPrintLnBold("destroy generators 1/4");
	wait(1);
	IPrintLnBold("you must disable the next shield...");

	exploder::exploder("panel_2");



	thread shield_2();

}

function shield_2()
{	


	//////////////////////init

	shield2 = GetEnt("shield2", "targetname");
	shield_clip2 = GetEnt("shield_clip2", "targetname");

	level.shield_off2 = GetEnt("shield_off2", "targetname");
	level.shield_off2 SetHintString("Press ^3[{+activate}]^7 to disable shield 2");
	level.shield_off2 SetCursorHint("HINT_NOICON");
	level.shield_off2 Show();

	generator2 = GetEnt("generator2", "targetname");

	///////////////////////desactivate

	level.shield_off2 waittill("trigger", player);

	exploder::kill_exploder("panel_2");

	IPrintLnBold("The shield 2 is disable");

	level.shield_off2 Delete();

	shield2 Delete();
	shield_clip2 Delete();

	level.generator_trig2 Show();

	/////////////////////destroy

	level.generator_trig2 waittill("trigger", player);


	exploder::exploder("gen_explo1");

	foreach(player in GetPlayers()) 
	{
		player PlaySound("gen_explo");
	}    

	generator2 Delete();
	level.generator_trig2 Delete();

	IPrintLnBold("destroy generators 2/4");
	wait(1);
	IPrintLnBold("you must disable the next shield...");

	exploder::exploder("panel_3");

	thread shield_3();

}

function shield_3()
{	


	//////////////////////init

	shield3 = GetEnt("shield3", "targetname");
	shield_clip3 = GetEnt("shield_clip3", "targetname");

	level.shield_off3 = GetEnt("shield_off3", "targetname");
	level.shield_off3 SetHintString("Press ^3[{+activate}]^7 to disable shield 3");
	level.shield_off3 SetCursorHint("HINT_NOICON");
	level.shield_off3 Show();

	generator3 = GetEnt("generator3", "targetname");

	///////////////////////desactivate

	level.shield_off3 waittill("trigger", player);

	exploder::kill_exploder("panel_3");

	IPrintLnBold("The shield 3 is disable");

	level.shield_off3 Delete();

	shield3 Delete();
	shield_clip3 Delete();

	level.generator_trig3 Show();

	/////////////////////destroy

	level.generator_trig3 waittill("trigger", player);


	exploder::exploder("gen_explo1");

	foreach(player in GetPlayers()) 
	{
		player PlaySound("gen_explo");
	}    

	generator3 Delete();
	level.generator_trig3 Delete();

	IPrintLnBold("destroy generators 3/4");
	wait(1);
	IPrintLnBold("you must disable the last shield...");

	exploder::exploder("panel_5");

	thread shield_4();

}


function shield_4()
{	


	//////////////////////init

	shield4 = GetEnt("shield4", "targetname");
	shield_clip4 = GetEnt("shield_clip4", "targetname");

	level.shield_off4 = GetEnt("shield_off4", "targetname");
	level.shield_off4 SetHintString("Press ^3[{+activate}]^7 to disable shield 4");
	level.shield_off4 SetCursorHint("HINT_NOICON");
	level.shield_off4 Show();

	generator4 = GetEnt("generator4", "targetname");
	

	///////////////////////desactivate

	level.shield_off4 waittill("trigger", player);

	exploder::kill_exploder("panel_5");

	IPrintLnBold("The shield 4 is disable");

	level.shield_off4 Delete();

	shield4 Delete();
	shield_clip4 Delete();

	level.generator_trig4 Hide();

	/////////////////////destroy

	level.generator_trig4 waittill("trigger", player);


	exploder::exploder("gen_explo1");

	foreach(player in GetPlayers()) 
	{
		player PlaySound("gen_explo");
	}    

	generator4 Delete();
	level.generator_trig4 Delete();

	IPrintLnBold("destroy generators 4/4");

	wait(3);

	IPrintLnBold("Stay alive and get out of here");

	thread get_out();

}


function get_out()
{	
	exploder::kill_exploder("gen_explo2");
	exploder::kill_exploder("space_ship1");
	exploder::kill_exploder("space_ship2");
	exploder::kill_exploder("space_ship3");
	exploder::kill_exploder("space_ship4");
	exploder::kill_exploder("space_ship5");
	exploder::kill_exploder("space_ship6");
	exploder::kill_exploder("space_ship7");
	exploder::kill_exploder("space_ship8");
	exploder::kill_exploder("space_ship9");

	level notify("generator_2_end");
	stop_clip = GetEnt("stop_clip", "targetname");
	stop_model = GetEnt("stop_model", "targetname");

	stop_clip MoveZ(185,1);
	stop_model MoveZ(185,1);

	end_clip = GetEnt("end_clip", "targetname");
	end_glass = GetEnt("end_glass", "targetname");

	end_clip Delete();
	end_glass Delete();

	thread ship_explosion();
	
}

function ship_explosion()
{	

	exploder::exploder("explo_ship1");
	wait(0.1);
	exploder::exploder("fire_ship");
	exploder::exploder("fire_ship2");
	exploder::exploder("fire_ship3");
	exploder::exploder("fire_ship4");


	foreach(player in GetPlayers())
	{
		player PlaySound("gen_explo");
	}
	
	wait(5);

	exploder::exploder("explo_ship2");

	foreach(player in GetPlayers())
	{
		player PlaySound("gen_explo");

		wait(5);

		player PlaySound("gen_explo");
	

		wait(5);

		player PlaySound("gen_explo");
	

		wait(5);

		player PlaySound("gen_explo");
	
	}

	thread kill_explo();
	thread explosion_end();
	
}


function kill_explo()
{
	exploder::kill_exploder("explo_ship1");
	exploder::kill_exploder("fire_ship");
	exploder::kill_exploder("fire_ship2");
	exploder::kill_exploder("fire_ship3");
	exploder::kill_exploder("fire_ship4");
	exploder::kill_exploder("explo_ship2");
}

function explosion_end()
{	


	wait(5);
	exploder::exploder("dead_ship1");
	exploder::exploder("dead_ship2");
	exploder::exploder("dead_ship3");
	exploder::exploder("new_explo_ship");

	
	foreach(player in GetPlayers())
	{
		player PlaySound("big_explo");
	}

	level.ship Hide();


	IPrintLnBold("Good job !");

	wait(5);

	IPrintLnBold("Start the 2nd mission at the H.Q");

	foreach(player in GetPlayers())
	{
		player PlaySound("endm1");

	}

	thread current_step6();

	wait(3);



	final_door = GetEnt("final_door", "targetname");
	final_clip = GetEnt("final_clip", "targetname");

	final_door Delete();
	final_clip Delete();

	thread kill_exploders();
	


}

function kill_exploders()
{
	exploder::kill_exploder("dead_ship1");
	exploder::kill_exploder("dead_ship2");
	exploder::kill_exploder("dead_ship3");
	exploder::kill_exploder("new_explo_ship");
}


////////////////////////////////////////////////////////////////////////////////////////////////////


function tv()
{	
	level waittill("initial_blackscreen_passed");

	level.hint_m2 = GetEnt("hint_m2", "targetname");
	level.hint_m2 Hide();

	tv_brushmodel = GetEntArray("hint", "targetname");
	foreach(brushmodel in tv_brushmodel)
	{
		brushmodel Hide();
	}

	level waittill("power_on");
	foreach(brushmodel in tv_brushmodel)
	{
		brushmodel Show();
	}
}


///////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////////////////
///MISSION TWO
////////////////////////////////////////////////////////////////////////////////////////////

function side_quest()
{
	level waittill("initial_blackscreen_passed");

	
	//portal

	level.ee_portal = GetEntArray("ee_portal", "targetname");
	foreach(brushmodel in level.ee_portal)
	{
		brushmodel Hide();
	}

	//skull 1

	level.place_skull_1 = GetEnt("place_skull_1", "targetname");
	level.place_skull_1 Hide();

	level.place_skull_trig_1 = GetEnt("place_skull_trig_1", "targetname");
	level.place_skull_trig_1 SetHintString("missing skull 1");
	level.place_skull_trig_1 SetCursorHint("HINT_NOICON");

	//skull 2

	level.place_skull_2 = GetEnt("place_skull_2", "targetname");
	level.place_skull_2 Hide();

	level.place_skull_trig_2 = GetEnt("place_skull_trig_2", "targetname");
	level.place_skull_trig_2 SetHintString("missing skull 2");
	level.place_skull_trig_2 SetCursorHint("HINT_NOICON");

	//skull 3

	level.place_skull_3 = GetEnt("place_skull_3", "targetname");
	level.place_skull_3 Hide();

	level.place_skull_trig_3 = GetEnt("place_skull_trig_3", "targetname");
	level.place_skull_trig_3 SetHintString("missing skull 3");
	level.place_skull_trig_3 SetCursorHint("HINT_NOICON");

	//skull 4

	level.place_skull_4 = GetEnt("place_skull_4", "targetname");
	level.place_skull_4 Hide();

	level.place_skull_trig_4 = GetEnt("place_skull_trig_4", "targetname");
	level.place_skull_trig_4 SetHintString("missing skull 4");
	level.place_skull_trig_4 SetCursorHint("HINT_NOICON");

	//skull 5

	level.place_skull_5 = GetEnt("place_skull_5", "targetname");
	level.place_skull_5 Hide();

	level.place_skull_trig_5 = GetEnt("place_skull_trig_5", "targetname");
	level.place_skull_trig_5 SetHintString("missing skull 5");
	level.place_skull_trig_5 SetCursorHint("HINT_NOICON");

	thread activate_mission_2();
	thread skull_1_init();
	thread skull_2_init();
	thread skull_3_init();
	thread skull_4_init();
	thread skull_5_init();
	
	


}

////////////////////////////////////////////////////////////
//portal function
function end_portal()
{
	level.skull_placed = 0;

	while(isdefined(self))
	{
		if(level.skull_placed == 5)
        {
            
           	thread portal_opening();
            break;
        }
        else
        {
            wait(1);
        }  
	} 


}

function portal_opening()
{		
	level.activate_fight = GetEnt("activate_fight", "targetname");
	level.activate_fight SetHintString("Press ^3&&1^7 to call the swarm... ^3(2nd ending will be locked)");
	level.activate_fight SetCursorHint("HINT_NOICON");

		portaclip = GetEnt("portaclip", "targetname");
		portaclip Delete();

		IPrintLnBold(" The Portal is complete...");
           	foreach(brushmodel in level.ee_portal)
			{
				brushmodel Show();
			}
			foreach(player in GetPlayers())
			{
				player PlaySound("thunder");
			}

			exploder::exploder("open_portal");

			wait(10);

	foreach(player in GetPlayers())
	{
		player PlaySound("portal1");

	}


			thread gate_ship();
			//exploder::exploder("");
			//exploder::exploder("");
			//exploder::exploder("");

			//thread boss_fight();
}
////////////////////////////////////////////////////////////
function activate_mission_2()
{	
	//level waittill("end_mission_1"); 
	exploder::exploder("m_2");
	trig_M2 = GetEnt("trig_M2", "targetname");
	trig_M2 SetHintString("Press ^3&&1^7 to launch the 2 nd mission");
	trig_M2 SetCursorHint("HINT_NOICON");

	trig_M2 waittill("trigger", player);

	level notify("end_step_6");

	foreach(player in GetPlayers())
	{
		player PlaySound("m2");

	}

	exploder::kill_exploder("m_2");

	trig_M2 Delete();

	level.hint_m2 Show();

	IPrintLnBold("the same signal was emitted from the snowy ruins");

	wait(5);

	IPrintLnBold("5 skulls appeared");

	wait(5);

	IPrintLnBold("find them and place them near the snowy ruins (lvl 3)");

	wait(5);

	IPrintLnBold("you can check the goals from HQ");


	thread skull_1_on();
	thread skull_2_on();
	thread skull_3_on();
	thread skull_4_on();
	thread skull_5_on();
	thread end_portal();
	level init_keycard();
	

}




function skull_1_init()
{	

	level.model_skull_1 = GetEntArray("model_skull_1", "targetname");
	foreach(model in level.model_skull_1)
	{
		model Hide();
	}

	level.clip_skull_1 = GetEntArray("clip_skull_1", "targetname");
	foreach(clip in level.clip_skull_1)
	{
		clip Hide();
	}

	level.skull_1 = GetEnt("skull_1", "targetname");
	level.skull_1 Hide();

	level.pickup_skull_1 = GetEnt("pickup_skull_1", "targetname");
	level.pickup_skull_1 SetHintString("Press ^3&&1^7 to pickup the 1st skull");
	level.pickup_skull_1 SetCursorHint("HINT_NOICON");
	

	
	
}

/////////////////////////////////////////////////////////
//skull 1

function skull_1_on()
{	
	
	

	foreach(model in level.model_skull_1)
	{
		model Show();

	}
	
	foreach(clip in level.clip_skull_1)
	{
		clip Show();
	}

	level.skull_1 Show();
	exploder::exploder("1_skull");
	

	level.pickup_skull_1 waittill("trigger", player);

	exploder::kill_exploder("1_skull");

	IPrintLnBold(" you get the 1st skull, you can place it near the portal (lvl 3)");

	level.skull_1 Delete();
	level.pickup_skull_1 Delete();


	thread place_skull_1();

}

function place_skull_1()
{

	level.place_skull_trig_1 SetHintString("Press ^3&&1^7 to place the skull 1");
	level.place_skull_trig_1 SetCursorHint("HINT_NOICON");

	level.place_skull_trig_1 waittill("trigger", player);

	exploder::exploder("skull_1");

	level.place_skull_1 Show();
	level.place_skull_trig_1 Delete();

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.skull_placed += 1;

}


/////////////////////////////////////////////////////////
//skull 2

function skull_2_init()
{	

	//skull 2 model
	level.skull_2 = GetEnt("skull_2", "targetname");
	level.skull_2 Hide();

	//skull 2 pickup
	level.pickup_skull_2 = GetEnt("pickup_skull_2", "targetname");
	level.pickup_skull_2 SetHintString("Press ^3&&1^7 to pickup the 2 nd skull");
	level.pickup_skull_2 SetCursorHint("HINT_NOICON");
	level.pickup_skull_2 Hide();

	//models sand wrong
	level.wrong_skull_2 = GetEntArray("wrong_skull_2", "targetname");
	foreach(model in level.wrong_skull_2)
	{
		model Hide();
	}

	//trigs wrong
	level.wrong_skull_trig = GetEntArray("wrong_skull_trig", "targetname");
	
	
	foreach(trig in level.wrong_skull_trig)
	{	
		trig SetHintString("Press ^3&&1^7 to dig up ");
		trig SetCursorHint("HINT_NOICON");
		trig Hide();
	}

	//model sand right
	level.right_skull_2 = GetEnt("right_skull_2", "targetname");
	level.right_skull_2 Hide();

	//trig right 
	level.right_skull_trig = GetEnt("right_skull_trig", "targetname");
	level.right_skull_trig SetHintString("Press ^3&&1^7 to dig up");
	level.right_skull_trig SetCursorHint("HINT_NOICON");
	level.right_skull_trig Hide();

	

}

function skull_2_on()
{	
	//level waittill("end_mission_1");

	level.right_skull_2 Show();
	level.right_skull_trig Show();

	
	/////wrong////////////////

	foreach(model in level.wrong_skull_2)
	{
		model Show();
	}

	foreach(trig in level.wrong_skull_trig)
	{	
		
		trig Show();
		
		thread wrong_skull(trig);
	}


	//right///////////////

	
	thread right_skull();
}

function wrong_skull(trig)
{	

	trig.wrongsand = ArrayGetClosest(trig.origin, level.wrong_skull_2);

	trig waittill ("trigger", player);

	IPrintLnBold("Nothing here");

	trig.wrongsand Delete();

	trig Delete();

}

function right_skull()
{	
	level.right_skull_trig Show();
	level.right_skull_trig waittill("trigger", player);

	level.right_skull_2 Delete();
	level.right_skull_trig Delete();

	level.skull_2 Show();
	exploder::exploder("2_skull");
	level.pickup_skull_2 Show();

	level.pickup_skull_2 waittill("trigger",player);

	exploder::kill_exploder("2_skull");

	IPrintLnBold(" you get the 2nd skull, you can place it near the portal (lvl 3)");

	level.skull_2 Delete();
	level.pickup_skull_2 Delete();


	thread place_skull_2();
}

function place_skull_2()
{
	level.place_skull_trig_2 SetHintString("Press ^3&&1^7 to place the skull 2");
	level.place_skull_trig_2 SetCursorHint("HINT_NOICON");

	level.place_skull_trig_2 waittill("trigger", player);

	exploder::exploder("skull_2");

	level.place_skull_2 Show();
	level.place_skull_trig_2 Delete();

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.skull_placed += 1;

}


////////////////////////////////////////////////////////
///SKULL 3

function skull_3_init()
{	

	level.raygun_trig = GetEnt("raygun_trig", "targetname");
	level.raygun_trig SetHintString("Press ^3&&1^7 to use the ray gun");
	level.raygun_trig SetCursorHint("HINT_NOICON");
	level.raygun_trig Hide();

	level.mirror_1 = GetEnt("mirror_1", "targetname");

	level.pickup_mirror = GetEnt("pickup_mirror", "targetname");
	level.pickup_mirror SetHintString("Press ^3&&1^7 to pickup the mirror");
	level.pickup_mirror SetCursorHint("HINT_NOICON");
	level.pickup_mirror Hide();

	level.mirror_2 = GetEnt("mirror_2", "targetname");
	level.mirror_2 Hide();

	level.place_mirror = GetEnt("place_mirror", "targetname");
	level.place_mirror SetHintString("missing mirror (MIRROR > HUB)");
	level.place_mirror SetCursorHint("HINT_NOICON");
	level.place_mirror Hide();

	level.ray_1 = GetEnt("ray_1", "targetname");
	level.ray_1 Hide();

	level.ray_2 = GetEntArray("ray_2", "targetname");
	foreach(brushmodel in level.ray_2)
	{
		brushmodel Hide();
	}

	level.big_skull = GetEnt("big_skull", "targetname");
	level.big_skull Hide();

	level.skull_3 = GetEnt("skull_3", "targetname");
	level.skull_3 Hide();

	level.pickup_skull_3 = GetEnt("pickup_skull_3", "targetname");
	level.pickup_skull_3 SetHintString("Press ^3&&1^7 to pickup the 3rd skull");
	level.pickup_skull_3 SetCursorHint("HINT_NOICON");
	level.pickup_skull_3 Hide();
}

function skull_3_on()
{	
	exploder::exploder("ray_trig");
	level.raygun_trig Show();

	level.big_skull Show();

	level.raygun_trig waittill("trigger", player);

	exploder::kill_exploder("ray_trig");
	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.raygun_trig Delete();
	level.ray_1 Show();
	level.pickup_mirror Show();

	level.place_mirror Show();

	thread mirror();

}

function mirror()
{
	level.pickup_mirror waittill("trigger", player);

	level.mirror_1 Delete();
	level.pickup_mirror Delete();

	level.place_mirror SetHintString("Press ^3&&1^7 to place the mirror");
	level.place_mirror SetCursorHint("HINT_NOICON");

	level.place_mirror waittill("trigger", player);

	level.place_mirror Delete();
	level.mirror_2 Show();
	level.ray_1 Delete();

	foreach(brushmodel in level.ray_2)
	{
		brushmodel Show();
	}

	level.big_skull Delete();

	level.skull_3 Show();
	exploder::exploder("3_skull");

	level.pickup_skull_3 Show();

	level.pickup_skull_3 waittill("trigger", player);

	exploder::kill_exploder("3_skull");

	IPrintLnBold(" you get the 3rd skull, you can place it near the portal (lvl 3)");

		foreach(brushmodel in level.ray_2)
	{
		brushmodel Delete();
	}

	level.skull_3 Delete();
	level.pickup_skull_3 Delete();

	thread place_skull_3();

}

function place_skull_3()
{
	level.place_skull_trig_3 SetHintString("Press ^3&&1^7 to place the skull 3");
	level.place_skull_trig_3 SetCursorHint("HINT_NOICON");

	level.place_skull_trig_3 waittill("trigger", player);

	exploder::exploder("skull_3");

	level.place_skull_3 Show();
	level.place_skull_trig_3 Delete();

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.skull_placed += 1;
}

//////////////////////////////////////////////////
//SKULL 4

function skull_4_init()
{
	level.crystal = GetEnt("crystal", "targetname");
	level.crystal Hide();

	level.skull_4 = GetEnt("skull_4", "targetname");
	level.skull_4 Hide();

	level.crystal_trig = GetEnt("crystal_trig", "targetname");
	level.crystal_trig Hide();

	level.pickup_skull_4 = GetEnt("pickup_skull_4", "targetname");
	level.pickup_skull_4 SetHintString("Press ^3&&1^7 to Pick Up the 4th skull");
	level.pickup_skull_4 SetCursorHint("HINT_NOICON");
	level.pickup_skull_4 Hide();


}

function skull_4_on()
{
	level.crystal Show();
	level.skull_4 Show();
	level.crystal_trig Show();

	level.crystal_trig waittill("trigger", player);

	level.crystal Delete();
	level.crystal_trig Delete();

	level.skull_4 MoveY(-870,2);

	wait(2);

	exploder::exploder("4_skull");

	level.pickup_skull_4 Show();

	level.pickup_skull_4 waittill("trigger", player);

	exploder::kill_exploder("4_skull");

	IPrintLnBold(" you get the 4th skull, you can place it near the portal (lvl 3)");

	level.skull_4 Delete();
	level.pickup_skull_4 Delete();



	thread place_skull_4();
}

function place_skull_4()
{
	level.place_skull_trig_4 SetHintString("Press ^3&&1^7 to place the skull 4");
	level.place_skull_trig_4 SetCursorHint("HINT_NOICON");

	level.place_skull_trig_4 waittill("trigger", player);

	exploder::exploder("skull_4");

	level.place_skull_4 Show();
	level.place_skull_trig_4 Delete();

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.skull_placed += 1;
}

///////////////////////////////////////////////
////SKULL 5

function skull_5_init()
{
	level.skull_5 = GetEnt("skull_5", "targetname");
	exploder::exploder("5_skull");


	level.pickup_skull_5 = GetEnt("pickup_skull_5", "targetname");
	level.pickup_skull_5 SetHintString("Press ^3&&1^7 to Pick Up the 5th skull");
	level.pickup_skull_5 SetCursorHint("HINT_NOICON");
	level.pickup_skull_5 Hide();
}

function skull_5_on()
{	

	level.pickup_skull_5 Show();
	level.pickup_skull_5 waittill("trigger", player);

	exploder::kill_exploder("5_skull");

	IPrintLnBold(" you get the 5th skull, you can place it near the portal (lvl 3)");

	level.skull_5 Delete();
	level.pickup_skull_5 Delete();

	thread place_skull_5();

}



function init_keycard()
{	
	exploder::exploder("key_card");
    level.key_obtained = false;
    key = GetEnt( "key_trigger", "targetname" );
    key SetCursorHint( "HINT_NOICON" );
    key SetHintString( "Press and Hold ^3&&1^7 to Pick Up Keycard" );
    key thread wait_for_pickup();
      
    key_doors = GetEntArray( "key_door", "targetname" );
    foreach( door in key_doors )
    {
        door SetCursorHint( "HINT_NOICON" );
        door SetHintString( "A Key is Required to Open the Door" );
        door thread wait_for_unlock();
    }
}
  
function wait_for_pickup()
{
    self waittill( "trigger", player );
    exploder::kill_exploder("key_card");
    model = GetEnt( self.target, "targetname" );
    model delete();
    self delete();
    level.key_obtained = true;
    iprintlnbold( "The Keycard Has Been Obtained" );
}
  
function wait_for_unlock()
{
    level endon( "intermission" );
      
    while( !level.key_obtained )
        wait(0.25);
      
    self SetHintString( "Press and Hold ^3&&1^7 to Unlock Door" );
    self waittill( "trigger", player );
    models = GetEntArray( self.target, "targetname" );
    PlaySoundAtPosition( "zmb_cha_ching", player.origin );
    spawn_flag = models[0].script_flag;
    flag::set( spawn_flag );
    wait(0.05);
    foreach( model in models )
        model delete();
    self delete();

    
}

function place_skull_5()
{
	level.place_skull_trig_5 SetHintString("Press ^3&&1^7 to place the skull 4");
	level.place_skull_trig_5 SetCursorHint("HINT_NOICON");

	level.place_skull_trig_5 waittill("trigger", player);

	exploder::exploder("skull_5");

	level.place_skull_5 Show();
	level.place_skull_trig_5 Delete();

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.skull_placed += 1;
}

/////////////////////////////////////////////////////////////////////////////////////////////
//ACTIVATE HELL
///////////////////////////////////////////////////

function gate_ship()
{	
	//runes
	exploder::exploder("grenade_1");
	level.end_rune_1 = GetEnt("end_rune_1", "targetname");
	level.end_rune_2 = GetEnt("end_rune_2", "targetname");
	level.end_rune_2 Hide();

	level.end_rune_3 = GetEnt("end_rune_3", "targetname");
	level.end_rune_4 = GetEnt("end_rune_4", "targetname");
	level.end_rune_4 Hide();

	level.end_rune_5 = GetEnt("end_rune_5", "targetname");
	level.end_rune_6 = GetEnt("end_rune_6", "targetname");
	level.end_rune_6 Hide();



	//trig
	level.explo_trig_1 = GetEnt("explo_trig_1", "targetname");

	level.explo_trig_2 = GetEnt("explo_trig_2", "targetname");
	level.explo_trig_2 Hide();

	level.explo_trig_3 = GetEnt("explo_trig_3", "targetname");
	level.explo_trig_3 Hide();

	level.clip_end_door_1 = GetEntArray("clip_end_door_1", "targetname");

	thread gate_rune_1();

}

function gate_rune_1()
{
	////////////////////

	level.explo_trig_1 waittill("trigger", player);

	exploder::kill_exploder("grenade_1");

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.explo_trig_1 Delete();
	level.end_rune_1 Delete();
	level.end_rune_2 Show();

	level.explo_trig_2 Show();

	exploder::exploder("grenade_2");

	thread gate_rune_2();

}

function gate_rune_2()
{
	////////////////////

	level.explo_trig_2 waittill("trigger", player);

	exploder::kill_exploder("grenade_2");

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.explo_trig_2 Delete();
	level.end_rune_3 Delete();
	level.end_rune_4 Show();

	level.explo_trig_3 Show();

	exploder::exploder("grenade_3");

	thread gate_rune_3();
}

function gate_rune_3()
{
	//////////////////////

	level.explo_trig_3 waittill("trigger", player);

	exploder::kill_exploder("grenade_3");

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.explo_trig_3 Delete();
	level.end_rune_5 Delete();
	level.end_rune_6 Show();

	foreach(clip in level.clip_end_door_1)
	{
		clip Delete();
	}

	 

thread activate_hell();
}



function activate_hell()
{	
	
	level.activate_fight waittill("trigger", player);

	level.place_orb_1 Delete();
	level.place_orb_2 Delete();
	level.place_orb_3 Delete();
	level.place_orb_4 Delete();

	level.activate_fight Delete();

	IPrintLnBold("2nd ending has been locked");
	IPrintLnBold("The swarm is comming... ");

	wait(3);

	IPrintLnBold("targets appeared 0/10");

	thread round_wait_override();
	thread timed_gameplay();
	thread final_shoot_1();
}




//default round_wait func but without a check for zero zombies alive, which allows for continuous spawning
function round_wait_override()
{
	level endon("restart_round");
	level endon( "kill_round" );

	wait( 1 );

	while( 1 )
	{
		should_wait = ( level.zombie_total > 0 || level.intermission );	
		if( !should_wait )
		{
			return;
		}			
			
		if( level flag::get( "end_round_wait" ) )
		{
			return;
		}
		wait( 1.0 );
	}
}

function timed_gameplay() //If you want to call this yourself based on some user input or whatever, remove 'autoexec' and call this function externally from somewhere else.
{
	level.round_wait_func = &round_wait_override; //this has to happen before zm::round_start() runs!
	level.custom_game_over_hud_elem = &timed_game_over;

	wait 0.5; 

	//level.next_dog_round = 9999; //cheap way to disable dogs after zm_usermap::main() runs.
	level.zombie_vars["zombie_between_round_time"] = 5; //remove the delay at the end of each round 
	level.zombie_round_start_delay = 0; //remove the delay before zombies start to spawn

	level.ugxm_settings = [];
	if(isDefined(level.tgTimer)) level.tgTimer Destroy();
	level.tgTimer = NewHudElem();

	level.isTimedGameplay = true;

	if(!isDefined(level.ugxm_settings["timed_hud_offset"]))
		level.ugxm_settings["timed_hud_offset"] = 0;

	level.tgTimerTime = SpawnStruct();

	level.tgTimerTime.days = 0;
	level.tgTimerTime.hours = 0;
	level.tgTimerTime.minutes = 0;
	level.tgTimerTime.seconds = 0;
	level.tgTimerTime.toalSec = 0;
	
	level.tgTimer.foreground = false; 
	level.tgTimer.sort = 2; 
	level.tgTimer.hidewheninmenu = false; 

	level.tgTimer.fontScale = 1;
	level.tgTimer.alignX = "left"; 
	level.tgTimer.alignY = "bottom";
	level.tgTimer.horzAlign = "left";  
	level.tgTimer.vertAlign = "bottom";
	level.tgTimer.x = 60; 
	level.tgTimer.y = - 65 + level.ugxm_settings["timed_hud_offset"]; 
	
	level.tgTimer.alpha = 0;

	level flag::wait_till("initial_blackscreen_passed");
	
	level.tgTimer SetTimerUp(0);
	
	thread timed_gameplay_bg_counter();
	level.tgTimer.alpha = 1;
}
function timed_gameplay_bg_counter()
{
	level endon("end_game");
		
	while(1)
	{	
		if(level.tgTimerTime.seconds >= 59) 
		{
			level.tgTimerTime.seconds = 0;
			level.tgTimerTime.minutes ++;
		}
		
		if(level.tgTimerTime.minutes >= 59) 
		{
			level.tgTimerTime.minutes = 0;
			level.tgTimerTime.hours ++;
		}
		
		if(level.tgTimerTime.hours >= 23)
		{
			level.tgTimerTime.hours = 0;
			level.tgTimerTime.days ++;
		}
		
		level.tgTimerTime.seconds ++;
		level.tgTimerTime.toalSec ++;

		wait 1;

	}
}

function timed_game_over(player, game_over, survived)
{
	level.tgTimer Destroy();

	new_survived = NewClientHudElem( player );

	game_over.alignX = "center";
	game_over.alignY = "middle";
	game_over.horzAlign = "center";
	game_over.vertAlign = "middle";
	game_over.y -= 130;
	game_over.foreground = true;
	game_over.fontScale = 3;
	game_over.alpha = 0;
	game_over.color = ( 1.0, 1.0, 1.0 );
	game_over.hidewheninmenu = true;
	game_over SetText( "Game Over!" );

	game_over FadeOverTime( 1 );
	game_over.alpha = 1;
	if ( player isSplitScreen() )
	{
		game_over.fontScale = 2;
		game_over.y += 40;
	}

	secondsTxt = "";
	minsTxt = "";
	hoursTxt = "";
	daysTxt = "";
	
	if(level.tgTimerTime.seconds > 0)
	{
		secondsTxt = level.tgTimerTime.seconds + "s ";
	}
	if(level.tgTimerTime.minutes > 0)
	{
		minsTxt = level.tgTimerTime.minutes + "m ";
	}
	if(level.tgTimerTime.hours > 0)
	{
		hoursTxt = level.tgTimerTime.hours + "h ";
	}
	if(level.tgTimerTime.days > 0)
	{
		daysTxt = level.tgTimerTime.days + "d ";
	}
	if(daysTxt + hoursTxt + minsTxt + secondsTxt == "")
	{
		secondsTxt = "0s";
	}

	new_survived.alignX = "center";
	new_survived.alignY = "middle";
	new_survived.horzAlign = "center";
	new_survived.vertAlign = "middle";
	new_survived.y -= 100;
	new_survived.foreground = true;
	new_survived.fontScale = 2;
	new_survived.alpha = 0;
	new_survived.color = ( 1.0, 1.0, 1.0 );
	new_survived.hidewheninmenu = true;
	if ( player isSplitScreen() )
	{
		new_survived.fontScale = 1.5;
		new_survived.y += 40;
	}

	survived.y -= 999; //Hide the one we don't want, shame on Treyarch for not allowing a clean override.
	
	new_survived setText("You survived " + daysTxt + hoursTxt + minsTxt + secondsTxt);
	new_survived FadeOverTime(1);
	new_survived.alpha = 1;

	thread destory_game_over_hud(new_survived);
}

function destory_game_over_hud(hud)
{
	wait( level.zombie_vars["zombie_intermission_time"] );
	hud Destroy();
}



function final_step_1_init()
{

	level waittill("initial_blackscreen_passed");

	//lava trig

	level.lava_trig_1 = GetEnt("lava_trig_1", "targetname");
	level.lava_trig_1 Hide();

	level.lava_indicator_1 = GetEnt("lava_indicator_1", "targetname");
	level.lava_indicator_1 Hide();

	level.lava_trig_2 = GetEnt("lava_trig_2", "targetname");
	level.lava_trig_2 Hide();

	level.lava_indicator_2 = GetEnt("lava_indicator_2", "targetname");
	level.lava_indicator_2 Hide();

	level.lava_trig_3 = GetEnt("lava_trig_3", "targetname");
	level.lava_trig_3 Hide();

	level.lava_indicator_3 = GetEnt("lava_indicator_3", "targetname");
	level.lava_indicator_3 Hide();



	/////////////////// rune

	level.rune_1_on = GetEnt("rune_1_on", "targetname");
	level.rune_1_on Hide();

	level.rune_2_on = GetEnt("rune_2_on", "targetname");
	level.rune_2_on Hide();

	level.rune_3_on = GetEnt("rune_3_on", "targetname");
	level.rune_3_on Hide();

	level.rune_4_on = GetEnt("rune_4_on", "targetname");
	level.rune_4_on Hide();

	///////////////////////target

	level.targ_1 = GetEnt("targ_1", "targetname");
	level.trig_targ_1 = GetEnt("trig_targ_1", "targetname");
	level.targ_1 Hide();
	level.trig_targ_1 Hide();

	level.targ_2 = GetEnt("targ_2", "targetname");
	level.trig_targ_2 = GetEnt("trig_targ_2", "targetname");
	level.targ_2 Hide();
	level.trig_targ_2 Hide();

	level.targ_3 = GetEnt("targ_3", "targetname");
	level.trig_targ_3 = GetEnt("trig_targ_3", "targetname");
	level.targ_3 Hide();
	level.trig_targ_3 Hide();

	level.targ_4 = GetEnt("targ_4", "targetname");
	level.trig_targ_4 = GetEnt("trig_targ_4", "targetname");
	level.targ_4 Hide();
	level.trig_targ_4 Hide();

	level.targ_5 = GetEnt("targ_5", "targetname");
	level.trig_targ_5 = GetEnt("trig_targ_5", "targetname");
	level.targ_5 Hide();
	level.trig_targ_5 Hide();

	level.targ_6 = GetEnt("targ_6", "targetname");
	level.trig_targ_6 = GetEnt("trig_targ_6", "targetname");
	level.targ_6 Hide();
	level.trig_targ_6 Hide();

	level.targ_7 = GetEnt("targ_7", "targetname");
	level.trig_targ_7 = GetEnt("trig_targ_7", "targetname");
	level.targ_7 Hide();
	level.trig_targ_7 Hide();

	level.targ_8 = GetEnt("targ_8", "targetname");
	level.trig_targ_8 = GetEnt("trig_targ_8", "targetname");
	level.targ_8 Hide();
	level.trig_targ_8 Hide();

	level.targ_9 = GetEnt("targ_9", "targetname");
	level.trig_targ_9 = GetEnt("trig_targ_9", "targetname");
	level.targ_9 Hide();
	level.trig_targ_9 Hide();

	level.targ_10 = GetEnt("targ_10", "targetname");
	level.trig_targ_10 = GetEnt("trig_targ_10", "targetname");
	level.targ_10 Hide();
	level.trig_targ_10 Hide();

	level.targ_11 = GetEnt("targ_11", "targetname");
	level.trig_targ_11 = GetEnt("trig_targ_11", "targetname");
	level.targ_11 Hide();
	level.trig_targ_11 Hide();

	level.targ_12 = GetEnt("targ_12", "targetname");
	level.trig_targ_12 = GetEnt("trig_targ_12", "targetname");
	level.targ_12 Hide();
	level.trig_targ_12 Hide();

	level.targ_13 = GetEnt("targ_13", "targetname");
	level.trig_targ_13 = GetEnt("trig_targ_13", "targetname");
	level.targ_13 Hide();
	level.trig_targ_13 Hide();

	level.targ_14 = GetEnt("targ_14", "targetname");
	level.trig_targ_14 = GetEnt("trig_targ_14", "targetname");
	level.targ_14 Hide();
	level.trig_targ_14 Hide();

	level.targ_15 = GetEnt("targ_15", "targetname");
	level.trig_targ_15 = GetEnt("trig_targ_15", "targetname");
	level.targ_15 Hide();
	level.trig_targ_15 Hide();

	//////////////////////////////////
	//explo ship end

	//clip door right / left

	level.explo_clip_1 = GetEntArray("explo_clip_1", "targetname");

	level.explo_clip_2 = GetEntArray("explo_clip_2", "targetname");

	//step activate trigs to xm53

	level.explo_model_1 = GetEnt("explo_model_1", "targetname");

	level.explo_trig_ship_1 = GetEnt("explo_trig_ship_1", "targetname");
	level.explo_trig_ship_1 SetHintString("Press ^3&&1^7 to open the reactor");
	level.explo_trig_ship_1 SetCursorHint("HINT_NOICON");


	level.explo_model_2 = GetEnt("explo_model_2", "targetname");

	level.explo_trig_ship_2 = GetEnt("explo_trig_ship_2", "targetname");
	level.explo_trig_ship_2 SetHintString("Press ^3&&1^7 to open the reactor");
	level.explo_trig_ship_2 SetCursorHint("HINT_NOICON");


	//open reactor

	level.explo_door_1 = GetEnt("explo_door_1", "targetname");
	level.explo_door_2 = GetEnt("explo_door_2", "targetname");

	level.explo_door_3 = GetEnt("explo_door_3", "targetname");
	level.explo_door_4 = GetEnt("explo_door_4", "targetname");

	//trig reactor

	level.explo_ship_1 = GetEnt("explo_ship_1", "targetname");
	level.explo_ship_1 Hide();

	level.explo_ship_2 = GetEnt("explo_ship_2", "targetname");
	level.explo_ship_2 Hide();


}


function final_shoot_1()
{

	level.targ_1 Show();
	level.trig_targ_1 Show();

	level.trig_targ_1 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("1/10");

	level.targ_1 Hide();
	level.trig_targ_1 Hide();

	thread final_shoot_2();

}


function final_shoot_2()
{

	level.targ_2 Show();
	level.trig_targ_2 Show();

	level.trig_targ_2 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("2/10");

	level.targ_2 Hide();
	level.trig_targ_2 Hide();

	thread final_shoot_3();

}


function final_shoot_3()
{

	level.targ_3 Show();
	level.trig_targ_3 Show();

	level.trig_targ_3 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("3/10");

	level.targ_3 Hide();
	level.trig_targ_3 Hide();

	thread final_shoot_4();

}


function final_shoot_4()
{

	level.targ_4 Show();
	level.trig_targ_4 Show();

	level.trig_targ_4 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("4/10");

	level.targ_4 Hide();
	level.trig_targ_4 Hide();

	thread final_shoot_5();

}

function final_shoot_5()
{

	level.targ_5 Show();
	level.trig_targ_5 Show();

	level.trig_targ_5 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("5/10");

	level.targ_5 Hide();
	level.trig_targ_5 Hide();

	thread final_shoot_6();

}


function final_shoot_6()
{

	level.targ_6 Show();
	level.trig_targ_6 Show();

	level.trig_targ_6 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("6/10");

	level.targ_6 Hide();
	level.trig_targ_6 Hide();

	thread final_shoot_7();

}


function final_shoot_7()
{

	level.targ_7 Show();
	level.trig_targ_7 Show();

	level.trig_targ_7 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("7/10");

	level.targ_7 Hide();
	level.trig_targ_7 Hide();

	thread final_shoot_8();

}


function final_shoot_8()
{

	level.targ_8 Show();
	level.trig_targ_8 Show();

	level.trig_targ_8 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("8/10");

	level.targ_8 Hide();
	level.trig_targ_8 Hide();

	thread final_shoot_9();

}


function final_shoot_9()
{

	level.targ_9 Show();
	level.trig_targ_9 Show();

	level.trig_targ_9 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("9/10");

	level.targ_9 Hide();
	level.trig_targ_9 Hide();

	thread final_shoot_10();

}


function final_shoot_10()
{

	level.targ_10 Show();
	level.trig_targ_10 Show();

	level.trig_targ_10 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("10/10");

	level.targ_10 Hide();
	level.trig_targ_10 Hide();

	thread final_end_1();

}


/////////////////////


function final_end_1()
{
	rune_1_off = GetEnt("rune_1_off", "targetname");
	rune_1_off Delete();

	level.rune_1_on Show();

	pillar_one = GetEnt("pillar_one", "targetname");
	pillar_one MoveZ(-170,3);

	foreach(player in GetPlayers())
	{
		player PlaySound("movingrock");
	}

	IPrintLnBold("the 1st step is done, cool the pipes ! (grenade)");

	thread lava_1();

}

function lava_1()
{	

	
	level.lava_trig_1 Show();
	level.lava_indicator_1 Show();


	level.moving_floor = GetEntArray("moving_floor", "targetname");
	foreach(brushmodel in level.moving_floor)
	{
		brushmodel MoveZ(-300,1);
	}

	thread coolling_lava_1();


}

function coolling_lava_1()
{
	level.lava_trig_1 waittill("trigger", player);

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.lava_trig_1 Hide();
	level.lava_indicator_1 Hide();

	level.lava_trig_2 Show();
	level.lava_indicator_2 Show();

	thread coolling_b();

}

function coolling_b()
{
	level.lava_trig_2 waittill("trigger", player);

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.lava_trig_2 Hide();
	level.lava_indicator_2 Hide();

	level.lava_trig_3 Show();
	level.lava_indicator_3 Show();

	thread coolling_c();

}

function coolling_c()
{
	level.lava_trig_3 waittill("trigger", player);

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.lava_trig_3 Hide();
	level.lava_indicator_3 Hide();

	foreach(brushmodel in level.moving_floor)
	{
		brushmodel MoveZ(300,1);
	}

	foreach(player in GetPlayers())
	{
		player PlaySound("coolling");
	}


	thread step_2_end();
}

function step_2_end()
{
	exploder::exploder("explo_model_1");

	foreach(clip in level.explo_clip_1)
	{
		clip Delete();
	}

	level.explo_trig_ship_1 waittill("trigger", player);

	level.explo_model_1 Delete();
	level.explo_trig_ship_1 Delete();

	exploder::kill_exploder("explo_model_1");

	foreach(player in GetPlayers())
	{
		player PlaySound("caniup");
	}

	level.explo_door_1 MoveY(100,3);
	level.explo_door_2 MoveY(-100,3);

	IPrintLnBold("the reactor is open !");
	IPrintLnBold("an explosion can destroy the reactor...");

	thread step_2_shoot();

}

function step_2_shoot()
{
	level.explo_ship_1 Show();

	level.explo_ship_1 waittill("trigger", player);

	level.explo_ship_1 Delete();

	foreach(player in GetPlayers())
	{
		player PlaySound("gen_explo");
	}

	exploder::exploder("explo_ship_right");

	thread final_end_2();



}





//////////////////////

function final_end_2()
{
	rune_2_off = GetEnt("rune_2_off", "targetname");
	rune_2_off Delete();

	level.rune_2_on Show();

	pillar_two = GetEnt("pillar_two", "targetname");
	pillar_two MoveZ(-170,3);

	foreach(player in GetPlayers())
	{
		player PlaySound("movingrock");
	}

	IPrintLnBold("the 2nd step is done, cool the pipes ! (grenade)");

	thread lava_2();

}

function lava_2()
{	

	
	level.lava_trig_1 Show();
	level.lava_indicator_1 Show();


	level.moving_floor = GetEntArray("moving_floor", "targetname");
	foreach(brushmodel in level.moving_floor)
	{
		brushmodel MoveZ(-300,1);
	}

	thread coolling_lava_2();


}

function coolling_lava_2()
{
	level.lava_trig_1 waittill("trigger", player);

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.lava_trig_1 Hide();
	level.lava_indicator_1 Hide();

	level.lava_trig_2 Show();
	level.lava_indicator_2 Show();

	thread coolling_b_2();

}

function coolling_b_2()
{
	level.lava_trig_2 waittill("trigger", player);

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.lava_trig_2 Hide();
	level.lava_indicator_2 Hide();

	level.lava_trig_3 Show();
	level.lava_indicator_3 Show();

	thread coolling_c_2();
}


function coolling_c_2()
{
	level.lava_trig_3 waittill("trigger", player);

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.lava_trig_3 Hide();
	level.lava_indicator_3 Hide();

	foreach(brushmodel in level.moving_floor)
	{
		brushmodel MoveZ(300,1);
	}

	foreach(player in GetPlayers())
	{
		player PlaySound("coolling");
	}

	monster_clip = GetEntArray("monster_clip", "targetname");
	monster_clip Delete();



	thread step_3_shoot_1();
}

function step_3_shoot_1()
{	

	IPrintLnBold("targets appeared 0/10");
	
	level.targ_1 Show();
	level.trig_targ_1 Show();

	level.trig_targ_1 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("1/10");

	level.targ_1 Hide();
	level.trig_targ_1 Hide();

	thread step_3_shoot_2();

}


function step_3_shoot_2()
{

	level.targ_2 Show();
	level.trig_targ_2 Show();

	level.trig_targ_2 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("2/10");

	level.targ_2 Hide();
	level.trig_targ_2 Hide();

	thread step_3_shoot_3();

}


function step_3_shoot_3()
{

	level.targ_3 Show();
	level.trig_targ_3 Show();

	level.trig_targ_3 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("3/10");

	level.targ_3 Hide();
	level.trig_targ_3 Hide();

	thread step_3_shoot_4();

}


function step_3_shoot_4()
{

	level.targ_4 Show();
	level.trig_targ_4 Show();

	level.trig_targ_4 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("4/10");

	level.targ_4 Hide();
	level.trig_targ_4 Hide();

	thread step_3_shoot_5();

}

function step_3_shoot_5()
{

	level.targ_5 Show();
	level.trig_targ_5 Show();

	level.trig_targ_5 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("5/10");

	level.targ_5 Hide();
	level.trig_targ_5 Hide();

	thread step_3_shoot_6();

}


function step_3_shoot_6()
{

	level.targ_6 Show();
	level.trig_targ_6 Show();

	level.trig_targ_6 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("6/10");

	level.targ_6 Hide();
	level.trig_targ_6 Hide();

	thread step_3_shoot_7();

}


function step_3_shoot_7()
{

	level.targ_7 Show();
	level.trig_targ_7 Show();

	level.trig_targ_7 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("7/10");

	level.targ_7 Hide();
	level.trig_targ_7 Hide();

	thread step_3_shoot_8();

}


function step_3_shoot_8()
{

	level.targ_8 Show();
	level.trig_targ_8 Show();

	level.trig_targ_8 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("8/10");

	level.targ_8 Hide();
	level.trig_targ_8 Hide();

	thread step_3_shoot_9();

}


function step_3_shoot_9()
{

	level.targ_9 Show();
	level.trig_targ_9 Show();

	level.trig_targ_9 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("9/10");

	level.targ_9 Hide();
	level.trig_targ_9 Hide();

	thread step_3_shoot_10();

}


function step_3_shoot_10()
{

	level.targ_10 Show();
	level.trig_targ_10 Show();

	level.trig_targ_10 waittill("trigger", player);

	player PlaySound("eclat");

	IPrintLnBold("10/10");

	level.targ_10 Hide();
	level.trig_targ_10 Hide();

	thread final_end_3();

}


//////////////////////////

function final_end_3()
{
	rune_3_off = GetEnt("rune_3_off", "targetname");
	rune_3_off Delete();

	level.rune_3_on Show();

	pillar_three = GetEnt("pillar_three", "targetname");
	pillar_three MoveZ(-170,3);

	foreach(player in GetPlayers())
	{
		player PlaySound("movingrock");
	}

	IPrintLnBold("the 3rd step is done, cool the pipes ! (grenade)");

	thread lava_3();

}

function lava_3()
{	

	
	level.lava_trig_1 Show();
	level.lava_indicator_1 Show();


	level.moving_floor = GetEntArray("moving_floor", "targetname");
	foreach(brushmodel in level.moving_floor)
	{
		brushmodel MoveZ(-300,1);
	}

	thread coolling_lava_3();


}

function coolling_lava_3()
{
	level.lava_trig_1 waittill("trigger", player);

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.lava_trig_1 Hide();
	level.lava_indicator_1 Hide();

	level.lava_trig_2 Show();
	level.lava_indicator_2 Show();

	thread coolling_b_3();

}

function coolling_b_3()
{
	level.lava_trig_2 waittill("trigger", player);

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.lava_trig_2 Hide();
	level.lava_indicator_2 Hide();

	level.lava_trig_3 Show();
	level.lava_indicator_3 Show();

	thread coolling_c_3();
	
}

function coolling_c_3()
{
	level.lava_trig_3 waittill("trigger", player);

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.lava_trig_3 Hide();
	level.lava_indicator_3 Hide();

	foreach(brushmodel in level.moving_floor)
	{
		brushmodel MoveZ(300,1);
	}

	foreach(player in GetPlayers())
	{
		player PlaySound("coolling");
	}


	thread step_4_end();
}


function step_4_end()
{
	exploder::exploder("explo_model_2");

	foreach(clip in level.explo_clip_2)
	{
		clip Delete();
	}

	level.explo_trig_ship_2 waittill("trigger", player);

	level.explo_model_2 Delete();
	level.explo_trig_ship_2 Delete();

	exploder::kill_exploder("explo_model_2");

	foreach(player in GetPlayers())
	{
		player PlaySound("caniup");
	}

	level.explo_door_3 MoveY(-100,3);
	level.explo_door_4 MoveY(100,3);

	IPrintLnBold("the reactor is open !");
	IPrintLnBold("an explosion can destroy the reactor...");

	thread step_4_shoot();

}

function step_4_shoot()
{
	level.explo_ship_2 Show();

	level.explo_ship_2 waittill("trigger", player);

	level.explo_ship_2 Delete();

	foreach(player in GetPlayers())
	{
		player PlaySound("gen_explo");
	}

	exploder::exploder("explo_ship_left");

	thread final_end_4();



}


/////////////////////////////

function final_end_4()
{
	rune_4_off = GetEnt("rune_4_off", "targetname");
	rune_4_off Delete();

	level.rune_4_on Show();

	pillar_four = GetEnt("pillar_four", "targetname");
	pillar_four MoveZ(-170,3);

	foreach(player in GetPlayers())
	{
		player PlaySound("movingrock");
	}

	IPrintLnBold("the last step is done, cool the pipes ! (grenade)");

	thread lava_4();

}

function lava_4()
{	

	
	level.lava_trig_1 Show();
	level.lava_indicator_1 Show();


	level.moving_floor = GetEntArray("moving_floor", "targetname");
	foreach(brushmodel in level.moving_floor)
	{
		brushmodel MoveZ(-300,1);
	}

	thread coolling_lava_4();


}

function coolling_lava_4()
{
	level.lava_trig_1 waittill("trigger", player);

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.lava_trig_1 Hide();
	level.lava_indicator_1 Hide();

	

	thread coolling_b_4();

}

function coolling_b_4()
{	
	level.lava_trig_2 Show();
	level.lava_indicator_2 Show();

	level.lava_trig_2 waittill("trigger", player);

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.lava_trig_2 Hide();
	level.lava_indicator_2 Hide();

	

	thread coolling_c_4();

}

function coolling_c_4()
{	
	level.lava_trig_3 Show();
	level.lava_indicator_3 Show();

	level.lava_trig_3 waittill("trigger", player);

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	level.lava_trig_3 Hide();
	level.lava_indicator_3 Hide();

	foreach(brushmodel in level.moving_floor)
	{
		brushmodel MoveZ(300,1);
	}

	foreach(player in GetPlayers())
	{
		player PlaySound("coolling");
	}


	thread end_final_fight();
}

function end_final_fight()
{	
	final_clip_end = GetEntArray("the_last_clip", "targetname");


	IPrintLnBold("access to the platform in 60 sec");

	wait(60);

	IPrintLnBold("the platform is open, good job !");

	foreach(brushmodel in final_clip_end)
	{
		brushmodel Delete();
	}

}


////////////////////////////////////////////////////////////////////////////////////////////////
//BACKROOMS
///////////////////////////////////////////////////////////////////////////////////////////////

function backrooms_ee()
{
	
	level waittill("initial_blackscreen_passed");

	//jumpscares

	level.jump_scare_1 = GetEntArray("jump_scare_1", "targetname");
	foreach(model in level.jump_scare_1)
	{
		model Hide();
	}


	level.jump_scare_2 = GetEnt("jump_scare_2", "targetname");
	level.jump_scare_2 Hide();


	level.jump_scare_3 = GetEntArray("jump_scare_3", "targetname");
	foreach(model in level.jump_scare_3)
	{
		model Hide();
	}

	//models

	level.heart_1 = GetEnt("heart_1", "targetname");
	level.heart_2 = GetEnt("heart_2", "targetname");
	level.heart_2 Hide();
	level.heart_3 = GetEnt("heart_3", "targetname");
	level.heart_3 Hide();

	//models trigs

	level.heart_trig_1 = GetEnt("heart_trig_1", "targetname");
	level.heart_trig_1 SetHintString("Press ^3&&1^7 to pickup the 1st heart");
	level.heart_trig_1 SetCursorHint("HINT_NOICON");

	level.heart_trig_2 = GetEnt("heart_trig_2", "targetname");
	level.heart_trig_2 SetHintString("Press ^3&&1^7 to pickup the 2nd heart");
	level.heart_trig_2 SetCursorHint("HINT_NOICON");
	level.heart_trig_2 Hide();


	level.heart_trig_3 = GetEnt("heart_trig_3", "targetname");
	level.heart_trig_3 SetHintString("Press ^3&&1^7 to pickup the 3rd heart");
	level.heart_trig_3 SetCursorHint("HINT_NOICON");
	level.heart_trig_3 Hide();


	//place models

	level.heart_4 = GetEnt("heart_4", "targetname");
	level.heart_4 Hide();
	level.heart_5 = GetEnt("heart_5", "targetname");
	level.heart_5 Hide();
	level.heart_6 = GetEnt("heart_6", "targetname");
	level.heart_6 Hide();

	//place hearts trig

	level.place_heart_1 = GetEnt("place_heart_1", "targetname");
	level.place_heart_1 SetHintString("missing the 1st heart...");
	level.place_heart_1 SetCursorHint("HINT_NOICON");

	level.place_heart_2 = GetEnt("place_heart_2", "targetname");
	level.place_heart_2 SetHintString("missing the 2 nd heart...");
	level.place_heart_2 SetCursorHint("HINT_NOICON");

	level.place_heart_3 = GetEnt("place_heart_3", "targetname");
	level.place_heart_3 SetHintString("missing the 3rd heart...");
	level.place_heart_3 SetCursorHint("HINT_NOICON");


	//door model and clip

	level.heart_door = GetEnt("heart_door", "targetname");
	level.heart_clip = GetEnt("heart_clip", "targetname");

	thread pickup_heart_1();
	
	

}

function pickup_heart_1()
{
	level.heart_trig_1 waittill("trigger", player);

	level.heart_1 Delete();
	level.heart_trig_1 Delete();

	foreach(model in level.jump_scare_1)
	{
		model Show();
	}

		foreach(player in GetPlayers())
		{	
			player PlaySound("ghost");
			
		}

	thread place_heart_1();


}

function place_heart_1()
{
	level.place_heart_1 SetHintString("Press ^3&&1^7 to place the 1st heart");
	level.place_heart_1 SetCursorHint("HINT_NOICON");

	level.place_heart_1 waittill("trigger", player);

	level.place_heart_1 Delete();

	level.heart_4 Show();

	thread pickup_heart_2();
	


	//level.heart_placed += 1;

}

function pickup_heart_2()
{	
	IPrintLnBold("an heart has appeared...");
	level.heart_2 Show();
	level.heart_trig_2 Show();

	level.heart_trig_2 waittill("trigger", player);

	level.heart_2 Delete();
	level.heart_trig_2 Delete();

	level.jump_scare_2 Show();

		foreach(player in GetPlayers())
		{	
			player PlaySound("scarybaby");
			
		}

	thread place_heart_2();


}

function place_heart_2()
{
	level.place_heart_2 SetHintString("Press ^3&&1^7 to place the 1st heart");
	level.place_heart_2 SetCursorHint("HINT_NOICON");
	

	level.place_heart_2 waittill("trigger", player);


	level.heart_5 Show();
	level.place_heart_2 Delete();

	thread pickup_heart_3();
	


	//level.heart_placed += 1;

}


function pickup_heart_3()
{	
	IPrintLnBold("an heart has appeared...");
	level.heart_3 Show();
	level.heart_trig_3 Show();

	level.heart_trig_3 waittill("trigger", player);

	level.heart_3 Delete();
	level.heart_trig_3 Delete();

		foreach(model in level.jump_scare_3)
	{
		model Show();
	}

		foreach(player in GetPlayers())
		{	
			player PlaySound("monster");
			
		}

	thread place_heart_3();


}

function place_heart_3()
{
	level.place_heart_3 SetHintString("Press ^3&&1^7 to place the 1st heart");
	level.place_heart_3 SetCursorHint("HINT_NOICON");

	level.place_heart_3 waittill("trigger", player);

	level.heart_6 Show();
	level.place_heart_3 Delete();

	thread watch_for_hearts();

	//level.heart_placed += 1;

}


function watch_for_hearts()
{
	//level.heart_placed = 0;

	//while(isdefined(self))
	//{
		//if(level.heart_placed == 3)
		//{
			level.heart_clip Delete();
			level.heart_door Delete();

			IPrintLnBold("the door is open");

			//break;
		//}
		//else
		//{
			//wait(1);
		//}
	//}
}

///////////////////////////////////////////////////////////////////////////
//CORPSE EE
///////////////////////////////////////////////////////////////////////////

function corpsy_init()
{	

	level waittill("initial_blackscreen_passed");
	//corpse 

	level.corpse_talk_1 = GetEnt("corpse_talk_1", "targetname");
	level.corpse_talk_1 SetHintString("Press ^3&&1^7 to help Corpsy...");
	level.corpse_talk_1 SetCursorHint("HINT_NOICON");

	level.corpse_talk_2 = GetEnt("corpse_talk_2", "targetname");
	level.corpse_talk_2 SetHintString("Press ^3&&1^7 to help Corpsy to escape the backrooms...");
	level.corpse_talk_2 SetCursorHint("HINT_NOICON");
	level.corpse_talk_2 Hide();


	level.corpse_talk_3 = GetEnt("corpse_talk_3", "targetname");
	level.corpse_talk_3 SetHintString("Press ^3&&1^7 to talk with Corpsy");
	level.corpse_talk_3 SetCursorHint("HINT_NOICON");
	level.corpse_talk_3 Hide();

	level.corpse_1 = GetEnt("corpse_1", "targetname");

	level.corpsy_1 = GetEnt("corpsy_1", "targetname");
	level.corpsy_1 Hide();

	level.corpsy_2 = GetEnt("corpsy_2", "targetname");
	level.corpsy_2 Hide();

	level.corpse_2 = GetEntArray("corpse_2", "targetname");

	thread corpsy_ee();

}


function corpsy_ee()
{
	level.corpse_talk_1 waittill("trigger", player);

			foreach(model in level.corpse_2)
	{
		model Delete();
	}

	IPrintLnBold("you helped Corpsy to move...");

	level.corpse_1 Delete();
	level.corpse_talk_1 Delete();

	level.corpsy_1 Show();

	thread corpsy_ee_2();


}

function corpsy_ee_2()
{	
	level.corpse_talk_2 Show();
	level.corpse_talk_2 waittill("trigger", player);

	level.corpsy_1 Delete();
	level.corpse_talk_2 Delete();

	IPrintLnBold("you helped corpsy to escape the backrooms...");


	level.corpsy_2 Show();
	level.corpse_talk_3 Show();


	thread corpsy_ee_3();

}

function corpsy_ee_3()
{
	level.corpse_talk_3 waittill("trigger", player);

	level.corpse_talk_3 Delete();

	IPrintLnBold("Corpsy is grateful to you for helping him !");

	wait(1);

	foreach(player in GetPlayers())
	{
		player.score += 10000;
	}

	IPrintLnBold("all players get 10k points !");


}


///////////////////////////////////////////////////////////
////RADIO EE
///////////////////////////

function radio_ee()
{	
	level waittill("initial_blackscreen_passed");


	level.radio_1 = GetEnt("radio_1", "targetname");
	level.radio_1 Hide();
	level.radio_2 = GetEnt("radio_2", "targetname");
	level.radio_3 = GetEnt("radio_3", "targetname");
	level.radio_4 = GetEnt("radio_4", "targetname");
	level.radio_5 = GetEnt("radio_5", "targetname");
	level.radio_6 = GetEnt("radio_6", "targetname");

	wait(30);

		foreach(player in GetPlayers())
	{
		player PlaySound("arrival1");

	}

	wait(15);

	thread radio_1();
	thread radio_2();
	thread radio_3();
	thread radio_4();
	thread radio_5();
	thread radio_6();

}

function radio_1()
{	
	level.radio_1 Show();

	level.radio_1 waittill("trigger", player);

	level.radio_1 Delete();

	foreach(player in GetPlayers())
	{
		player PlaySound("radio_1");

		player.score += 500;
	}

	IPrintLnBold("lost message + 500 points");

	wait(35);

			foreach(player in GetPlayers())
	{
		player PlaySound("1radio");

	}
}

function radio_2()
{
	level.radio_2 waittill("trigger", player);

	level.radio_2 Delete();

	foreach(player in GetPlayers())
	{
		player PlaySound("radio_2");

		player.score += 500;
	}

	IPrintLnBold("lost message + 500 points");
}

function radio_3()
{
	level.radio_3 waittill("trigger", player);

	level.radio_3 Delete();

	foreach(player in GetPlayers())
	{
		player PlaySound("radio_3");

		player.score += 500;

		
	}

	IPrintLnBold("lost message + 500 points");
}

function radio_4()
{
	level.radio_4 waittill("trigger", player);

	level.radio_4 Delete();

	foreach(player in GetPlayers())
	{
		player PlaySound("radio_4");

		player.score += 500;

		
	}

	IPrintLnBold("lost message + 500 points");
}


function radio_5()
{
	level.radio_5 waittill("trigger", player);

	level.radio_5 Delete();

	foreach(player in GetPlayers())
	{
		player PlaySound("radio_5");

		player.score += 500;

		
	}

	IPrintLnBold("lost message + 500 points");
}

function radio_6()
{
	level.radio_6 waittill("trigger", player);

	level.radio_6 Delete();

	foreach(player in GetPlayers())
	{
		player PlaySound("radio_6");

		player.score += 500;

		
	}

	IPrintLnBold("lost message + 500 points");
}



///////////////////////////////////////
//floor is lava

function floor_is_lava()
{

	level waittill("initial_blackscreen_passed");

	level.floor_is_lava = GetEntArray("floor_is_lava", "targetname");

	level.floor_on = GetEnt("floor_on", "targetname");
	level.floor_on SetHintString("Press ^3&&1^7 to start floor is lava...");
	level.floor_on SetCursorHint("HINT_NOICON");

	level.floor_off = GetEnt("floor_off", "targetname");
	level.floor_off SetHintString("Press ^3&&1^7 to end floor is lava...");
	level.floor_off SetCursorHint("HINT_NOICON");
	level.floor_off Hide();

	thread launch_floor_is_lava();

}

function launch_floor_is_lava()
{
	level.floor_on waittill("trigger", player);

	IPrintLnBold("FLOOR IS LAVA !");

	foreach(brushmodel in level.floor_is_lava)
	{
		brushmodel MoveZ(-14,1);
	}

	wait(3);

	thread end_floor_is_lava();
}

function end_floor_is_lava()
{
	level.floor_off Show();

	level.floor_off waittill("trigger", player);

	foreach(brushmodel in level.floor_is_lava)
	{
		brushmodel MoveZ(14,1);
	}

	level.floor_off Hide();
	level.floor_on Show();

	wait(1);

	thread launch_floor_is_lava();

}

///////////////////////////////////////////////////////////////////////
//////////////////////////QUEST 2 ENDING

function quest_2_ending()
{
	level waittill("initial_blackscreen_passed");


	///ORB 1

	level.orb_1 = GetEnt("orb_1", "targetname");
	level.pickup_orb_1 = GetEnt("pickup_orb_1", "targetname");
	level.pickup_orb_1 SetHintString("Press ^3&&1^7 to pickup the 1st orb");
	level.pickup_orb_1 SetCursorHint("HINT_NOICON");

	exploder::exploder("pickup_orb_1");

	level.placed_orb_1 = GetEnt("placed_orb_1", "targetname");
	level.placed_orb_1 Hide();

	level.place_orb_1 = GetEnt("place_orb_1", "targetname");
	level.place_orb_1 SetHintString("Missing the 1st orb... (optional)");
	level.place_orb_1 SetCursorHint("HINT_NOICON");


	///ORB 2

	level.statue = GetEnt("statue", "targetname");
	level.statue_clip = GetEnt("statue_clip", "targetname");

	level.orb_2 = GetEnt("orb_2", "targetname");
	level.orb_2 Hide();

	level.pickup_orb_2 = GetEnt("pickup_orb_2", "targetname");
	level.pickup_orb_2 SetHintString("Press ^3&&1^7 to pickup the 2nd orb");
	level.pickup_orb_2 SetCursorHint("HINT_NOICON");
	level.pickup_orb_2 Hide();

	level.placed_orb_2 = GetEnt("placed_orb_2", "targetname");
	level.placed_orb_2 Hide();

	level.place_orb_2 = GetEnt("place_orb_2", "targetname");
	level.place_orb_2 SetHintString("Missing the 2nd orb... (optional)");
	level.place_orb_2 SetCursorHint("HINT_NOICON");

	///ORB 3

	level.rock = GetEntArray("rock", "targetname");
	foreach(model in level.rock)
	{
		model Hide();
	}
	
	level.clip_rock = GetEntArray("clip_rock", "targetname");
	foreach(brushmodel in level.clip_rock)
	{
		brushmodel Hide();
	}
	


	level.orb_3 = GetEnt("orb_3", "targetname");
	
	level.pickup_orb_3 = GetEnt("pickup_orb_3", "targetname");
	level.pickup_orb_3 SetHintString("Press ^3&&1^7 to pickup the 3rd orb");
	level.pickup_orb_3 SetCursorHint("HINT_NOICON");

	exploder::exploder("pickup_orb_3");

	level.placed_orb_3 = GetEnt("placed_orb_3", "targetname");
	level.placed_orb_3 Hide();

	level.place_orb_3 = GetEnt("place_orb_3", "targetname");
	level.place_orb_3 SetHintString("Missing the 3rd orb...(optional)");
	level.place_orb_3 SetCursorHint("HINT_NOICON");

	///ORB 4

	level.orb_4 = GetEnt("orb_4", "targetname");

	level.pickup_orb_4 = GetEnt("pickup_orb_4", "targetname");
	level.pickup_orb_4 SetHintString("Press ^3&&1^7 to pickup the 4th orb");
	level.pickup_orb_4 SetCursorHint("HINT_NOICON");

	exploder::exploder("pickup_orb_4");

	level.placed_orb_4 = GetEnt("placed_orb_4", "targetname");
	level.placed_orb_4 Hide();

	level.place_orb_4 = GetEnt("place_orb_4", "targetname");
	level.place_orb_4 SetHintString("Missing the 4th orb...(optional)");
	level.place_orb_4 SetCursorHint("HINT_NOICON");

	///ORB END

	level.big_orb = GetEnt("big_orb", "targetname");
	level.big_orb Hide();

	level.orb_ray = GetEnt("orb_ray", "targetname");
	level.orb_ray Hide();

	level.rune_ray = GetEnt("rune_ray", "targetname");
	level.rune_ray Hide();

	level.rune_ray_off = GetEnt("rune_ray_off", "targetname");

	level.ray_pillar = GetEnt("ray_pillar", "targetname");


	thread watch_for_orb();
	thread pickup_orb_1();
	thread step_orb_2();
	thread step_orb_3();
	thread pickup_orb_3();
	thread step_orb_4();
	thread pickup_orb_4();



}



function watch_for_orb()
{

	level.orb_placed = 0;

	while(isdefined(self))
	{
		if(level.orb_placed == 4)
		{	
			
			level.activate_fight Delete();

			IPrintLnBold("the 1st ending has been locked");
			thread end_orbs();
			break;
		}
		else
		{
			wait(1);
		}
	}


}



function pickup_orb_1()
{
	level.pickup_orb_1 waittill("trigger", player);

	level.orb_1 Delete();
	level.pickup_orb_1 Delete();

	exploder::kill_exploder("pickup_orb_1");

	IPrintLnBold("you get the 1st orb !");

	thread place_orb_1();


}

function place_orb_1()
{
	level.place_orb_1 SetHintString("Press ^3&&1^7 to place the 1st orb (optional)");
	level.place_orb_1 SetCursorHint("HINT_NOICON");

	level.place_orb_1 waittill("trigger", player);

	level.placed_orb_1 Show();

	
	foreach(player in GetPlayers())
		{
			player PlaySound("skull");
		}

	level.place_orb_1 Delete();
	exploder::exploder("placed_orb_1");

	level.orb_placed += 1;


}

function step_orb_2()
{

	level.gong = GetEntArray("gong", "targetname");

	level.gong_model = GetEntArray("gong_model", "targetname");

	foreach(trig in level.gong)
	{
		thread gong(trig);
	}

	thread watch_for_gong();

}

function gong(trig)
{
	trig.gong = ArrayGetClosest(trig.origin, level.gong_model);

	trig waittill("trigger", player);

	foreach(player in GetPlayers())
		{
			player PlaySound("gong");
		}
	

	trig Delete();

	level.gong_song += 1;

}

function watch_for_gong()
{
	level.gong_song = 0;

	while(isdefined(self))
	{
		if(level.gong_song == 5)
		{	
			level.statue MoveZ(300,3);
			level.statue_clip MoveZ(300,3);
			foreach(player in GetPlayers())
			{
				player PlaySound("movingrock");
			}
			

			thread pickup_orb_2();
			break;
		}
		else
		{
			wait(1);
		}
	}
}

function pickup_orb_2()
{	
	wait(3);

	level.orb_2 Show();
	exploder::exploder("pickup_orb_2");
	level.pickup_orb_2 Show();
	

	level.pickup_orb_2 waittill("trigger", player);

	level.orb_2 Delete();
	level.pickup_orb_2 Delete();
	exploder::kill_exploder("pickup_orb_2");

	IPrintLnBold("You get the 2nd orb !");

	thread place_orb_2();
	
}

function place_orb_2()
{
	level.place_orb_2 SetHintString("Press ^3&&1^7 to place the 2nd orb (optional)");
	level.place_orb_2 SetCursorHint("HINT_NOICON");

	level.place_orb_2 waittill("trigger", player);

	level.placed_orb_2 Show();

	foreach(player in GetPlayers())
		{
			player PlaySound("skull");
		}
	

	level.place_orb_2 Delete();
	exploder::exploder("placed_orb_2");

	level.orb_placed += 1;
}

function step_orb_3()
{
	level.lever_rock = GetEnt("lever_rock", "targetname");
	level.lever_rock SetHintString("Press ^3&&1^7 to reveal the path");
	level.lever_rock SetCursorHint("HINT_NOICON");

	level.lever_rock waittill("trigger", player);

	foreach(model in level.rock)
	{
		model Show();
	}
	foreach(brushmodel in level.clip_rock)
	{
		brushmodel Show();
	}

	level.lever_rock Hide();

	wait(20);

	thread step_orb_3_failed();

}

function step_orb_3_failed()
{

	foreach(model in level.rock)
	{
		model Hide();
	}
	foreach(brushmodel in level.clip_rock)
	{
		brushmodel Hide();
	}

	level.lever_rock Show();

	thread step_orb_3();
}

function pickup_orb_3()
{

	level.pickup_orb_3 waittill("trigger", player);

	level.orb_3 Delete();
	exploder::kill_exploder("pickup_orb_3");
	level.pickup_orb_3 Delete();

	foreach(model in level.rock)
	{
		model Delete();
	}
	foreach(brushmodel in level.clip_rock)
	{
		brushmodel Delete();
	}

	level.lever_rock Delete();

	IPrintLnBold("you get the 3rd orb !");

	thread place_orb_3();
}

function place_orb_3()
{
	level.place_orb_3 SetHintString("Press ^3&&1^7 to place the 3rd orb (optional)");
	level.place_orb_3 SetCursorHint("HINT_NOICON");

	level.place_orb_3 waittill("trigger", player);

	level.placed_orb_3 Show();

		foreach(player in GetPlayers())
		{
			player PlaySound("skull");
		}
	

	exploder::exploder("placed_orb_3");
	level.place_orb_3 Delete();


	level.orb_placed += 1;

}

function step_orb_4()
{
	level.lever_orb_4 = GetEnt("lever_orb_4", "targetname");
	level.lever_orb_4 SetHintString("Press ^3&&1^7 to open the jump pad");
	level.lever_orb_4 SetCursorHint("HINT_NOICON");

	level.clip_orb_4 = GetEnt("clip_orb_4", "targetname");
	level.cage_orb = GetEnt("cage_orb", "targetname");

	level.lever_orb_4 waittill("trigger", player);



	foreach(player in GetPlayers())
		{
			player PlaySound("caniup");
		}
	

	level.clip_orb_4 Delete();
	level.cage_orb MoveZ(-300,3);

	wait(3);

	
	level.cage_orb Delete();

	level.lever_orb_4 Delete();

}

function pickup_orb_4()
{
	level.pickup_orb_4 waittill("trigger", player);

	level.orb_4 Delete();

	exploder::kill_exploder("pickup_orb_4");
	level.pickup_orb_4 Delete();

	IPrintLnBold("you get the 4th orb !");

	thread place_orb_4();
}

function place_orb_4()
{	
	level.place_orb_4 SetHintString("Press ^3&&1^7 to place the 4th orb (optional)");
	level.place_orb_4 SetCursorHint("HINT_NOICON");

	level.place_orb_4 waittill("trigger", player);

	level.placed_orb_4 Show();
	exploder::exploder("placed_orb_4");

	foreach(player in GetPlayers())
		{
			player PlaySound("skull");
		}
	

	level.place_orb_4 Delete();

	level.orb_placed += 1;
}

function end_orbs()
{	
	level.activate_fight MoveZ(-1000,3);
	
	level.big_orb Show();
	exploder::exploder("big_orb");
	foreach(player in GetPlayers())
		{
			player PlaySound("thunder");
		}
	

	wait(3);

	foreach(player in GetPlayers())
		{
			player PlaySound("alien_portal");
		}
	
	level.orb_ray Show();
	level.rune_ray Show();


	level.rune_ray_off Delete();

	wait(1);

	foreach(player in GetPlayers())
		{
			player PlaySound("caniup");
		}
	
	level.ray_pillar MoveZ(-400,3);

	foreach(player in GetPlayers())
	{
		player PlaySound("badplan");
	}



}

//////////////////////////////////////////////
//CRASH SHIP

function crashing_ship_function()
{
	level waittill("initial_blackscreen_passed");

	level.crash_ship_trig = GetEnt("crash_ship_trig", "targetname");
	level.crash_ship_trig SetHintString("Press ^3&&1^7 to launch the 2nd ending");
	level.crash_ship_trig SetCursorHint("HINT_NOICON");

	level.crash_ship_model = GetEnt("crash_ship_model", "targetname");

	level.crash_ship_clip = GetEnt("crash_ship_clip", "targetname");

	level.crashing_ship = GetEnt("crashing_ship", "targetname");

	thread launch_end_2();
}

function launch_end_2()
{	

	crash = (0,-3741,-1564.8);

	level.crash_ship_trig waittill("trigger", player);

	level.crash_ship_model Delete();
	level.crash_ship_trig Delete();

	foreach(player in GetPlayers())
	{
		player PlaySound("lost");
	}

	wait(12);

	foreach(player in GetPlayers())
	{
		player PlaySound("crash");
	}

	level.crashing_ship MoveTo(crash,8);


	wait(6);

	level.crashing_ship Delete();

	level.crash_ship_clip Delete();

	IPrintLnBold("Build a distress beacon 0/3");



}

function build_signal()
{	

	level waittill("initial_blackscreen_passed");

	//PICKUP MODELS AND TRIGS
	level.balise_4 = GetEnt("balise_4", "targetname");

	exploder::exploder("balise_4");

	level.pickup_balise_4 = GetEnt("pickup_balise_4", "targetname");
	level.pickup_balise_4 SetHintString("Press ^3&&1^7 to pickup the 1st part");
	level.pickup_balise_4 SetCursorHint("HINT_NOICON");

	level.balise_5 = GetEnt("balise_5", "targetname");

	exploder::exploder("balise_5");

	level.pickup_balise_5 = GetEnt("pickup_balise_5", "targetname");
	level.pickup_balise_5 SetHintString("Press ^3&&1^7 to pickup the 2st part");
	level.pickup_balise_5 SetCursorHint("HINT_NOICON");

	level.balise_6 = GetEnt("balise_6", "targetname");

	exploder::exploder("balise_6");

	level.pickup_balise_6 = GetEnt("pickup_balise_6", "targetname");
	level.pickup_balise_6 SetHintString("Press ^3&&1^7 to pickup the 3rd part");
	level.pickup_balise_6 SetCursorHint("HINT_NOICON");

	//PLACE MODELS AND TRIGS

	level.balise_1 = GetEnt("balise_1", "targetname");
	level.balise_1 Hide();

	level.balise_2 = GetEnt("balise_2", "targetname");
	level.balise_2 Hide();

	level.balise_3 = GetEnt("balise_3", "targetname");
	level.balise_3 Hide();

	level.place_balise = GetEnt("place_balise", "targetname");
	level.place_balise SetHintString("MISSING PARTS...");
	level.place_balise SetCursorHint("HINT_NOICON");
	

	//ATTACKABLE SHIELD



	//1st defense
	level.on_1 = GetEnt("on_1", "targetname");
	level.on_1 SetHintString("All Players Must Be Nearby");
	level.on_1 SetCursorHint("HINT_NOICON");
	level.on_1 Hide();

	level.info_1 = GetEnt("info_1", "targetname");
	level.info_1 SetHintString("All Players Must Be Nearby");
	level.info_1 SetCursorHint("HINT_NOICON");
	level.info_1 Hide();



	level.def_1 = GetEntArray("def_1", "targetname");
	foreach (clip in level.def_1)
	{
		clip Hide();
	}

	// 2nd defense

	level.on_2 = GetEnt("on_2", "targetname");
	level.on_2 SetHintString("All Players Must Be Nearby");
	level.on_2 SetCursorHint("HINT_NOICON");
	level.on_2 Hide();

	level.info_2 = GetEnt("info_2", "targetname");
	level.info_2 SetHintString("All Players Must Be Nearby");
	level.info_2 SetCursorHint("HINT_NOICON");
	level.info_2 Hide();

	level.def_2 = GetEntArray("def_2", "targetname");
	foreach (clip in level.def_2)
	{
		clip Hide();
	}

// 3rd defense

	level.on_3 = GetEnt("on_3", "targetname");
	level.on_3 SetHintString("All Players Must Be Nearby");
	level.on_3 SetCursorHint("HINT_NOICON");
	level.on_3 Hide();

	level.info_3 = GetEnt("info_3", "targetname");
	level.info_3 SetHintString("All Players Must Be Nearby");
	level.info_3 SetCursorHint("HINT_NOICON");
	level.info_3 Hide();

	level.def_3 = GetEntArray("def_3", "targetname");
	foreach (clip in level.def_3)
	{
		clip Hide();
	}

// radio door

	level.radio_door = GetEnt("radio_door", "targetname");

	level.sos = GetEnt("sos", "targetname");
	level.sos SetHintString("Press ^3&&1^7 to use the beacon");
	level.sos SetCursorHint("HINT_NOICON");


	//level.extraction = GetEnt("extraction", "targetname");
	//level.extraction SetHintString("exfiltrate");
	//level.extraction SetCursorHint("HINT_NOICON");
	//level.extraction Hide();

	level.ex_ship = GetEntArray("ex_ship", "targetname");
	foreach(clip in level.ex_ship)
	{
		clip Hide();
	}

	level.extraction_ship = GetEnt("extraction_ship", "targetname");
	level.extraction_ship Hide();

	level.trig = GetEnt( "end_game_trig_2", "targetname" );
	level.trig SetCursorHint( "HINT_NOICON" );
	level.trig Hide();

	////end

	level.trig_end = GetEnt("trigend", "targetname");
	level.trig_end  SetHintString("All Players Must Be Nearby");
	level.trig_end  SetCursorHint("HINT_NOICON");

	level.trig_end Hide();

	level.end_ship_trig = GetEnt("end_ship_trig", "targetname");
	level.end_ship_trig  SetHintString("All Players Must Be Nearby");
	level.end_ship_trig  SetCursorHint("HINT_NOICON");

	level.end_ship_trig Hide();


	//light

	level.light_1 = GetEnt("light_1", "targetname");
	level.light_1 Hide();

	level.light_2 = GetEnt("light_2", "targetname");
	level.light_2 Hide();

	level.light_3 = GetEnt("light_3", "targetname");
	level.light_3 Hide();


	


	thread pickup_balise_4();
	thread pickup_balise_5();
	thread pickup_balise_6();
	thread watch_for_balise();

}

function watch_for_balise()
{
	level.balise_part = 0;

	while(isDefined(self))
	{
		if(level.balise_part == 3)
		{	
			IPrintLnBold("distress beacon 3/3");
			thread place_balise();
			break;
		}
		else
		{
			wait(1);
		}
	}
}

function pickup_balise_4()
{
	level.pickup_balise_4 waittill("trigger", player);

	level.balise_4 Delete();
	level.pickup_balise_4 Delete();
	exploder::kill_exploder("balise_4");

	IPrintLnBold("1st part has been found");

	level.balise_part += 1;

}

function pickup_balise_5()
{
	level.pickup_balise_5 waittill("trigger", player);

	level.balise_5 Delete();
	level.pickup_balise_5 Delete();
	exploder::kill_exploder("balise_5");

	IPrintLnBold("2nd part has been found");

	level.balise_part += 1;
}

function pickup_balise_6()
{
	level.pickup_balise_6 waittill("trigger", player);

	level.balise_6 Delete();
	level.pickup_balise_6 Delete();
	exploder::kill_exploder("balise_6");

	IPrintLnBold("the 3rd part has been found");

	level.balise_part += 1;
}

function place_balise()
{	
	IPrintLnBold("place the beacon on the plateform.");

	level.place_balise SetHintString("Press ^3&&1^7 to place the distress beacon");
	level.place_balise SetCursorHint("HINT_NOICON");

	level.place_balise waittill("trigger", player);

	level.balise_1 Show();
	level.balise_2 Show();
	level.balise_3 Show();

	level.place_balise Delete();

	wait(1);

	IPrintLnBold("The distress beacon need energy...");

	

	


	thread timed_gameplay();
	thread protector_1();


}


////////////////////////////////
//PROTECTOR 1

function protector_1()
{	
	IPrintLnBold("find a way to activate the first generator...");
	level.on_1 Show();
	level.info_1 Show();

	level.on_1 waittill("trigger", player);



	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	thread defense_1();

}



function defense_1()
{
	foreach (clip in level.def_1)
	{
		clip Show();
	}

	level.on_1 Delete();
	level.info_1 Delete();

	wait(30);

	foreach(player in GetPlayers())
	{
		player PlaySound("zmb_build_completed");
	}

	foreach (clip in level.def_1)
	{
		clip Delete();
	}

	level.light_1 Show();

	IPrintLnBold("find the 2nd generator");

	thread protector_2();

}


////////////////////////////////
//PROTECTOR 2


function protector_2()
{

	level.on_2 Show();

	level.info_2 SetHintString("All Players Must Be Nearby");
	level.info_2 SetCursorHint("HINT_NOICON");
	level.info_2 Show();


	level.on_2 waittill("trigger", player);

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	thread defense_2();


}

function defense_2()
{
	foreach (clip in level.def_2)
	{
		clip Show();
	}

	level.on_2 Delete();

	level.info_2 Delete();

	wait(30);

	foreach(player in GetPlayers())
	{
		player PlaySound("zmb_build_completed");
	}

	foreach (clip in level.def_2)
	{
		clip Delete();
	}

	level.light_2 Show();

	IPrintLnBold("find the 3rd generator");

	thread protector_3();

}

////////////////////////////////
//PROTECTOR 3


function protector_3()
{

	level.on_3 Show();
	level.info_3 SetHintString("All Players Must Be Nearby");
	level.info_3 SetCursorHint("HINT_NOICON");
	level.info_3 Show();

	level.on_3 waittill("trigger", player);

	foreach(player in GetPlayers())
	{
		player PlaySound("skull");
	}

	thread defense_3();


}

function defense_3()
{
	foreach (clip in level.def_3)
	{
		clip Show();
	}

	level.on_3 Delete();

	level.info_3 Delete();

	wait(30);

	foreach(player in GetPlayers())
	{
		player PlaySound("zmb_build_completed");
	}

	foreach (clip in level.def_3)
	{
		clip Delete();
	}

	level.light_3 Show();

	thread beacon_open();

}

function beacon_open()
{	

	IPrintLnBold("the bunker is open");

	foreach(player in GetPlayers())
	{
		player PlaySound("caniup");
	}

	level.radio_door MoveY(-89.5,3);



	level.sos waittill("trigger", player);

	level.sos Delete();

	IPrintLnBold("extraction ship will come in 5 mins");

	foreach(player in GetPlayers())
	{
		player PlaySound("extraction");
	}


	wait(300);

	

	thread rescue();


}

function rescue()
{	

	foreach(player in GetPlayers())
	{
		player PlaySound("landing");
	}


	level.extraction_ship Show();
	level.extraction_ship MoveZ(-2000,6,1,1);

	wait(6);

	foreach(clip in level.ex_ship)
	{
		clip Show();
	}

	thread func_end();


}

function func_end()
{
	level.end_ship_trig Show();
	level.trig_end Show();

	level.trig_end  waittill("trigger", player);

	level.trig_end Delete();

	level notify("end_game");

	thread end_the_game();
}


function end_the_game()
{	
	
	thread step_end( " ^1MISSION ACCOMPLISHED ! THANKS FOR PLAYING !", 225, 185, 2.5, 5 );
    
}
 
function step_end( text, align_x, align_y, font_scale, fade_time )
{
    hud = NewHudElem();
    hud.foreground = true;
    hud.fontScale = font_scale;
    hud.sort = 1;
    hud.hidewheninmenu = false;
    hud.alignX = "left";
    hud.alignY = "bottom";
    hud.horzAlign = "left";
    hud.vertAlign = "bottom";
    hud.x = align_x;
    hud.y = hud.y - align_y;
    hud.alpha = 1;
    hud SetText( text );
   
   
}

///(from here)
/////////////////////////////////////////////////////////////////////////////
///////TEDDYS EE


//here is the function to init the teddys models and teddys trigs

function teddys_ee()
{	

	level.portal_p = GetEnt("portal_p", "targetname");

	level.teddys_models = GetEntArray("teddys", "targetname");
	level.teddys_trig = GetEntArray("teddys_trig", "targetname");
	foreach(trig in level.teddys_trig)
	{
		thread teddys_trig(trig);
	}

	thread watch_for_teddys();


}


//this is the function to watch if all teddys have been shooted (if they are, it will thread the next part of the ee)

function watch_for_teddys()
{
	level.teddys_shooted = 0;

	while(isdefined(self))
	{
		if(level.teddys_shooted == 3)
		{	
			IPrintLnBold("All teddys have been shoot !");
			thread portal_p();
			break;
		}
		else
		{
			wait(1);
		}
	}
}


//this is the function for each trigs of the teddys 

function teddys_trig(trig)
{
	trig.teddy_model = ArrayGetClosest(trig.origin, level.teddys_models);

	trig waittill("trigger", player);

	playfx( level._effect["powerup_grabbed"], trig.origin);

	level.teddys_shooted += 1;

	trig.teddy_model Delete();

	trig Delete();
}

/////////////////////////////////////////////////
//(to here)

function portal_p()
{
	
	
	level.portal_p Delete();
	
}



