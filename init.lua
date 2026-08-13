-- mobs_mini_animals init.lua

local path = core.get_modpath(core.get_current_modname())

-- Monkey-patch mobs_redo set_animation to natively support string names for GLTF models
if mobs and mobs.mob_class and mobs.mob_class.set_animation then
	core.log("action", "[mobs_mini_animals] MONKEY PATCH SUCCESSFUL!")
	local old_set_animation = mobs.mob_class.set_animation
	mobs.mob_class.set_animation = function(self, anim, force)
		if not self.animation or not anim then return end
		local anim_name = self.animation[anim .. "_start"]
		if type(anim_name) == "string" then
			self.animation.current = self.animation.current or ""
			if force ~= true and anim ~= "punch" and anim ~= "shoot"
			and string.find(self.animation.current, anim) then return end
			
			self.animation.current = anim
			local speed = self.animation[anim .. "_speed"] or self.animation.speed_normal or 15
			local loop = self.animation[anim .. "_loop"] ~= false
			self.object:set_animation(anim_name, speed, 0, loop)
		else
			return old_set_animation(self, anim, force)
		end
	end
else
	core.log("error", "[mobs_mini_animals] MONKEY PATCH FAILED: mobs=" .. tostring(mobs) .. " mob_class=" .. tostring(mobs and mobs.mob_class))
end

core.register_chatcommand("clear_mini_animals", {
	description = "Clears all loaded mini animals",
	privs = {server=true},
	func = function(name, param)
		local count = 0
		for _, obj in pairs(core.object_refs) do
			if obj and not obj:is_player() then
				local ent = obj:get_luaentity()
				if ent and ent.name and string.find(ent.name, "mobs_mini_animals:") then
					obj:remove()
					count = count + 1
				end
			end
		end
		return true, "Removed " .. count .. " mini animals."
	end,
})

local mob_files = {
	"beaver",
	"bee",
	"bunny",
	"cat",
	"caterpillar",
	"chick",
	"cow",
	"crab",
	"deer",
	"dog",
	"elephant",
	"fish",
	"fox",
	"giraffe",
	"hog",
	"koala",
	"lion",
	"monkey",
	"panda",
	"parrot",
	"penguin",
	"pig",
	"polar",
	"tiger"
}

mobs_mini_animals = {}

function mobs_mini_animals.inherit_value(val1, val2, min_limit, max_limit)
	local base = (val1 + val2) / 2
	-- 15% chance to mutate by +/-10%
	if math.random() <= 0.15 then
		local variation = base * 0.10
		base = base + (math.random() * variation * 2 - variation)
	end
	if base < min_limit then base = min_limit end
	if base > max_limit then base = max_limit end
	return base
end

function mobs_mini_animals.mutate_child(child_entity, parent1_entity, parent2_entity)
	local p1 = parent1_entity
	local p2 = parent2_entity
	local c = child_entity

	local def = core.registered_entities[c.name] or {}
	local hp_max_l = def.hp_max and (def.hp_max * 2) or 50
	
	c.hp_max = math.floor(mobs_mini_animals.inherit_value(p1.hp_max or def.hp_max or 10, p2.hp_max or def.hp_max or 10, def.hp_min or 1, hp_max_l))
	c.walk_velocity = mobs_mini_animals.inherit_value(p1.walk_velocity or def.walk_velocity or 1, p2.walk_velocity or def.walk_velocity or 1, 0.1, 5)
	c.run_velocity = mobs_mini_animals.inherit_value(p1.run_velocity or def.run_velocity or 2, p2.run_velocity or def.run_velocity or 2, 0.5, 10)
	c.fear_threshold = mobs_mini_animals.inherit_value(p1.fear_threshold or 0.5, p2.fear_threshold or 0.5, 0.0, 1.0)
	c.curiosity = mobs_mini_animals.inherit_value(p1.curiosity or 0.5, p2.curiosity or 0.5, 0.0, 1.0)

	c.health = c.hp_max
	c.object:set_hp(c.hp_max)
end

function mobs_mini_animals.on_breed_custom(self, ent)
	self.horny = false
	self.hornytimer = 0
	ent.horny = false
	ent.hornytimer = 0
	self.child = false
	ent.child = false
	
	local pos = self.object:get_pos()
	if not pos then return false end
	
	core.add_particlespawner({
		amount = 4,
		time = 1,
		minpos = {x = pos.x - 1, y = pos.y + 1, z = pos.z - 1},
		maxpos = {x = pos.x + 1, y = pos.y + 2, z = pos.z + 1},
		minvel = {x = 0, y = 2, z = 0},
		maxvel = {x = 0, y = 3, z = 0},
		minacc = {x = 0, y = -1, z = 0},
		maxacc = {x = 0, y = -1, z = 0},
		minexptime = 1,
		maxexptime = 1,
		minsize = 4,
		maxsize = 6,
		texture = "heart.png",
	})
	
	local child = core.add_entity(pos, self.name)
	if child then
		local cent = child:get_luaentity()
		if cent then
			cent.child = true
			cent.hornytimer = 0
			cent.time_of_day = 0.5
			if cent.base_colbox then
				cent.object:set_properties({
					visual_size = {
						x = cent.base_size.x / 2,
						y = cent.base_size.y / 2
					},
					collisionbox = {
						cent.base_colbox[1] / 2,
						cent.base_colbox[2] / 2,
						cent.base_colbox[3] / 2,
						cent.base_colbox[4] / 2,
						cent.base_colbox[5] / 2,
						cent.base_colbox[6] / 2
					}
				})
			end
			mobs_mini_animals.mutate_child(cent, self, ent)
		end
	end
	
	return false
end

function mobs_mini_animals.natural_breed_timer(self)
	if not self.child and (self.hornytimer or 0) == 0 and not self.horny then
		if math.random(1, 1000) <= 2 then -- 2% chance per do_custom call to become horny
			self.horny = true
		end
	end
end

for _, file in ipairs(mob_files) do
	dofile(path .. "/" .. file .. ".lua")
end
