local silicon_config = require("config.silicon")

return {

	-- Silicon allows us to take nice pictures of our code to send to other
	-- people
	{
		{
			"michaelrommel/nvim-silicon",
			lazy = true,
			cmd = "Silicon",
			main = "nvim-silicon",
			opts = silicon_config.opts,
			init = silicon_config.init,
		},
	},
}
