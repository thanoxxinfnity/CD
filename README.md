# Zombie Survival — Godot + Hunyuan3D-2

A small first-person zombie survival prototype in Godot 4, plus a Kaggle
notebook that generates 3D game assets from images using Tencent's
Hunyuan3D-2 model.

## Structure

- `godot/` — the playable Godot 4 project.
  - `scenes/Main.tscn` — entry point (map + HUD + wave timer).
  - `scenes/Map.tscn` — ground, 6 placeholder buildings, 4 zombie spawners,
    player spawn.
  - `scenes/Player.tscn` / `scripts/Player.gd` — WASD + mouse-look FPS
    controller, left-click to shoot (raycast).
  - `scenes/Zombie.tscn` / `scripts/Zombie.gd` — chases and attacks the
    player, has health/take_damage.
  - `scripts/ZombieSpawner.gd` — timed spawning, ramps up per wave.
  - `scripts/GameManager.gd` — autoloaded global state (health, wave,
    score, game over signal).
  - `assets/generated_models/` — drop Hunyuan3D-generated `.glb` files
    here (see its `README.md`).
- `kaggle/` — `hunyuan3d_generate.ipynb` (run on Kaggle's free GPU to turn
  concept images into `.glb` models) plus instructions for running it via
  the website or pushing it with the Kaggle API/CLI.

## Running the game

Open `godot/project.godot` in Godot **4.3+**, then press F5 (or the Play
button). Controls: WASD move, mouse look, Space jump, Shift sprint, left
click shoot, Esc to release the mouse.

Everything currently uses placeholder geometry (colored boxes/capsules) —
buildings are boxes, the zombie is a green box. See `kaggle/README.md` to
generate real models and `godot/assets/generated_models/README.md` to
swap them in.
