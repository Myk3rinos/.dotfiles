return {
	setup = function(state, opts)
		-- Save the user configuration to the plugin's state
		state.key1 = opts.key1
		state.key2 = opts.key2
    state.console = true
	end,
}
