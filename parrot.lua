--[[
  mobs_mini_animals: Parrot Entity Definition
  
  AI Behavior Rationale:
  Colorful avian mob that flies between jungle canopy and tree branches.
  
  Grass-Eating Justification:
  NON-GRAZER. Parrots eat seeds/fruits in trees, not ground pasture grass.
  Zero grass eating behavior enabled. Breeding is not gated by grass consumption.
--]]

local S = core.get_translator("mobs_mini_animals")

mobs:register_mob("mobs_mini_animals:parrot", {
	type = "animal",
	pathfinding = 1,
	passive = true,
	hp_min = 2,
	hp_max = 6,
	fear_threshold = 0.5,
	curiosity = 0.5,

	runaway = true,
	attack_type = "none",
	pathfinding = 1,

	fly = true,
	fly_in = "air",
	armor = 100,
	collisionbox = {-0.3, 0, -0.3, 0.3, 0.5, 0.3},
	visual = "mesh",
	visual_size = {x = 5.175, y = 5.175},
	rotate = 180,
	mesh_animation = "idle",
	mesh = "animal-parrot.glb",
	textures = {
		{"colormap.png"}
	},
	makes_footstep_sound = false,
	sounds = {},
	walk_velocity = 1.5,
	run_velocity = 3.0,
	jump = true,
	jump_height = 4,
	stepheight = 1.1,
	pushable = true,
		drops = {
		{name = mobs_mini_animals.meat_item, chance = 1, min = 1, max = 2},
	},
	-- Flying/Air mob: Drowns in water, burns in lava
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fall_damage = 0,
	fall_speed = -2,
	fly = true,
	fly_in = {"air"},

	-- GLB Animation Mapping
	animation = {
		speed_normal = 1,
		stand_start = 0.05, stand_end = 0.95, stand_speed = 1,
		walk_start = 1.05, walk_end = 1.45, walk_speed = 1,
		run_start = 1.55, run_end = 1.95, run_speed = 1,
		eat_start = 2.05, eat_end = 2.80, eat_speed = 1,
	},
	view_range = 8,

	-- Strict Interaction Rules: NOT tameable, NOT rideable, NOT feedable by player, Catchable by net
			
	replace_rate = 10,
	replace_what = {
		{"group:grass", "air", 0},
		{"mcl_core:dirt_with_grass", "mcl_core:dirt", -1},
		{"default:dirt_with_grass", "default:dirt", -1},
	},
	on_replace = function(self, pos, oldnode, newnode)
		self:set_animation("eat", true)
		if not self.child and (self.hornytimer or 0) == 0 and math.random(1, 10) == 1 then
			self.horny = true
		end
	end,

	on_breed = function(self, ent)
		return mobs_mini_animals.on_breed_custom(self, ent)
	end,
	on_rightclick = function(self, clicker)
		if mobs:capture_mob(self, clicker, 0, 80, 0, true, nil) then
			return
		end
	end,
})

-- Spawning configuration: Spawns in jungle canopy
if not mobs.custom_spawn_animal then
	mobs:spawn({
		name = "mobs_mini_animals:parrot",
		nodes = {"group:leaves", "mcl_core:dirt_with_grass", "default:dirt_with_grass"},
		min_light = 10,
		interval = 30,
		chance = 2000,
		min_height = 1,
		max_height = 120,
		day_toggle = true,
	})
end

mobs:register_egg("mobs_mini_animals:parrot", S("Parrot"), "inv_animal-parrot.png")
