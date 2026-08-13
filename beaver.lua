--[[
  mobs_mini_animals: Beaver Entity Definition
  
  AI Behavior Rationale:
  Semi-aquatic dam builder that swims in rivers/lakes and wanders near water edges.
  Exhibits curious but shy behavior (runs away when approached by players).
  
  Grass-Eating Justification:
  NON-GRAZER. Beavers eat bark/wood/aquatic plants IRL, but do not graze pasture grass.
  Zero grass eating behavior enabled. Breeding is not gated by grass consumption.
--]]

local S = core.get_translator("mobs_mini_animals")

mobs:register_mob("mobs_mini_animals:beaver", {
	type = "animal",
	pathfinding = 1,
	passive = true,
	hp_min = 6,
	hp_max = 12,
	fear_threshold = 0.5,
	curiosity = 0.5,

	runaway = true,
	attack_type = "none",
	pathfinding = 1,

	armor = 100,
	collisionbox = {-0.4, 0, -0.4, 0.4, 0.8, 0.4},
	visual = "mesh",
	visual_size = {x = 5.175, y = 5.175},
	rotate = 180,
	mesh_animation = "idle",
	mesh = "animal-beaver.glb",
	textures = {
		{"colormap.png"}
	},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_rat",
		damage = "mobs_rat",
		death = "mobs_rat",
	},
	walk_velocity = 1,
	run_velocity = 2,
	runaway = true,
	runaway_from = {"group:player", "mobs_mini_animals:lion", "mobs_mini_animals:tiger"},
	jump = true,
	jump_height = 2,
	stepheight = 0.6,
	pushable = true,
		drops = {
		{name = "mobs:meat_raw", chance = 2000, min = 1, max = 2},
	},
	-- Semi-aquatic: safe in water, lethal in lava
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 4,
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
		do_custom = function(self, dtime)
		
		if math.random(1, 1000) == 1 then
			local pos = self.object:get_pos()
			if core.find_node_near(pos, 2, {"group:water"}) then
				core.set_node(pos, {name="default:junglewood"})
			end
		end

	end,
		on_rightclick = function(self, clicker)
		if mobs:capture_mob(self, clicker, 0, 80, 0, true, nil) then
			return
		end
	end,
})

-- Spawning configuration: Spawns near water/rivers
if not mobs.custom_spawn_animal then
	mobs:spawn({
		name = "mobs_mini_animals:beaver",
		nodes = {"mcl_core:dirt_with_grass", "default:dirt_with_grass"},
		neighbors = {"group:water"},
		min_light = 10,
		interval = 30,
		chance = 2000,
		min_height = 1,
		max_height = 60,
		day_toggle = true,
	})
end

mobs:register_egg("mobs_mini_animals:beaver", S("Beaver"), "inv_animal-beaver.png")
