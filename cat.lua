--[[
  mobs_mini_animals: Cat Entity Definition
  
  AI Behavior Rationale:
  Curious feline that wanders around villages and grassy areas.
  Hunt small rodents/birds (chickens, bunnies) if encountered.
  
  Grass-Eating Justification:
  NON-GRAZER. Carnivore / obligate carnivore.
  Zero grass eating behavior enabled. Breeding is not gated by grass consumption.
--]]

local S = core.get_translator("mobs_mini_animals")

mobs:register_mob("mobs_mini_animals:cat", {
	type = "animal",
	pathfinding = 1,
	passive = false,
	damage = 3,
	hp_min = 6,
	hp_max = 10,
	fear_threshold = 0.5,
	curiosity = 0.5,

	attack_type = "dogfight",
	pathfinding = 1,

	armor = 100,
	collisionbox = {-0.4, 0, -0.4, 0.4, 0.8, 0.4},
	visual = "mesh",
	visual_size = {x = 5.175, y = 5.175},
	rotate = 180,
	mesh_animation = "idle",
	mesh = "animal-cat.glb",
	textures = {
		{"colormap.png"}
	},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_kitten",
	},
	walk_velocity = 1,
	run_velocity = 2.5,
	jump = true,
	jump_height = 3,
	stepheight = 0.6,
	pushable = true,
		drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 2},
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

-- Spawning configuration: Spawns near villages and grassy areas
if not mobs.custom_spawn_animal then
	mobs:spawn({
		name = "mobs_mini_animals:cat",
		nodes = {"mcl_core:dirt_with_grass", "default:dirt_with_grass"},
		min_light = 10,
		interval = 60,
		chance = 8000,
		min_height = 1,
		max_height = 100,
		day_toggle = true,
	})
end

mobs:register_egg("mobs_mini_animals:cat", S("Cat"), "inv_animal-cat.png")
