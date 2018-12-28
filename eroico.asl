state ("eroico") {
	
	byte start : 0x0027D574, 0x4, 0x14, 0x8, 0x18, 0x4C4;
	byte checkpoints : 0x004452F8, 0x84, 0x4B0;
	byte whiteScreen : 0x005119A0, 0x7CC, 0x1E4;
}

startup {

	settings.Add("checkpointSplit", true, "Split on checkpoints");
	settings.Add("whiteScreenSplit", true, "Split on post boss white screens");

}


start {

	return current.start != 0 && old.start == 0;
}

//reset {
	
//	return current.notInMainMenu == 0 && old.notInMainMenu != 0;
//}

split {

	return (settings["checkpointSplit"] && current.checkpoints != 0 && old.checkpoints == 0 ||
		settings["whiteScreenSplit"] && current.whiteScreen == 1 && old.whiteScreen == 0 );
}




	