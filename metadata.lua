return PlaceObj('ModDef', {
	'title', "Indome Forestation Plant",
	'description', "Allows the forestation plant to be built inside a dome.\n\nThe forestation plant's range is centered on the dome.\n\nPermission is granted to update this mod to support the latest version of the game if I'm not around to do it myself.",
	'image', "preview.jpg",
	'last_changes', "Initial version.",
	'dependencies', {
		PlaceObj('ModDependency', {
			'id', "mrudat_AllowBuildingInDome",
			'title', "Allow Building In Dome",
		}),
	},
	'id', "mrudat_IndomeForestationPlant",
	'steam_id', "1832556592",
	'pops_desktop_uuid', "ce87dfaa-d82b-4304-807e-41d83a192597",
	'pops_any_uuid', "3110dc08-c163-4333-8438-6fc465c5847b",
	'author', "mrudat",
	'version', 5,
	'lua_revision', 233360,
	'saved_with_revision', 245618,
	'code', {
		"Code/IndomeForestationPlant.lua",
	},
	'saved', 1565608648,
})