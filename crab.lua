--[[
  mobs_mini_animals: Crab Entity Definition
  
  AI Behavior Rationale:
  Amphibious crustacean scuttling along beaches and coastal waters.
  
  Grass-Eating Justification:
  NON-GRAZER. Crabs scavenge detritus/algae on shores, not pasture grass.
  Zero grass eating behavior enabled. Breeding is not gated by grass consumption.
--]]

local S = core.get_translator("mobs_mini_animals")

mobs:register_mob("mobs_mini_animals:crab", {
	type = "animal",
	pathfinding = 1,
	passive = true,
	hp_min = 4,
	hp_max = 8,
	fear_threshold = 0.5,
	curiosity = 0.5,

	runaway = true,
	attack_type = "none",
	pathfinding = 1,

	fly = true,
	fly_in = {"default:water_source", "default:water_flowing", "mcl_core:water_source"},
	armor = 100,
	collisionbox = {-0.3, 0, -0.3, 0.3, 0.5, 0.3},
	visual = "mesh",
	visual_size = {x = 5.175, y = 5.175},
	rotate = 180,
	mesh_animation = "idle",
	mesh = "animal-crab.glb",
	textures = {
		{"colormap.png"}
	},
	makes_footstep_sound = false,
	sounds = {},
	walk_velocity = 1,
	run_velocity = 2,
	jump = true,
	jump_height = 2,
	stepheight = 0.6,
	pushable = true,
		drops = {
		{name = mobs_mini_animals.meat_item, chance = 1, min = 1, max = 2},
	},
	-- Amphibious: safe in water, lethal in lava
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 3,
	fly_in = {"mcl_core:water_source", "mcl_core:water_flowing", "default:water_source", "default:water_flowing"},
	floats = 0,

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
			on_breed = function(self, ent)
		return mobs_mini_animals.on_breed_custom(self, ent)
	end,
		do_custom = function(self, dtime)
		mobs_mini_animals.natural_breed_timer(self)
	end,
		on_rightclick = function(self, clicker)
		if mobs:capture_mob(self, clicker, 0, 80, 0, true, nil) then
			return
		end
	end,
})

-- Spawning configuration: Spawns on sand near water
if not mobs.custom_spawn_animal then
	mobs:spawn({
		name = "mobs_mini_animals:crab",
		nodes = {"mcl_core:sand", "default:sand"},
		neighbors = {"group:water"},
		min_light = 10,
		interval = 30,
		chance = 2000,
		min_height = 1,
		max_height = 20,
		day_toggle = true,
	})
end

mobs:register_egg("mobs_mini_animals:crab", S("Crab"), "inv_animal-crab.png")
