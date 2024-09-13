/*
    this script shows, how to initialize the command line system in global scope
*/

ENSURE_ARGS;

show_message(string_concat(
	"Message 1: Taken from global scope\n\n",
	$"EXE name: {ARGS.exe_name}\n",
	$"Argument count: {ARGS.count}\n\n",
	$"All args: {ARGS.args}\n\n",
	$"Switches: {ARGS.switches}\n",
	$"Switches: {ARGS.options}\n",
	$"Commands: {ARGS.commands}\n",
	)
);

// --- How to proceed from here ---
/*

	Either you analyze the options here in global scope or in the Create event of the demo object.
	
	To get a hang, how it works, try the following:
	
	1. Remember, you need to compile the project as an EXE file for windows, it does NOT work
	   inside GameMaker Studio, as you can not add custom arguments through the IDE
	   
	2. Try to do some simple things, like:
	   - "I want that fullscreen is possible through --fullscreen"
	     (see example below)

*/

if (ARGS.has_option("fullscreen"))
	window_set_fullscreen(true);
	
// A more elegant way would be:
// window_set_fullscreen(ARGS.has_option("fullscreen"));
