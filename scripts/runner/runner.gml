/*
    just print the args and exit
*/

ENSURE_ARGS;

show_debug_message($"count    = {ARGS.count}");
show_debug_message($"exe_name = \"{ARGS.exe_name}\"");
show_debug_message($"args     = {ARGS.args}");
show_debug_message($"switches = {ARGS.switches}");
show_debug_message($"options  = {ARGS.options}");
show_debug_message($"commands = {ARGS.commands}");

game_end();
