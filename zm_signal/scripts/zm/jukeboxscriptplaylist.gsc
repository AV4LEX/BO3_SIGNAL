thread MusicToggle();
// Add this thread to your main function in the gsc.

// Add the rest of this file to the bottom of your gsc. Make sure to follow the instructions that are commented on certain lines.

function MusicToggle()
{
	songtotal = 3; // Change 3 to the last jukesong in the csv, example if it's jukesong5, make this 5. Jukesong should start from 0

	level waittill("initial_blackscreen_passed");

	level.numberOfSongs = songtotal + 1;

	level.soundLoc = GetEnt("soundLoc","targetname");
    trig = GetEnt("musTrigger", "targetname");
    trig SetCursorHint("HINT_NOICON");
	trig SetHintString("You must turn on the power first!");

	level waittill("power_on");
	
	model = GetEnt("jukeboxModel","targetname");
	model SetModel("cp_town_jukebox");
    
    while(isdefined(self))
    {
        str_concat = ( IS_TRUE(level.musicEnabled) ? "disable": "enable" );
		trig SetCursorHint("HINT_INTERACT");
        trig SetHintString("Press ^3[{+activate}]^7 to " + str_concat + " music");
        trig waittill("trigger");
        level.musicEnabled = ( IS_TRUE(level.musicEnabled) ? false : true );

		if(level.musicEnabled == false)
		{
			thread endSong();
		}
		else
		{
			thread JukeBoxPlaylist();
		}
    }
}

function JukeBoxPlaylist()
{
	self endon("endPlaylist");

    while(isdefined(self))
    {
		for(i=0; i < level.numberOfSongs; i++)
		{
			level.soundLoc PlaySoundWithNotify("jukesong" + i, "endMus");
			level waittill("endMus");
			wait(0.5); // This is just a pause between songs, change this however you want.
		}
	}
}

// To add another song to the list, simply increase the song number in the music toggle and add the song to the csv as the nexzt jukesong number.

function endSong()
{
	for(i=0; i < level.numberOfSongs; i++)
	{
		level.soundLoc StopSound("jukesong" + i);
	}
	level flag::set("endPlaylist");
}

// This function is optional, if you do not want it stamp the prefab, delete the right-side trigger and extend the left-side one if you do not want a trigger that skips the current song.
// If you do want a skip trigger, make sure to add 'thread skipSong();' to your main function.
function skipSong()
{
	level waittill("power_on");
	trig = GetEnt("skipTrigger", "targetname");
    trig SetCursorHint("HINT_INTERACT");
	trig SetHintString("Press ^3[{+activate}]^7 to skip the current song"); // You can change this however you please, this is the trigger's text.

	while(isdefined(self))
		{
			trig waittill("trigger");
			for(i=0; i < level.numberOfSongs; i++)
			{
				level.soundLoc StopSound("jukesong" + i);
			}
			level.soundLoc flag::set("endMus");
		}
}