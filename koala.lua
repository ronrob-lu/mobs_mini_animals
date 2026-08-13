--[[
  mobs_mini_animals: Koala Entity Definition
  
  AI Behavior Rationale:
  Tree-dwelling marsupial that hangs around forest and jungle foliage.
  
  Grass-Eating Justification:
  NON-GRAZER. Koalas consume eucalyptus/tree leaves, not ground grass.
  Zero grass eating behavior enabled. Breeding is not gated by grass consumption.
--]]

local S = core.get_translator("mobs_mini_animals")

mobs:register_mob("mobs_mini_animals:koala", {
	type = "animal",
	pathfinding = 1,
	passive = false,
	damage = 3,
	hp_min = 4,
	hp_max = 8,
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
	mesh = "animal-koala.glb",
	textures = {
		{"colormap.png"}
	},
	makes_footstep_sound = false,
	sounds = {},
	walk_velocity = 0.8,
	run_velocity = 1.5,
	jump = true,
	jump_height = 2,
	stepheight = 0.6,
	pushable = true,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 2},
	},
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

-- Spawning configuration: Spawns in eucalyptus / forest biomes
if not mobs.custom_spawn_animal then
	mobs:spawn({
		name = "mobs_mini_animals:koala",
		nodes = {"group:leaves", "mcl_core:dirt_with_grass", "default:dirt_with_grass"},
		min_light = 10,
		interval = 60,
		chance = 8000,
		min_height = 1,
		max_height = 100,
		day_toggle = true,
	})
end

mobs:register_egg("mobs_mini_animals:koala", S("Koala"), "inv_animal-koala.png")
