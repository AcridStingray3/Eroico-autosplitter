state ("eroico") {
		
	byte mainMenu : 0x002840B0, 0x244, 0x90, 0x0, 0x3B4, 0x0, 0x244, 0xA7C, 0x3B0; //previously used for start too but that was causing starts on game launch and exit. Kept around mostly for reset since the new startHelper has a chance of randomly resetting if used there too
	byte startHelper : 0x31190B;
	byte checkpoints : 0x004452F8, 0x84, 0x4B0;
	byte checkpointSafety : 0x004452F8, 0x84, 0x80; //the var for checkpoints probably tracks something for the girl's animation so it was very rarely triggering a split on the last boss. This pointer is never 0 in the last boss so it should fix that. 
	byte whiteScreen : 0x004452F8, 0x7C, 0xE0;
	
}

startup {

	vars.lastSplitTime = timer.CurrentTime; 
	settings.Add("checkpointSplit", true, "Split on checkpoints");
	settings.Add("whiteScreenSplit", true, "Split on post boss white screens");

}

start {

	vars.lastSplitTime = timer.CurrentTime;
	return current.startHelper != 0 && old.startHelper == 0 && old.mainMenu != 0;

}



reset {
	
	return current.mainMenu != 0 && old.mainMenu == 0;
}

split {

	if ( (timer.CurrentTime - vars.lastSplitTime).RealTime.TotalSeconds >= 3.0	&& 		
	    (settings["checkpointSplit"] && current.checkpoints != 0 && old.checkpoints == 0 && current.checkpointSafety == 0 ||
	     settings["whiteScreenSplit"] && current.whiteScreen == 1 && old.whiteScreen == 0) )
		{
		vars.lastSplitTime = timer.CurrentTime;
		return true;
		}

}




	