# Generated 3D models

Drop `.glb` files from the Kaggle Hunyuan3D-2 notebook (`../../../kaggle/`)
here, e.g. `zombie.glb`, `building.glb`, `prop.glb`. Godot auto-imports
`.glb` files placed anywhere under the project folder.

## Swapping a placeholder mesh for a generated one

1. Copy the `.glb` into this folder. Reopen/refresh the Godot editor — it
   imports automatically and appears in the FileSystem dock.
2. Open the scene that has the placeholder (e.g. `scenes/Zombie.tscn`).
3. Select the `MeshInstance3D` node.
4. Either:
   - Drag the imported `.glb` into the scene as a child and delete the old
     `MeshInstance3D`/`BoxMesh` placeholder, then re-point
     `CollisionShape3D` if the new model's size differs noticeably, **or**
   - Instance the `.glb` as its own scene and reparent the existing
     `CollisionShape3D`/`NavigationAgent3D`/script onto it.
5. Repeat for `scenes/Player.tscn` (optional — first-person body mesh
   usually isn't visible anyway) and for the building `StaticBody3D` nodes
   in `scenes/Map.tscn`.

Scale note: Hunyuan3D-2 outputs are normalized to roughly a 1-unit
bounding box, so you'll generally need to scale the imported node up
(e.g. to match the zombie capsule's ~1.9m height) via its Transform in
the Godot inspector.
