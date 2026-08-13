--[[
  mobs_mini_animals: Deer Entity Definition
  
  AI Behavior Rationale:
  Graceful skittish herbivore that roams forests and meadows.
  Flees rapidly upon detecting players or predators.
  
  Grass-Eating Justification:
  GRAZER. Deer graze grass and foliage in woods and meadows.
  Autonomous node-eating is enabled as the SOLE gate for breeding readiness (self.horny = true).
--]]

local S = core.get_translator("mobs_mini_animals")

mobs:register_mob("mobs_mini_animals:deer", {
	type = "animal",
	pathfinding = 1,
	passive = false,
	damage = 3,
	hp_min = 8,
	hp_max = 16,
	fear_threshold = 0.5,
	curiosity = 0.5,

	attack_type = "dogfight",
	pathfinding = 1,

	armor = 100,
	collisionbox = {-0.6, 0, -0.6, 0.6, 1.2, 0.6},
	visual = "mesh",
	visual_size = {x = 5.175, y = 5.175},
	rotate = 180,
	mesh_animation = "idle",
	mesh = "animal-deer.glb",
	textures = {
		{"colormap.png"}
	},
	makes_footstep_sound = true,
	sounds = {},
	walk_velocity = 1.5,
	run_velocity = 3.5,
	runaway = true,
	runaway_from = {"group:player", "mobs_mini_animals:lion", "mobs_mini_animals:tiger", "mobs_mini_animals:dog"},
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

-- Spawning configuration: Spawns in forests and plains
if not mobs.custom_spawn_animal then
	mobs:spawn({
		name = "mobs_mini_animals:deer",
		nodes = {"mcl_core:dirt_with_grass", "default:dirt_with_grass"},
		min_light = 10,
		interval = 30,
		chance = 2000,
		min_height = 1,
		max_height = 120,
		day_toggle = true,
	})
end

mobs:register_egg("mobs_mini_animals:deer", S("Deer"), "inv_animal-deer.png")
