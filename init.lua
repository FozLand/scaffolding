--[[
	Copyright (C) 2014 DanteLives
	Copyright (C) 2016 John Cole
	This file is part of Scaffolding.

	Scaffolding is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	Scaffolding is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Scaffolding.  If not, see <http://www.gnu.org/licenses/>.
--]]

local def = {
	description = 'Scaffolding',
	tiles = {'default_wood.png'},
	drawtype = 'nodebox',
	paramtype = 'light',
	paramtype2 = 'facedir',
	node_box = {
		type = 'fixed',
		fixed = {
			{ -1/2, -1/2, -1/2, -3/8, -3/8,  1/2 },
			{ -1/2,  1/2, -1/2, -3/8,  3/8,  1/2 },
			{  1/2,  1/2, -1/2,  3/8,  3/8,  1/2 },
			{  1/2, -1/2, -1/2,  3/8, -3/8,  1/2 },
			{ -1/2, -1/2, -1/2,  1/2, -3/8, -3/8 },
			{ -1/2,  3/8, -1/2,  1/2,  1/2, -3/8 },
			{ -1/2, -1/2, -1/2, -3/8,  1/2, -3/8 },
			{  3/8, -1/2, -1/2,  1/2,  1/2, -3/8 },
			{ -1/2, -1/2,  3/8,  1/2, -3/8,  1/2 },
			{ -1/2,  3/8,  3/8,  1/2,  1/2,  1/2 },
			{ -1/2, -1/2,  3/8, -3/8,  1/2,  1/2 },
			{  3/8, -1/2,  3/8,  1/2,  1/2,  1/2 },
		},
	},
	climbable = true,
	walkable = false,
	is_ground_content = true,
	groups = {scaffolding = 1, dig_immediate = 3, flammable = 3},
	sounds = default.node_sound_wood_defaults()
}

minetest.register_node('scaffolding:scaffolding', def)

minetest.register_craft({
	output = 'scaffolding:scaffolding',
	recipe = {
		{'default:stick', '',              'default:stick'},
		{'',              'default:stick', ''             },
		{'default:stick', '',              'default:stick'},
	}
})

minetest.register_craft({
	type = 'fuel',
	recipe = 'group:scaffolding',
	burntime = 15,
})

if dye then
	local dyes = {
		{"white",      "White",      'unicolor_white',       '#FFFFFF:191'},
		{"grey",       "Grey",       'unicolor_grey',        '#686868:223'},
		{"dark_grey",  "Dark grey",  'unicolor_darkgrey',    '#404040:239'},
		{"black",      "Black",      'unicolor_black',       '#161616:239'},
		{"violet",     "Violet",     'unicolor_violet',      '#5100A2:239'},
		{"blue",       "Blue",       'unicolor_blue',        '#2626FF:215'},
		{"cyan",       "Cyan",       'unicolor_cyan',        '#26FFFF:191'},
		{"dark_green", "Dark green", 'unicolor_dark_green',  '#085101:239'},
		{"green",      "Green",      'unicolor_green',       '#00A200:215'},
		{"yellow",     "Yellow",     'unicolor_yellow',      '#E4E400:215'},
		{"brown",      "Brown",      'unicolor_dark_orange', '#512900:239'},
		{"orange",     "Orange",     'unicolor_orange',      '#A25100:239'},
		{"red",        "Red",        'unicolor_red',         '#A20000:223'},
		{"magenta",    "Magenta",    'unicolor_red_violet',  '#A200A2:223'},
		{"pink",       "Pink",       'unicolor_light_red',   '#FF8080:239'},
	}

	for _, row in ipairs(dyes) do
		local name  = row[1]
		local desc  = row[2]
		local craft_color_group = row[3]
		local color = row[4]

		local def = table.copy(def)
		def.description = desc..' Scaffolding'
		def.tiles = {'scaffolding_greyscale_wood.png^[colorize:'..color}

		minetest.register_node('scaffolding:scaffolding_'..name, def)

		minetest.register_craft({
			type = 'shapeless',
			output = 'scaffolding:scaffolding_'..name,
			recipe = {'group:'..craft_color_group, 'group:scaffolding'},
		})
	end
end
