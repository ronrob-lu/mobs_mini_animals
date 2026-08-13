# 🦁 Mobs Mini Animals

**A next-generation, living ecosystem for Minetest & MineClone2**

Welcome to **Mobs Mini Animals** — an advanced wildlife expansion powered by the `mobs_redo` framework. We didn't just add mobs; we built an autonomous, evolving ecosystem where animals live, hunt, mutate, and thrive without player intervention.

If you are looking for a mod that brings your worlds to life with rich AI, generational genetics, and brutal predator-prey dynamics, you've found it.

---

## ✨ Features

### 🧬 True Genetic Inheritance & Mutation
Forget static clones. In **Mobs Mini Animals**, every baby born is a unique calculation of its parents' genetics. 
- **Inherited Traits:** Max Health, Walk Velocity, Run Velocity, and Fear Thresholds are inherited from parents.
- **Generational Evolution:** Every offspring has a **15% chance to mutate**, shifting its stats by up to ±10%. Over time, you can selectively breed (by proxy) or watch wild herds evolve to become faster, stronger, and more resilient!

### 🧠 Autonomous Ecosystems
These animals don't need you to feed them wheat. They survive on their own.
- **Self-Sustaining Grazers:** Herbivores (like Cows, Bunnies, and Deer) autonomously seek out and eat grass. Grazing is their only trigger to become ready to mate.
- **Natural Life Cycles:** Predators and non-grazers naturally reach breeding readiness over time as they wander the world. 
- **Hands-off:** You **cannot** tame, ride, or hand-feed these animals. This forces the ecosystem to remain wild and untamed. (Want to relocate them? Better craft a net!)

### ⚔️ Advanced Predator/Prey Dynamics
The food chain is alive and well. 
- **Apex Predators:** Lions, Tigers, and Polar Bears actively stalk and hunt smaller animals and players on sight. 
- **Opportunistic Hunters:** Foxes and Hogs have specific prey lists—they'll leave you alone but will eagerly hunt down chickens, bunnies, and koalas.
- **Retaliation AI:** Think that Cow is defenseless? Punch it and find out. Many "docile" animals will aggressively fight back if provoked.

### 🌍 24 Unique Animals
Populate your world with an incredible variety of beautifully animated creatures, complete with custom `.glb` meshes and ambient soundscapes:
- **Savanna & Desert:** Lion, Giraffe, Elephant
- **Forest & Taiga:** Bear, Fox, Deer, Wolf/Dog, Koala
- **Jungle:** Monkey, Panda, Tiger, Parrot
- **Farm & Plains:** Cow, Pig, Bunny, Cat, Chick, Bee, Caterpillar
- **Aquatic & Semi-Aquatic:** Fish, Crab, Beaver, Penguin

---

## 🛠️ Installation & Dependencies

This mod requires the **[mobs_redo](https://notabug.org/TenPlus1/mobs_redo)** API to function.

1. Download the `mobs_mini_animals` folder.
2. Drop it into your Minetest `mods/` directory.
3. Enable it in your world configuration (alongside `mobs`).
4. **Important:** Ensure `enable_damage = true` in your world settings, otherwise predators won't hunt!

---

## 🎒 Gameplay Mechanics

- **Spawning:** Animals spawn naturally across all fitting biomes (Savannas, Forests, Oceans).
- **Drops:** To keep survival mechanics balanced, all animals currently yield **Raw Meat** upon death.
- **Capture:** Since taming is disabled, you must use standard `mobs_redo` **Nets** to capture and transport animals to your bases or enclosures.

---

*Breathe life into your world. Let nature take its course.*
