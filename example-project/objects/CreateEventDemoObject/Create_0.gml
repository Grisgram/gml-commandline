/// @description show commandline arguments
event_inherited();

args_string = string_concat(
	"Message 2: Taken from create event\n\n",
	$"EXE name: {ARGS.exe_name}\n",
	$"Argument count: {ARGS.count}\n\n",
	$"All args: {string_replace_all(ARGS.args, ",", ",\n    ")}\n\n",
	$"Switches: {string_replace_all(ARGS.switches, ",", ",\n    ")}\n\n",
	$"Options:  {string_replace_all(ARGS.options, ",", ",\n    ")}\n\n",
	$"Commands: {string_replace_all(ARGS.commands, ",", ",\n    ")}\n",
);


