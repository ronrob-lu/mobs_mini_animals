--[[
  mobs_mini_animals: Fox Entity Definition
  
  AI Behavior Rationale:
  Quick, sly forest predator that stalks small animals (chickens, bunnies) and stays wary of players.
  
  Grass-Eating Justification:
  NON-GRAZER. Carnivore.
  Zero grass eating behavior enabled. Breeding is not gated by grass consumption.
--]]

local S = core.get_translator("mobs_mini_animals")

mobs:register_mob("mobs_mini_animals:fox", {
	type = "animal",
	pathfinding = 1,
	passive = false,
	damage = 3,
	hp_min = 6,
	hp_max = 12,
	fear_threshold = 0.5,
	curiosity = 0.5,

	attack_type = "dogfight",
	pathfinding = 1,
	specific_attack = {"mobs_mini_animals:koala", "mobs_mini_animals:panda", "mobs_mini_animals:penguin", "mobs_mini_animals:bee", "mobs_mini_animals:beaver", "mobs_mini_animals:bunny", "mobs_mini_animals:chick", "mobs_mini_animals:crab", "mobs_mini_animals:deer", "mobs_mini_animals:hog"},

	armor = 100,
	collisionbox = {-0.4, 0, -0.4, 0.4, 0.8, 0.4},
	visual = "mesh",
	visual_size = {x = 5.175, y = 5.175},
	rotate = 180,
	mesh_animation = "idle",
	mesh = "animal-fox.glb",
	textures = {
		{"colormap.png"}
	},
	makes_footstep_sound = true,
	sounds = {},
	walk_velocity = 1.2,
	run_velocity = 3.0,
	runaway = true,
	runaway_from = {"group:player", "mobs_mini_animals:lion", "mobs_mini_animals:tiger"},
	jump = true,
	jump_height = 3,
	stepheight = 0.6,
	pushable = true,
		drops = {
		{name = "mobs:meat_raw", chance = 2000, min = 1, max = 2},
	},
	-- Standard land hazard profile: lethal in water/lava
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 4,

	-- GLB Animation Mapping
	animation = {
		speed_normal = 1,
		stand_start = 0.05, stand_end = 0.95, stand_speed = 1,
		walk_start = 1.05, walk_end = 1.45, walk_speed = 1,
		run_start = 1.55, run_end = 1.95, run_speed = 1,
		eat_start = 2.05, eat_end = 2.80, eat_speed = 1,
	},
	view_range = 10,

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

-- Spawning configuration: Spawns in taiga and forest biomes
if not mobs.custom_spawn_animal then
	mobs:spawn({
		name = "mobs_mini_animals:fox",
		nodes = {"mcl_core:dirt_with_grass", "default:dirt_with_grass"},
		min_light = 10,
		interval = 30,
		chance = 2000,
		min_height = 1,
		max_height = 100,
		day_toggle = true,
	})
end

mobs:register_egg("mobs_mini_animals:fox", S("Fox"), "inv_animal-fox.png")
