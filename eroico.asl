state ("eroico") {
	
	byte mainMenu : 0x0028FDA0, 0xFAC, 0x8, 0x48, 0xC, 0x48, 0x1C, 0x0, 0x244, 0xA7C, 0x3B0;
	byte checkpoints : 0x004452F8, 0x84, 0x4B0;
	byte whiteScreen : 0x002886A8, 0x88, 0x22C, 0xC, 0x3C, 0x14, 0x8, 0x234C, 0x1C, 0x8;
}

startup {

	settings.Add("checkpointSplit", true, "Split on checkpoints");
	settings.Add("whiteScreenSplit", true, "Split on post boss white screens");

}


start {

	return current.mainMenu != 87 && old.mainMenu == 87;
}

reset {
	
	return current.mainMenu != 0 && old.mainMenu == 0;
}


split {

	return (settings["checkpointSplit"] && current.checkpoints != 0 && old.checkpoints == 0 ||
		settings["whiteScreenSplit"] && current.whiteScreen == 1 && old.whiteScreen == 0 );
}




	