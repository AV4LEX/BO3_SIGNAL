#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicles\_glaive;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#namespace zm_weap_glaive;

#precache( "client_fx", "zombie/fx_sword_trail_1p_zod_zmb" );
#precache( "client_fx", "zombie/fx_sword_trail_1p_lvl2_zod_zmb" );
#precache( "client_fx", "zombie/fx_sword_slash_right_1p_zod_zmb" );
#precache( "client_fx", "zombie/fx_sword_slash_left_1p_zod_zmb" );
#precache( "client_fx", "zombie/fx_keeper_death_zod_zmb" );
#precache( "client_fx", "zombie/fx_sword_slam_elec_1p_zod_zmb" );
#precache( "client_fx", "zombie/fx_sword_slam_elec_3p_zod_zmb" );
#precache( "client_fx", "zombie/fx_sword_lvl2_throw_1p_zod_zmb" );

REGISTER_SYSTEM_EX( "zm_weap_glaive", &__init__, undefined, undefined )

function __init__()
{
	clientfield::register( "allplayers", "slam_fx", VERSION_SHIP, 1, "counter", &do_slam_fx, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register( "toplayer", "throw_fx", VERSION_SHIP, 1, "counter", &do_throw_fx, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register( "toplayer", "swipe_fx", VERSION_SHIP, 1, "counter", &do_swipe_fx, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register( "toplayer", "swipe_lv2_fx", VERSION_SHIP, 1, "counter", &do_swipe_lv2_fx, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register( "actor", "zombie_slice_r", VERSION_SHIP, 2, "counter", &do_zombie_slice_r, CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register( "actor", "zombie_slice_l", VERSION_SHIP, 2, "counter", &do_zombie_slice_l, CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	level._effect[ "sword_swipe_1p" ] = "zombie/fx_sword_trail_1p_zod_zmb";
	level._effect[ "sword_swipe_lv2_1p" ] = "zombie/fx_sword_trail_1p_lvl2_zod_zmb";
	level._effect[ "sword_bloodswipe_r_1p" ] = "zombie/fx_sword_slash_right_1p_zod_zmb";
	level._effect[ "sword_bloodswipe_l_1p" ] = "zombie/fx_sword_slash_left_1p_zod_zmb";
	level._effect[ "sword_bloodswipe_r_level2_1p" ] = "zombie/fx_keeper_death_zod_zmb";
	level._effect[ "sword_bloodswipe_l_level2_1p" ] = "zombie/fx_keeper_death_zod_zmb";
	level._effect[ "groundhit_1p" ] = "zombie/fx_sword_slam_elec_1p_zod_zmb";
	level._effect[ "groundhit_3p" ] = "zombie/fx_sword_slam_elec_3p_zod_zmb";
	level._effect[ "sword_lvl2_throw" ] = "zombie/fx_sword_lvl2_throw_1p_zod_zmb";
}

function do_swipe_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	owner = self getOwner( localclientnum );
	if ( isDefined( owner ) && owner == getLocalPlayer( localclientnum ) )
	{
		swipe_fx = playViewModelFx( localclientnum, level._effect[ "sword_swipe_1p" ], "tag_flash" );
		wait 3;
		deleteFx( localclientnum, swipe_fx, 1 );
	}
}

function do_swipe_lv2_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	owner = self getOwner( localclientnum );
	if ( isDefined( owner ) && owner == getLocalPlayer( localclientnum ) )
	{
		swipe_lv2_fx = playViewModelFx( localclientnum, level._effect[ "sword_swipe_lv2_1p" ], "tag_flash" );
		wait 3;
		deleteFx( localclientnum, swipe_lv2_fx, 1 );
	}
}

function do_zombie_slice_r( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	if ( util::is_mature() && !util::is_gib_restricted_build() )
	{
		if ( newval == 1 )
			playFxOnTag(localclientnum, level._effect[ "sword_bloodswipe_r_1p" ], self, "j_spine4" );
		else if ( newval == 2 )
			playFxOnTag( localclientnum, level._effect[ "sword_bloodswipe_r_level2_1p" ], self, "j_spineupper" );
		
	}
	self playSound( 0, "zmb_sword_zombie_explode" );
}

function do_zombie_slice_l( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	if ( util::is_mature() && !util::is_gib_restricted_build() )
	{
		if ( newval == 1 )
			playFxOnTag( localclientnum, level._effect["sword_bloodswipe_l_1p"], self, "j_spine4");
		else if ( newval == 2 )
			playFxOnTag( localclientnum, level._effect["sword_bloodswipe_l_level2_1p" ], self, "j_spineupper" );
		
	}
	self playsound(0, "zmb_sword_zombie_explode");
}

function do_slam_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	thread do_gravity_spike_fx( localclientnum, self, self.origin );
}

function do_throw_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	owner = self getOwner( localclientnum );
	if ( isDefined( owner ) && owner == getLocalPlayer( localclientnum ) )
	{
		throw_fx = playFxOnCamera( localclientnum, level._effect[ "sword_lvl2_throw" ], ( 0, 0, 0 ), ( 0, 1, 0 ), ( 0, 0, 1 ) );
		wait 3;
		deleteFx( localclientnum, throw_fx, 1 );
	}
}

function do_gravity_spike_fx( localclientnum, owner, position )
{
	first_person = 0;
	if ( self isPlayer() && self isLocalPlayer() && !isDemoPlaying() )
	{
		if ( !isDefined( self getLocalClientNumber() ) || localclientnum == self getLocalClientNumber() )
			first_person = 1;
		
	}
	if ( first_person )
	{
		fx = level._effect[ "groundhit_1p" ];
		fwd = anglesToForward( owner.angles );
		playFx( localclientnum, fx, position + ( fwd * 100 ), fwd );
	}
	else
	{
		fx = level._effect[ "groundhit_3p" ];
		fwd = anglesToForward( owner.angles );
		playFx( localclientnum, fx, position, fwd );
	}
}

function getideallocationforfx( startpos, fxindex, fxcount, defaultdistance, rotation )
{
	currentangle = ( 360 / fxcount ) * fxindex;
	coscurrent = cos( currentangle + rotation );
	sincurrent = sin( currentangle + rotation );
	return startpos + ( defaultdistance * coscurrent, defaultdistance * sincurrent, 0 );
}

function randomizelocation( startpos, max_x_offset, max_y_offset )
{
	half_x = int( max_x_offset / 2 );
	half_y = int( max_y_offset / 2 );
	rand_x = randomIntRange( half_x * -1, half_x );
	rand_y = randomIntRange( half_y * -1, half_y );
	return startpos + ( rand_x, rand_y, 0 );
}

function ground_trace( startpos, owner )
{
	trace_height = 50;
	trace_depth = 100;
	return bulletTrace( startpos + ( 0, 0, trace_height ), startpos - ( 0, 0, trace_depth ), 0, owner );
}