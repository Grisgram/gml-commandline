// Feather ignore all in ./*

#macro GML_COMMANDLINE_VERSION		"2409"
#macro GML_COMMANDLINE_NAME			"gml-commandline "
#macro GML_COMMANDLINE_COPYRIGHT	"(c)2024* coldrock.games, @Grisgram (github)"

var cpyrght = (current_year == 2022) ?
	string_replace(GML_COMMANDLINE_COPYRIGHT, "*", "") :
	string_replace(GML_COMMANDLINE_COPYRIGHT, "*", "-" + string(current_year));
show_debug_message(GML_COMMANDLINE_NAME + GML_COMMANDLINE_VERSION + " loaded. " + cpyrght);
