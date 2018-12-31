state ("eroico") {
	
	byte mainMenu : 0x002840B0, 0x244, 0x90, 0x0, 0x3B4, 0x0, 0x244, 0xA7C, 0x3B0;
	byte checkpoints : 0x004452F8, 0x84, 0x4B0;
	byte whiteScreen : 0x004452F8, 0x7C, 0xE0;
}

startup {
	
	vars.lastSplitTime = timer.CurrentTime; 
	settings.Add("checkpointSplit", true, "Split on checkpoints");
	settings.Add("whiteScreenSplit", true, "Split on post boss white screens");

}

start {

	vars.lastSplitTime = timer.CurrentTime;
	return current.mainMenu < old.mainMenu;

}

reset {
	
	return current.mainMenu != 0 && old.mainMenu == 0;
}


split {

	if ( (timer.CurrentTime - vars.lastSplitTime).RealTime.TotalSeconds >= 3.0	&& 
	    (settings["checkpointSplit"] && current.checkpoints != 0 && old.checkpoints == 0 ||
	     settings["whiteScreenSplit"] && current.whiteScreen == 1 && old.whiteScreen == 0) )
		{
		vars.lastSplitTime = timer.CurrentTime;
		return true;
		}

}




	