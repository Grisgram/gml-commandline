/*
    This class analyzes all command line arguments that have been sent to the application
	
	(c)2024- coldrock.games
	MIT License
	You must include the CommandLineLicense.txt file in all you distributions.
*/

function CommandlineArgs() constructor {

	#region string helpers
	static __sh = {
		string_substring: function(str, start, count = undefined) {
			gml_pragma("forceinline");
			return string_copy(str, start, count ?? (string_length(str) - start + 1));
		},

		string_first: function(str, count) {
			var len = string_length(str);
			if (count > 0) {
				if (len > count)
					return string_copy(str, 1, count);
				else
					return str;
			}
			return "";
		},

		string_contains: function(str, substr, startpos = 1) {
			gml_pragma("forceinline");
			return string_pos_ext(substr, str, startpos) > 0;
		},

		string_index_of: function(str, substr, startpos = 1) {
			gml_pragma("forceinline");
			return string_pos_ext(substr, str, startpos);
		},
	}
	#endregion

	static __commandline_switch = function(_index, _switch) constructor {
		index	= _index;
		op		= CommandlineArgs.__sh.string_first(_switch, 1);		// "op"erator contains the +, - or /
		name	= CommandlineArgs.__sh.string_substring(_switch, 2);	// "name" is the name of the switch
	}

	static __commandline_option = function(_index, _option) constructor {
		index	= _index;
		name	= CommandlineArgs.__sh.string_substring(_option, 3);	// "name" is the name of the option
	}

	static __commandline_command = function(_index, _str, _start) constructor {
		index	= _index;
		op		= CommandlineArgs.__is_switch(_str) ? CommandlineArgs.__sh.string_first(_str, 1) : "";
		name	= CommandlineArgs.__sh.string_substring(_str, 2, _start - 3);							
		value	= CommandlineArgs.__sh.string_substring(_str, _start);								
		
		// Example: "/input=data/json/file.json" --> will resolve to
		// op    = "/"
		// name  = "input"
		// value = "data/json/file.json"
	}

	static __is_switch = function(_str) {
		return CommandlineArgs.__sh.string_contains(ARGS_SWITCH_IDENTIFIERS, CommandlineArgs.__sh.string_first(_str, 1));
	}

	static __is_option = function(_str) {
		return string_starts_with(_str, ARGS_OPTION_IDENTIFIER);
	}

	static __find_command = function(_idx, _str) {
		var arr = ARGS_COMMAND_IDENTIFIERS;
		
		for (var i = 0, len = array_length(arr); i < len; i++) {
			var delim = arr[@i];
			var pos = CommandlineArgs.__sh.string_index_of(_str, delim);
			if (pos > 1) {
				return new __commandline_command(_idx, _str, pos + 1);
			}
		}
		return undefined;
	}

	static __get_entry = function(_arr, _name, _case_sensitive) {
		for (var i = 0, len = array_length(_arr); i < len; i++) {
			var s = _arr[@i];
			if ((_case_sensitive && s.name == _name) || (string_lower(_name) == string_lower(s.name)))
				return s;
		}
		
		return undefined;
	}

	/// @func has_option(_name, _case_sensitive = false)
	static has_option = function(_name, _case_sensitive = false) {
		return __get_entry(options, _name, _case_sensitive) != undefined;
	}

	/// @func has_switch(_name, _case_sensitive = false)
	static has_switch = function(_name, _case_sensitive = false) {
		return __get_entry(switches, _name, _case_sensitive) != undefined;
	}

	/// @func is_switch_enabled(_name, _case_sensitive = false)
	static is_switch_enabled = function(_name, _case_sensitive = false) {
		return has_switch(_name, _case_sensitive) && get_switch(_name, _case_sensitive).op == ARGS_SWITCH_ENABLED;
	}

	/// @func has_command(_name, _case_sensitive = false)
	static has_command = function(_name, _case_sensitive = false) {
		return __get_entry(commands, _name, _case_sensitive) != undefined;
	}

	/// @func get_switch(_name, _case_sensitive = false)
	static get_switch = function(_name, _case_sensitive = false) {
		return __get_entry(switches, _name, _case_sensitive);
	}

	/// @func get_command(_name, _case_sensitive = false)
	static get_command = function(_name, _case_sensitive = false) {
		return __get_entry(commands, _name, _case_sensitive);
	}

	count		= parameter_count() - 1;
	exe_name	= parameter_string(0);
	
	args		= [];
	switches	= [];
	options		= [];
	commands	= [];
	
	for (var i = 1; i <= count; i++) {
		var a = parameter_string(i);
		array_push(args, a);
		
		var cmd = __find_command(i, a);
		if (cmd != undefined)	array_push(commands, cmd) else
		if (__is_option(a))		array_push(options,  new __commandline_option(i, __sh.string_substring(a, 3))); else
		if (__is_switch(a))		array_push(switches, new __commandline_switch(i, a));
	}

}
