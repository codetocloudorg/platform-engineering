local M = {}

M.opts = {
	routes = {
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "written",
			},
			opts = { skip = true },
		},
		{
			filter = {
				event = "msg_show",
				kind = "search_count",
			},
			opts = { skip = true },
		},
		{
			filter = {
				event = "msg_show",
				kind = "",
			},
			opts = { skip = true },
		},
	},
}

return M
