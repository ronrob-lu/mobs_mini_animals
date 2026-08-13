--[[
  mobs_mini_animals: Chick Entity Definition
  
  AI Behavior Rationale:
  Small baby fowl that wanders near farmsteads and grassy plains.
  Flees from players and larger predators.
  
  Grass-Eating Justification:
  GRAZER. Chicks peck at grass and seed nodes autonomously.
  Autonomous node-eating is enabled as the SOLE gate for breeding readiness (self.horny = true).
--]]

local S = core.get_translator("mobs_mini_animals")

mobs:register_mob("mobs_mini_animals:chick", {
	type = "animal",
	pathfinding = 1,
	passive = true,
	hp_min = 4,
	hp_max = 6,
	fear_threshold = 0.5,
	curiosity = 0.5,

	runaway = true,
	attack_type = "none",
	pathfinding = 1,

	armor = 100,
	collisionbox = {-0.3, 0, -0.3, 0.3, 0.5, 0.3},
	visual = "mesh",
	visual_size = {x = 5.175, y = 5.175},
	rotate = 180,
	mesh_animation = "idle",
	mesh = "animal-chick.glb",
	textures = {
		{"colormap.png"}
	},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_chicken",
	},
	walk_velocity = 1,
	run_velocity = 2,
	runaway = true,
	runaway_from = {"group:player", "mobs_mini_animals:fox", "mobs_mini_animals:cat"},
	jump = true,
	jump_height = 2,
	stepheight = 0.6,
	pushable = true,
		drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 2},
		{name = "mobs:egg", chance = 2, min = 1, max = 1},
	},
	-- Standard land hazard profile: lethal in water/lava
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 3,

	-- GLB Animation Mapping
	animation = {
		speed_normal = 1,
		stand_start = 0.05, stand_end = 0.95, stand_speed = 1,
		walk_start = 1.05, walk_end = 1.45, walk_speed = 1,
		run_start = 1.55, run_end = 1.95, run_speed = 1,
		eat_start = 2.05, eat_end = 2.80, eat_speed = 1,
	},
	view_range = 8,

	-- Grazing & Autonomous Breeding Regulator
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

	-- Strict Interaction Rules: NOT tameable, NOT rideable, NOT feedable by player, Catchable by net
			on_breed = function(self, ent)
		return mobs_mini_animals.on_breed_custom(self, ent)
	end,
	on_rightclick = function(self, clicker)
		if mobs:capture_mob(self, clicker, 0, 80, 0, true, nil) then
			return
		end
	end,
})

-- Spawning configuration: Spawns in grassy plains
if not mobs.custom_spawn_animal then
	mobs:spawn({
		name = "mobs_mini_animals:chick",
		nodes = {"mcl_core:dirt_with_grass", "default:dirt_with_grass"},
		min_light = 10,
		interval = 60,
		chance = 7000,
		min_height = 1,
		max_height = 100,
		day_toggle = true,
	})
end

mobs:register_egg("mobs_mini_animals:chick", S("Chick"), "inv_animal-chick.png")
