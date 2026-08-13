--[[
  mobs_mini_animals: Bee Entity Definition
  
  AI Behavior Rationale:
  Flying insect that hovers around flowers and gardens.
  Non-hostile passive pollinator that stays high near flora.
  
  Grass-Eating Justification:
  NON-GRAZER. Bees collect nectar and pollen from flowers, not grass nodes.
  Zero grass eating behavior enabled. Breeding is not gated by grass consumption.
--]]

local S = core.get_translator("mobs_mini_animals")

mobs:register_mob("mobs_mini_animals:bee", {
	type = "animal",
	pathfinding = 1,
	passive = false,
	hp_min = 2,
	hp_max = 4,
	fear_threshold = 0.5,
	curiosity = 0.5,

	attack_type = "dogfight",
	pathfinding = 1,
	attack_animals = true,
	attack_players = true,
	attack_npcs = true,

	fly = true,
	fly_in = "air",
	armor = 100,
	collisionbox = {-0.3, 0, -0.3, 0.3, 0.5, 0.3},
	visual = "mesh",
	visual_size = {x = 5.175, y = 5.175},
	rotate = 180,
	mesh_animation = "idle",
	mesh = "animal-bee.glb",
	textures = {
		{"colormap.png"}
	},
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_bee",
		damage = "mobs_bee",
		death = "mobs_bee",
	},
	walk_velocity = 2,
	run_velocity = 3,
	jump = true,
	jump_height = 4,
	stepheight = 1.1,
	pushable = true,
		drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 2},
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

-- Spawning configuration: Spawns around flowers
if not mobs.custom_spawn_animal then
	mobs:spawn({
		name = "mobs_mini_animals:bee",
		nodes = {"group:flower"},
		min_light = 12,
		interval = 60,
		chance = 6000,
		min_height = 1,
		max_height = 100,
		day_toggle = true,
	})
end

mobs:register_egg("mobs_mini_animals:bee", S("Bee"), "inv_animal-bee.png")
