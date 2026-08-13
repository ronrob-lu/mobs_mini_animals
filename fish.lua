--[[
  mobs_mini_animals: Fish Entity Definition
  
  AI Behavior Rationale:
  Aquatic creature swimming gracefully in oceans and rivers.
  
  Grass-Eating Justification:
  NON-GRAZER. Fish feed on plankton/algae, not ground pasture grass.
  Zero grass eating behavior enabled. Breeding is not gated by grass consumption.
--]]

local S = core.get_translator("mobs_mini_animals")

mobs:register_mob("mobs_mini_animals:fish", {
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
	fly_in = {"default:water_source", "default:water_flowing", "mcl_core:water_source"},
	armor = 100,
	collisionbox = {-0.3, 0, -0.3, 0.3, 0.5, 0.3},
	visual = "mesh",
	visual_size = {x = 5.175, y = 5.175},
	rotate = 180,
	mesh_animation = "idle",
	mesh = "animal-fish.glb",
	textures = {
		{"colormap.png"}
	},
	makes_footstep_sound = false,
	sounds = {},
	walk_velocity = 1.5,
	run_velocity = 2.5,
	jump = false,
	stepheight = 0.1,
	pushable = true,
		drops = {
		{name = "mobs:meat_raw", chance = 2000, min = 1, max = 2},
	},
	-- Aquatic animal: Safe in water, suffocates in air, burns in lava
	water_damage = 0,
	air_damage = 1,
	lava_damage = 5,
	light_damage = 0,
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

-- Spawning configuration: Spawns in water nodes
if not mobs.custom_spawn_animal then
	mobs:spawn({
		name = "mobs_mini_animals:fish",
		nodes = {"mcl_core:water_source", "default:water_source"},
		min_light = 5,
		interval = 30,
		chance = 2000,
		min_height = -30,
		max_height = 10,
		day_toggle = false,
	})
end

mobs:register_egg("mobs_mini_animals:fish", S("Fish"), "inv_animal-fish.png")
