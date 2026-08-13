--[[
  mobs_mini_animals: Caterpillar Entity Definition
  
  AI Behavior Rationale:
  Slow-crawling bug that wanders around leaves and ground flora.
  
  Grass-Eating Justification:
  NON-GRAZER. Eats foliage/leaves in larval state, but does not graze ground grass in this framework.
  Zero grass eating behavior enabled. Breeding is not gated by grass consumption.
--]]

local S = core.get_translator("mobs_mini_animals")

mobs:register_mob("mobs_mini_animals:caterpillar", {
	type = "animal",
	pathfinding = 1,
	passive = true,
	hp_min = 2,
	hp_max = 4,
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
	mesh = "animal-caterpillar.glb",
	textures = {
		{"colormap.png"}
	},
	makes_footstep_sound = false,
	sounds = {},
	walk_velocity = 0.5,
	run_velocity = 1.0,
	jump = false,
	stepheight = 0.6,
	pushable = true,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 2},
	},
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

-- Spawning configuration: Spawns on leaves and flowers
if not mobs.custom_spawn_animal then
	mobs:spawn({
		name = "mobs_mini_animals:caterpillar",
		nodes = {"group:leaves", "group:flower"},
		min_light = 10,
		interval = 60,
		chance = 5000,
		min_height = 1,
		max_height = 80,
		day_toggle = true,
	})
end

mobs:register_egg("mobs_mini_animals:caterpillar", S("Caterpillar"), "inv_animal-caterpillar.png")
