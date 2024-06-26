#using scripts\codescripts\struct;

#using scripts\shared\callbacks_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#using scripts\shared\ai\zombie_utility;

#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_power;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_melee_weapon;
#using scripts\zm\_zm_perks;

#using scripts\zm\_zm_powerup_nuke;

#using scripts\shared\ai\systems\gib;

#insert scripts\zm\_zm_perk_bandolier_bandit.gsh;
#insert scripts\zm\_zm_perks.gsh;
#insert scripts\zm\_zm_utility.gsh;

#precache( "material", BANDOLIER_BANDIT_SHADER ); 

#namespace bandolier_bandit;

REGISTER_SYSTEM( "bandolier_bandit", &__init__, undefined )


//-----------------------------------------------------------------------------------
// setup
//-----------------------------------------------------------------------------------
function __init__()
{
	enable_custom_perk_for_level();
}

function enable_custom_perk_for_level()
{	
	zm_perks::register_perk_basic_info( BANDOLIER_BANDIT_SPECIALTY, "customperk", BANDOLIER_BANDIT_COST, "Hold ^3[{+activate}]^7 for Bandolier Bandit [Cost: &&1] \n Effect: " + PERK_BANDOLIER_BANDIT_DSEC, GetWeapon( BANDOLIER_BANDIT_BOTTLE_WEAPON ) );
	zm_perks::register_perk_precache_func( BANDOLIER_BANDIT_SPECIALTY, &custom_perk_precache );
	zm_perks::register_perk_clientfields( BANDOLIER_BANDIT_SPECIALTY, &custom_perk_register_clientfield, &custom_perk_set_clientfield );
	zm_perks::register_perk_machine( BANDOLIER_BANDIT_SPECIALTY, &custom_perk_machine_setup );
	zm_perks::register_perk_threads( BANDOLIER_BANDIT_SPECIALTY, &give_custom_perk, &take_custom_perk );
	zm_perks::register_perk_host_migration_params( BANDOLIER_BANDIT_SPECIALTY, PERK_BANDOLIER_BANDIT_NAME, BANDOLIER_BANDIT_MACHINE_LIGHT_FX );

	//register double buy
	level thread register_db_perk(BANDOLIER_BANDIT_SPECIALTY, PERK_BANDOLIER_BANDIT_DSEC_DB, BANDOLIER_BANDIT_DB_COST, PERK_BANDOLIER_BANDIT_NAME);
	
	if ( !isdefined( level.reap_custom_perk_array ) )
		level.reap_custom_perk_array = [];	
	level.reap_custom_perk_array[BANDOLIER_BANDIT_SPECIALTY] = true;	

	//callbacks here
}

function custom_perk_precache()
{
	// PRECACHE SHIT HERE
	level.machine_assets[BANDOLIER_BANDIT_SPECIALTY] = SpawnStruct();
	level.machine_assets[BANDOLIER_BANDIT_SPECIALTY].weapon = GetWeapon( BANDOLIER_BANDIT_BOTTLE_WEAPON );
	level.machine_assets[BANDOLIER_BANDIT_SPECIALTY].off_model = BANDOLIER_BANDIT_MACHINE_DISABLED_MODEL;
	level.machine_assets[BANDOLIER_BANDIT_SPECIALTY].on_model = BANDOLIER_BANDIT_MACHINE_ACTIVE_MODEL;	
	
	//add fx here if neccicary
	
}

function custom_perk_register_clientfield()
{
	clientfield::register( "clientuimodel", PERK_CLIENTFIELD_BANDOLIER_BANDIT, VERSION_SHIP, 2, "int" );
}

function custom_perk_set_clientfield( state )
{
	self clientfield::set_player_uimodel( PERK_CLIENTFIELD_BANDOLIER_BANDIT, state );
}

function register_db_perk(perk, desc, cost, name)
{
	if ( !isdefined( level.db_perks_registered ) )
		level.db_perks_registered = [];	
	db_perk = SpawnStruct();
	db_perk.desc = desc;
	db_perk.cost = cost;			
	db_perk.name = name;			
	level.db_perks_registered[ perk ] = db_perk;
}

function custom_perk_machine_setup( use_trigger, perk_machine, bump_trigger, collision )
{
	use_trigger.script_sound = "";
	use_trigger.script_string = BANDOLIER_BANDIT_BOTTLE_WEAPON;
	use_trigger.script_label = "";
	use_trigger.target = PERK_BANDOLIER_BANDIT_NAME;
	perk_machine.script_string = BANDOLIER_BANDIT_BOTTLE_WEAPON;
	perk_machine.targetname = PERK_BANDOLIER_BANDIT_NAME;
	if(IsDefined(bump_trigger))
	{
		bump_trigger.script_string = BANDOLIER_BANDIT_BOTTLE_WEAPON;
	}
}

function give_custom_perk()
{
	if(!isdefined(self.disabled_perks))
		self.disabled_perks = [];
	self.disabled_perks[ BANDOLIER_BANDIT_SPECIALTY ] = true;
	if(!isdefined(self.player_cz_perks))
		self.player_cz_perks = [];
	if(!isdefined(self.player_cz_perks_db))
		self.player_cz_perks_db = [];
	self.player_cz_perks[BANDOLIER_BANDIT_SPECIALTY] = true;
	self thread bandolier_bandit();
}

function take_custom_perk( b_pause, str_perk, str_result )
{
	self.disabled_perks[ BANDOLIER_BANDIT_SPECIALTY ] = false;
	self.player_cz_perks[BANDOLIER_BANDIT_SPECIALTY] = undefined;
	self.player_cz_perks_db[BANDOLIER_BANDIT_SPECIALTY] = undefined;
}


function reap_create_hud_icon(aligX, aligY, horzAlin, vertAlin, x, y, alp, icon, icon_x, icon_y, color)
{
	hud = undefined;
	if(self == level)
		hud = newHudElem();
	else
		hud = NewClientHudElem( self );
	hud.alignX = aligX; 
	hud.alignY = aligY;
	hud.horzAlign = horzAlin; 
	hud.vertAlign = vertAlin;
	hud.x = x;
	hud.y = y;
	hud.alpha = alp;
	hud.color = color;
	hud SetShader( icon, icon_x, icon_y );
	
	return hud;
}

function reap_create_hud_text(aligX, aligY, horzAlin, vertAlin, x, y, alp, color, text, size)
{
	hud = undefined;
	if(self == level)
		hud = newHudElem();
	else
		hud = NewClientHudElem( self );
	hud.alignX = aligX; 
	hud.alignY = aligY;
	hud.horzAlign = horzAlin; 
	hud.vertAlign = vertAlin;
	hud.x = x;
	hud.y = y;
	hud.alpha = alp;
	hud.color = color;
	hud.fontScale = size;
	hud setText( text );
	
	return hud;
}

function HasPerkNew(perk)
{
	if(!isdefined(self.player_cz_perks))
		return false;
	if(isdefined(self.player_cz_perks) && isdefined(self.player_cz_perks[perk]))
		return true;
	return false;
}

function HasDbPerkNew(perk)
{
	if(!isdefined(self.player_cz_perks_db))
		return false;
	if(isdefined(self.player_cz_perks_db) && isdefined(self.player_cz_perks_db[perk]))
		return true;
	return false;
}

function additional_ammo_check(gun)
{
	clip = gun.clipsize;
	switch( gun.name )
	{
	case "lmg_cqb":
		return clip;
		break; 

	default:
		if(clip >= 50)
			return clip;
		else
			return clip*2;
		break;
	}
	return 60;
}

function bandolier_bandit()
{
	self.bandolier_bandit_ammo_watch = [];
	self thread bandolier_bandit_weapon_purchase_watch();
	self thread bandolier_bandit_weapon_ammo_purchase_watch();
	self thread bandolier_bandit_max_ammo_watch();
	self thread bandolier_bandit_weapon_take_watch();
	self thread bandolier_bandit_db();
	bandolier_bandit_text = undefined;
	
	while(self HasPerkNew(BANDOLIER_BANDIT_SPECIALTY))
	{
		self util::waittill_any_return( "reload", "reload_start", "weapon_change_complete" );
		wait .4;
		weapon = self GetCurrentWeapon();
		if(!isdefined(self.bandolier_bandit_ammo_watch[weapon.name]))
			self.bandolier_bandit_ammo_watch[weapon.name] = additional_ammo_check(weapon);
		
		stock = self GetWeaponAmmoStock( weapon );
		if(stock < weapon.maxAmmo)
		{
			ammount = weapon.maxAmmo-stock;
			if(self.bandolier_bandit_ammo_watch[weapon.name] < ammount)
				ammount = self.bandolier_bandit_ammo_watch[weapon.name];
			self.bandolier_bandit_ammo_watch[weapon.name] -= ammount;
			self SetWeaponAmmoStock( weapon, stock + ammount );	
		}
		if(isdefined(self.bandolier_bandit_ammo_watch[weapon.name]) && self.bandolier_bandit_ammo_watch[weapon.name] > 0)
		{
			if(!isdefined(bandolier_bandit_text))
				bandolier_bandit_text = reap_create_hud_text("right", "bottom", "right", "bottom", -120, -2, .8, (0.05,1,.8), "+"+self.bandolier_bandit_ammo_watch[weapon.name], 2);
			bandolier_bandit_text setText("+"+self.bandolier_bandit_ammo_watch[weapon.name]);
		}
		else
		if(isdefined(bandolier_bandit_text))
		{
			bandolier_bandit_text Destroy();
			bandolier_bandit_text = undefined;
		}
	}
	if(isdefined(bandolier_bandit_text))
	{
		bandolier_bandit_text Destroy();
		bandolier_bandit_text = undefined;
	}
}

function bandolier_bandit_weapon_purchase_watch()
{
	self notify("bandolier_bandit_weapon_purchase_watch");
	self endon("bandolier_bandit_weapon_purchase_watch");
	
	while(1)
	{
		self waittill( "weapon_give", weapon );	
		if(isdefined(self.bandolier_bandit_ammo_watch[weapon.name]))
			self.bandolier_bandit_ammo_watch[weapon.name] = undefined;
	}
}

function bandolier_bandit_weapon_ammo_purchase_watch()
{
	self notify("bandolier_bandit_weapon_ammo_purchase_watch");
	self endon("bandolier_bandit_weapon_ammo_purchase_watch");
	
	while(1)
	{
		self waittill( "weapon_ammo_restocked", weapon );	
		if(isdefined(self.bandolier_bandit_ammo_watch[weapon.name]))
			self.bandolier_bandit_ammo_watch[weapon.name] = undefined;
	}
}

function bandolier_bandit_max_ammo_watch()
{
	self notify("bandolier_bandit_max_ammo_watch");
	self endon("bandolier_bandit_max_ammo_watch");
	
	while(1)
	{
		self waittill( "zmb_max_ammo" );	
		self.bandolier_bandit_ammo_watch = [];
	}
}

function bandolier_bandit_weapon_take_watch()
{
	self notify("bandolier_bandit_weapon_take_watch");
	self endon("bandolier_bandit_weapon_take_watch");
	
	while(1)
	{
		self waittill( "weapon_take", weapon );	
		if(isdefined(self.bandolier_bandit_ammo_watch[weapon.name]))
			self.bandolier_bandit_ammo_watch[weapon.name] = undefined;
	}
}

function bandolier_bandit_db()
{
	self notify("bandolier_bandit_db");
	self endon("bandolier_bandit_db");
	while(self HasPerkNew(BANDOLIER_BANDIT_SPECIALTY))
	{
		primaryWeapons = self GetWeaponsListPrimaries();
		for ( i = 0; i < primaryWeapons.size; i++ )
		{
			clip = primaryWeapons[i].clipsize;
			clip_cur = self GetWeaponAmmoClip( primaryWeapons[i] );
			stock = self GetWeaponAmmoStock( primaryWeapons[i] );
			
			if(clip_cur < clip && stock > 0 && self HasDbPerkNew(BANDOLIER_BANDIT_SPECIALTY) && primaryWeapons[i] != self GetCurrentWeapon())
			{
					self SetWeaponAmmoStock( primaryWeapons[i], stock-1 );	
					self SetWeaponAmmoClip( primaryWeapons[i], clip_cur+1 );	
			}
		}
		wait 2;
	}
}