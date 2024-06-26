#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\throttle_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\vehicles\_glaive;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_hero_weapon;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_lightning_chain;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_tesla;
#using scripts\zm\_zm_weapons;
#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#namespace zm_weap_glaive;

#precache( "fx", "impacts/fx_flesh_hit_knife_lg_zmb" );

REGISTER_SYSTEM_EX( "zm_weap_glaive", &__init__, undefined, undefined )

function __init__()
{
	clientfield::register( "allplayers", "slam_fx", VERSION_SHIP, 1, "counter" );
	clientfield::register( "toplayer", "throw_fx", VERSION_SHIP, 1, "counter" );
	clientfield::register( "toplayer", "swipe_fx", VERSION_SHIP, 1, "counter" );
	clientfield::register( "toplayer", "swipe_lv2_fx", VERSION_SHIP, 1, "counter" );
	clientfield::register( "actor", "zombie_slice_r", VERSION_SHIP, 2, "counter" );
	clientfield::register( "actor", "zombie_slice_l", VERSION_SHIP, 2, "counter" );
	level._effect[ "glaive_blood_spurt" ] = "impacts/fx_flesh_hit_knife_lg_zmb";
	level.glaive_excalibur_aoe_range = 240;
	level.glaive_excalibur_aoe_range_sq = level.glaive_excalibur_aoe_range * level.glaive_excalibur_aoe_range;
	level.glaive_excalibur_cone_range = 100;
	level.glaive_excalibur_cone_range_sq = level.glaive_excalibur_cone_range * level.glaive_excalibur_cone_range;
	level.glaive_chop_cone_range = 120;
	level.glaive_chop_cone_range_sq = level.glaive_chop_cone_range * level.glaive_chop_cone_range;
	level.glaive_chop_cone_lrg_range = 160;
	level.glaive_chop_cone_lrg_range_sq = level.glaive_chop_cone_lrg_range * level.glaive_chop_cone_lrg_range;
	callback::on_connect( &watch_sword_equipped );
	for ( i = 0; i < 4; i++ )
	{
		zombie_utility::add_zombie_gib_weapon_callback( ( "glaive_apothicon" + "_" ) + i, &gib_check, &gib_head_check );
		zombie_utility::add_zombie_gib_weapon_callback(( "glaive_keeper" + "_" ) + i, &gib_check, &gib_head_check );
		zm_hero_weapon::register_hero_weapon( ( "glaive_apothicon" + "_" ) + i );
		zm_hero_weapon::register_hero_weapon(( "glaive_keeper" + "_" ) + i );
		zm_hero_weapon::register_hero_recharge_event( getWeapon( ( "glaive_apothicon" + "_" ) + i ), &sword_power_override );
		zm_hero_weapon::register_hero_recharge_event( getWeapon( ( "glaive_keeper" + "_" ) + i ), &sword_power_override );
	}
	level.glaive_damage_locations = array( "left_arm_upper", "left_arm_lower", "left_hand", "right_arm_upper", "right_arm_lower", "right_hand" );
	object = new throttle();
	[ [ object ] ]->__constructor();
	level.ai_sword_chop_throttle = object;
	[ [ level.ai_sword_chop_throttle ] ]->initialize( 6, .1 );
}

function get_correct_sword_for_player_character_at_level( n_upgrade_level )
{
	str_wpnname = undefined;
	if ( n_upgrade_level == 1 )
		str_wpnname = "glaive_apothicon";
	else
		str_wpnname = "glaive_keeper";
	
	str_wpnname = ( str_wpnname + "_" ) + self.characterindex;
	wpn = getWeapon( str_wpnname );
	return wpn;
}

function watch_sword_unwield( wpn_original )
{
	self endon( "sword_attack_watchers_end" );
	while ( isDefined( self ) )
	{
		self waittill( "weapon_change", wpn_cur, wpn_prev );
		if ( wpn_cur != level.weaponnone && wpn_cur != wpn_original )
		{
			self.usingsword = 0;
			if ( self.autokill_glaive_active )
			{
				self enableOffhandWeapons();
				self thread unwield_sword( wpn_original );
				self waittill( "sword_drop_complete" );
			}
			self disabled_sword();
			self notify("sword_attack_watchers_end");
			return;
		}
	}
}

function unwield_sword( wpn_prev )
{
	self endon( "sword_drop_complete" );
	oldtime = getTime();
	while ( isDefined( self ) && IS_TRUE( self.autokill_glaive_active ) )
	{
		rate = 1.667;
		if ( isDefined( wpn_prev.gadget_power_usage_rate ) )
			rate = wpn_prev.gadget_power_usage_rate;
		
		self.sword_power = self.sword_power - ( .0005 * rate );
		self gadgetPowerSet( 0, self.sword_power * 100 );
		wait .05;
	}
}

function player_sword_rumble( evt )
{
	self playRumbleOnEntity( "lightninggun_charge" );
}

function watch_sword_enabled( wpn_excalibur, wpn_autokill, wpn_cur, wpn_prev )
{
	if ( self.sword_allowed && !self.usingsword )
	{
		if ( wpn_cur == wpn_autokill )
		{
			self thread zm_equipment::show_hint_text( "Press ^3[{+ability}]^7 to Wield Sword.", 2 );
			self thread watch_for_loss( wpn_autokill );
			self.current_sword = wpn_autokill;
			self.current_sword_level = 0;
			self disableOffhandWeapons();
			self notify( "altbody_end" );
			self thread watch_sword_unwield( wpn_cur );
			if ( !IS_TRUE( self.usingsword ) )
			{
				self gadgetPowerSet( 0, 100 );
				self clientfield::set_player_uimodel( "zmhud.swordEnergy", 1 );
				self clientfield::set_player_uimodel( "zmhud.swordState", 2 );
				self.sword_power = 1;
			}
			self notify( "sword_attack_watchers_start" );
			self thread player_sword_rumble( "lv2start" );
			self.usingsword = 1;
			self.autokill_glaive_active = 0;
			slot = self gadgetGetSlot( wpn_autokill );
			self thread sword_power_hud( slot );
			self thread sword_attack_watcher( wpn_cur, 1 );
			self thread autokill_think( wpn_autokill );
			self waittill( "sword_attack_watchers_end" );
			self enableOffhandWeapons();
			self allowMeleePowerLeft( 1 );
			self.usingsword = 0;
			self disabled_sword();
		}
		else if ( wpn_cur == wpn_excalibur )
		{
			self thread zm_equipment::show_hint_text( "Press ^3[{+ability}]^7 to Wield Sword.", 2 );
			self.current_sword = wpn_excalibur;
			self.current_sword_level = 1;
			self disableOffhandWeapons();
			self notify( "altbody_end" );
			self thread watch_sword_unwield( wpn_cur );
			if ( !IS_TRUE( self.usingsword ) )
			{
				self gadgetPowerSet( 0, 100 );
				self clientfield::set_player_uimodel( "zmhud.swordEnergy", 1 );
				self clientfield::set_player_uimodel( "zmhud.swordState", 6 );
				self.sword_power = 1;
			}
			self notify( "sword_attack_watchers_start" );
			self thread player_sword_rumble( "lv1start" );
			self.usingsword = 1;
			self.autokill_glaive_active = 0;
			slot = self gadgetGetSlot( wpn_excalibur );
			self thread sword_power_hud( slot );
			self thread sword_attack_watcher( wpn_excalibur, 0 );
			self thread excalibur_think( wpn_excalibur );
			self waittill( "sword_attack_watchers_end" );
			self enableOffhandWeapons();
			self allowMeleePowerLeft( 1 );
			self.usingsword = 0;
			self disabled_sword();
		}
	}
}

function is_glaive( w_weapon )
{
	if ( isSubStr( w_weapon.name, "glaive_keeper" ) )
		return 2;
	
	if ( isSubStr( w_weapon.name, "glaive_apothicon" ) )
		return 1;
	
	return 0;
}

function watch_for_loss( w_weapon )
{
	self endon( "disconnect" );
	while ( self hasWeapon( w_weapon ) )
		WAIT_SERVER_FRAME;
	
	if ( isDefined( self.vh_sword ) && !IS_TRUE( self.vh_sword._glaive_must_return_to_owner ) )
		self.vh_sword._glaive_must_return_to_owner = 1;
	
}

function private watch_sword_equipped()
{
	self endon( "disconnect" );
	wpn_excalibur = self get_correct_sword_for_player_character_at_level( 1 );
	wpn_autokill = self get_correct_sword_for_player_character_at_level( 2 );
	self.sword_allowed = 1;
	self.usingsword = 0;
	while ( 1 )
	{
		self waittill( "weapon_change", wpn_cur, wpn_prev );
		
		if ( is_glaive( wpn_cur ) == 1 )
			wpn_excalibur = wpn_cur;
		
		if ( is_glaive( wpn_cur ) == 2 )
			wpn_autokill = wpn_cur;
		
		self watch_sword_enabled( wpn_excalibur, wpn_autokill, wpn_cur, wpn_prev );
	}
}

function private gib_check( damage_percent )
{
	self.override_damagelocation = "none";
	if ( damage_percent > 99.8 )
	{
		self.override_damagelocation = "neck";
		return 1;
	}
	return 0;
}

function private gib_head_check( damage_location )
{
	if ( self.override_damagelocation === "neck" )
		return 1;
	
	if ( !isDefined( damage_location ) )
		return 0;
	
	if ( damage_location == "head" )
		return 1;
	
	if ( damage_location == "helmet" )
		return 1;
	
	if ( damage_location == "neck" )
		return 1;
	
	return 0;
}

function private excalibur_think( wpn_excalibur )
{
	self endon( "sword_attack_watchers_end" );
	self endon( "disconnect" );
	self endon( "bled_out" );
	while ( 1 )
	{
		self waittill( "weapon_melee_power_left", weapon );
		if ( weapon == wpn_excalibur )
		{
			self clientfield::increment( "slam_fx" );
			self thread do_excalibur( wpn_excalibur );
		}
	}
}

function private do_excalibur(wpn_excalibur)
{
	view_pos = self getWeaponMuzzlePoint();
	forward_view_angles = self getWeaponForwardDir();
	zombie_list = getAiTeamArray( level.zombie_team );
	foreach ( key, ai in zombie_list )
	{
		if ( !isDefined( ai ) || !isAlive( ai ) )
			continue;
		
		test_origin = ai getCentroid();
		dist_sq = distanceSquared( view_pos, test_origin );
		if ( dist_sq < level.glaive_excalibur_aoe_range_sq )
		{
			if ( isDefined( ai.electrocute_actor_cb ) )
				self thread [ [ ai.electrocute_actor_cb ] ]( ai, wpn_excalibur );
			else
				self thread electrocute_actor( ai, wpn_excalibur );
			
			continue;
		}
		if ( dist_sq > level.glaive_excalibur_cone_range_sq )
			continue;
		
		normal = vectorNormalize( test_origin - view_pos );
		dot = vectorDot( forward_view_angles, normal );
		if ( .707 > dot )
			continue;
		
		if ( 0 == ai damageConeTrace( view_pos, self ) )
			continue;
		
		if ( isDefined( ai.electrocute_actor_cb ) )
		{
			self thread [ [ ai.electrocute_actor_cb ] ]( ai, wpn_excalibur );
			continue;
		}
		self thread electrocute_actor( ai, wpn_excalibur );
	}
}

function electrocute_actor( ai, wpn_excalibur )
{
	self endon( "disconnect" );
	if ( !isDefined( ai ) || !isAlive( ai ) )
		return;
	
	if ( !isDefined( self.tesla_enemies_hit ) )
		self.tesla_enemies_hit = 1;
	
	ai notify( "bhtn_action_notify", "electrocute" );
	set_sword_lightning_chain_params();
	ai.tesla_death = 0;
	ai thread sword_arc_damage_ent( ai.origin, ai.origin, self );
	ai thread tesla_death( self );
}

function set_sword_lightning_chain_params()
{
	level.sword_lightning_chain_params = lightning_chain::create_lightning_chain_params( 1 );
	level.sword_lightning_chain_params.head_gib_chance = 100;
	level.sword_lightning_chain_params.network_death_choke = 4;
	level.sword_lightning_chain_params.should_kill_enemies = 0;
}

function tesla_death( player )
{
	self endon( "death" );
	self thread sword_zombie_explodes_intopieces( 1 );
	wait 2;
	player thread zm_audio::create_and_play_dialog( "kill", "sword_slam" );
	self doDamage( self.health + 1, self.origin );
}

function sword_arc_damage_ent( hit_location, hit_origin, player )
{
	player endon( "disconnect" );
	if ( IS_TRUE( self.zombie_tesla_hit ) )
		return;
	
	self lightning_chain::arc_damage_ent( player, 1, level.sword_lightning_chain_params );
}

function chop_actor( ai, upgraded, leftswing, weapon = level.weaponnone )
{
	self endon( "disconnect" );
	if ( !isDefined( ai ) || !isAlive( ai ) )
		return;
	
	if ( IS_TRUE( upgraded ) )
	{
		if ( 9317 >= ai.health )
			ai.ignoremelee = 1;
		
		[ [ level.ai_sword_chop_throttle ] ]->waitInQueue( ai );
		ai doDamage( 9317, self.origin, self, self, "none", "MOD_UNKNOWN", 0, weapon );
	}
	else if ( 3594 >= ai.health )
		ai.ignoremelee = 1;
	
	[ [ level.ai_sword_chop_throttle ] ]->waitInQueue(ai);
	ai doDamage( 3594, self.origin, self, self, "none", "MOD_UNKNOWN", 0, weapon );
	ai blood_death_fx( leftswing, upgraded );
	util::wait_network_frame();
}

function sword_zombie_explodes_intopieces( random_gibs )
{
	if ( isDefined( self ) && isActor( self ) )
	{
		if ( !random_gibs || randomInt( 100 ) < 50 )
			gibserverutils::gibhead( self );
		
		if ( !random_gibs || randomInt( 100 ) < 50 )
			gibserverutils::gibleftarm( self );
		
		if ( !random_gibs || randomInt( 100 ) < 50 )
			gibserverutils::gibrightarm( self );
		
		if ( !random_gibs || randomInt( 100 ) < 50 )
			gibserverutils::giblegs( self );
		
	}
}

function private blood_death_fx( left_slice, upgraded )
{
	if ( self.archetype == "zombie" )
	{
		if ( left_slice )
		{
			if ( IS_TRUE( upgraded ) )
				self clientfield::increment( "zombie_slice_l", 2 );
			else
				self clientfield::increment( "zombie_slice_l", 1 );
			
		}
		else if ( IS_TRUE( upgraded ) )
			self clientfield::increment( "zombie_slice_r", 2 );
		else
			self clientfield::increment( "zombie_slice_r", 1 );
		
	}
}

function chop_zombies( first_time, large_check, leftswing, weapon = level.weaponnone )
{
	view_pos = self getWeaponMuzzlePoint();
	forward_view_angles = self getWeaponForwardDir();
	zombie_list = getAiTeamArray( level.zombie_team );
	foreach ( key, ai in zombie_list )
	{
		if ( !isDefined( ai ) || !isAlive( ai ) )
			continue;
		
		if ( first_time )
			ai.chopped = 0;
		else if ( IS_TRUE( ai.chopped ) )
			continue;
		
		test_origin = ai getCentroid();
		dist_sq = distanceSquared( view_pos, test_origin );
		dist_to_check = level.glaive_chop_cone_range_sq;
		if ( large_check )
			dist_to_check = level.glaive_chop_cone_lrg_range_sq;
		if ( dist_sq > dist_to_check )
			continue;
		
		normal = vectorNormalize( test_origin - view_pos );
		dot = vectorDot( forward_view_angles, normal );
		if ( dot <= 0 )
			continue;
		
		if ( 0 == ai damageConeTrace( view_pos, self ) )
			continue;
		
		ai.chopped = 1;
		if ( isDefined( ai.chop_actor_cb ) )
		{
			self thread [ [ ai.chop_actor_cb ] ]( ai, self, weapon );
			continue;
		}
		self thread chop_actor( ai, large_check, leftswing, weapon );
	}
}

function swordarc_swipe( player, large_check )
{
	if ( large_check )
		player clientfield::increment_to_player( "swipe_lv2_fx" );
	else
		player clientfield::increment_to_player( "swipe_fx" );
	
	player thread chop_zombies( 1, large_check, 1, self );
	wait .3;
	player thread chop_zombies( 0, large_check, 1, self );
	wait .5;
	player thread chop_zombies( 0, large_check, 0, self );
}

function private sword_attack_watcher( weapon, large_check )
{
	self endon( "sword_attack_watchers_end" );
	self endon( "disconnect" );
	self endon( "bled_out" );
	while ( 1 )
	{
		self util::waittill_any( "weapon_melee_power", "weapon_melee" );
		weapon thread swordarc_swipe( self, large_check );
	}
}

function private autokill_think( wpn_autokill )
{
	self endon( "sword_attack_watchers_end" );
	self endon( "disconnect" );
	self endon( "bled_out" );
	while ( 1 )
	{
		self waittill( "weapon_melee_power_left", weapon );
		if ( weapon == wpn_autokill && self.autokill_glaive_active == 0 )
			self thread send_autokill_sword( wpn_autokill );
		
	}
}

function sword_show_recovery_hint()
{
	if ( IS_TRUE( self.sword_showed_recovery_hint ) )
		return;
	
	self.sword_showed_recovery_hint = 1;
	self notify( "hide_equipment_hint_text" );
	util::wait_network_frame();
	zm_equipment::show_hint_text( "Hold ^3[{+speed_throw}]^7 to recall the Archon Sword", 3.2 );
}

function private recall_autokill_sword( vh_glaive )
{
	self endon( "disconnect" );
	self endon( "sword_attack_watchers_end" );
	self endon( "weapon_change" );
	vh_glaive endon( "returned_to_owner" );
	vh_glaive endon( "disconnect" );
	self thread sword_show_recovery_hint();
	self.vh_sword._glaive_must_return_to_owner = 0;
	while ( isDefined( self ) && self throwButtonPressed() )
		wait .05;
	
	while ( isDefined( self ) )
	{
		if (self throwButtonPressed() )
		{
			self.vh_sword._glaive_must_return_to_owner = 1;
			return;
		}
		wait .05;
	}
}

function private send_autokill_sword( wpn_autokill )
{
	a_sp_glaive = getSpawnerArray( "glaive_spawner", "script_noteworthy" );
	sp_glaive = a_sp_glaive[ 0 ];
	sp_glaive.count = 1;
	vh_glaive = sp_glaive spawnFromSpawner( "player_glaive_" + self.characterindex, 1 );
	self.vh_sword = vh_glaive;
	if ( isDefined( vh_glaive ) )
	{
		vh_glaive vehicle::lights_on();
		self clientfield::increment_to_player( "throw_fx" );
		vh_glaive.origin = ( self.origin + ( 80 * anglesToForward( self.angles ) ) ) + vectorScale( ( 0, 0, 1 ), 50 );
		vh_glaive.angles = self getPlayerAngles();
		vh_glaive.owner = self;
		vh_glaive.weapon = wpn_autokill;
		vh_glaive._glaive_settings_lifetime = math::clamp( self.sword_power * 100, 10, 60 );
		self.autokill_glaive_active = 1;
		self allowMeleePowerLeft( 0 );
		self thread player_sword_rumble( "lv2launch" );
		self thread recall_autokill_sword( vh_glaive );
		vh_glaive util::waittill_any( "returned_to_owner", "disconnect" );
		self thread player_sword_rumble( "lv2recover" );
		self allowMeleePowerLeft( 1 );
		self.autokill_glaive_active = 0;
		self notify( "sword_drop_complete" );
		self.vh_sword = undefined;
		if ( isDefined( self ) )
		{
			util::wait_network_frame();
			self playSound( "wpn_sword2_return" );
		}
		vh_glaive delete();
	}
}

function disabled_sword()
{
	if ( IS_TRUE( self.usingsword ) )
		return;
	
	wpn_excalibur = self get_correct_sword_for_player_character_at_level( 1 );
	wpn_autokill = self get_correct_sword_for_player_character_at_level( 2 );
	// self.sword_allowed = 0;
	if ( self hasWeapon( wpn_autokill ) )
	{
		self clientfield::set_player_uimodel( "zmhud.swordState", 1 );
		if ( 0 )
		{
			self clientfield::set_player_uimodel("zmhud.swordEnergy", 0);
			self gadgetpowerset( 0, 0 );
			self.sword_power = 0;
		}
	}
	else if ( self hasWeapon( wpn_excalibur ) )
	{
		self clientfield::set_player_uimodel( "zmhud.swordState", 5 );
		if ( 0 )
		{
			self clientfield::set_player_uimodel( "zmhud.swordEnergy", 0 );
			self gadgetpowerset( 0, 0 );
			self.sword_power = 0;
		}
	}
}

function sword_power_hud( slot )
{
	self endon( "disconnect" );
	self endon( "sword_attack_watchers_end" );
	while ( isDefined( self ) && IS_TRUE( self.usingsword ) || IS_TRUE( self.autokill_glaive_active ) && self.sword_power > 0 )
	{
		if ( IS_TRUE( self.teleporting ) )
		{
			wait .05;
			continue;
		}
		self.sword_power = self gadgetPowerGet( slot ) / 100;
		self clientfield::set_player_uimodel( "zmhud.swordEnergy", self.sword_power );
		if ( IS_TRUE( self.current_sword_level ) )
			self clientfield::set_player_uimodel( "zmhud.swordState", 7 );
		else
			self clientfield::set_player_uimodel( "zmhud.swordState", 3 );
		
		wait .05;
	}
	self thread player_sword_rumble( "oopower" );
	self.usingsword = 0;
	self.autokill_glaive_active = 0;
	self notify( "sword_drop_complete" );
	if ( isDefined( self.vh_sword ) )
		self.vh_sword._glaive_must_return_to_owner = 1;
	
	while ( self isSlamming() )
		wait .05;
	
	self disabled_sword();
	self notify( "sword_attack_watchers_end" );
}

function sword_power_override( player, enemy )
{
	if ( player laststand::player_is_in_laststand() )
		return;
	
	if ( isDefined( player ) && ( !IS_TRUE( player.usingsword ) && ( !IS_TRUE( player.autokill_glaive_active ) ) && isDefined( player.current_sword ) ) )
	{
		if ( isDefined( enemy.sword_kill_power ) )
		{
			perkfactor = 1;
			if ( player hasPerk( "specialty_overcharge" ) )
				perkfactor = getDvarFloat( "gadgetPowerOverchargePerkScoreFactor" );
			
			temp = player.sword_power + ( perkfactor * ( enemy.sword_kill_power / 100 ) );
			player.sword_power = math::clamp( temp, 0, 1 );
			player clientfield::set_player_uimodel( "zmhud.swordEnergy", player.sword_power );
			player gadgetPowerSet( 0, 100 * player.sword_power );
			player clientfield::increment_uimodel( "zmhud.swordChargeUpdate" );
		}
	}
}
