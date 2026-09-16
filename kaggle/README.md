# Hunyuan3D-2 game asset generation (Kaggle)

Generates game-ready `.glb` 3D models (zombie, building, prop) using
Tencent's **Hunyuan3D-2** image-to-3D model on Kaggle's free GPU
(T4 x2 / P100). No API calls to a paid service — the model runs directly
in the notebook.

## Option A — run it in the browser (simplest, no token needed)

1. Go to kaggle.com → **Create → New Notebook**.
2. File → Import Notebook → upload `hunyuan3d_generate.ipynb`.
3. Notebook Settings (right sidebar) → **Accelerator: GPU T4 x2** (or P100),
   **Internet: on**.
4. Run all cells. Takes ~10-20 min depending on queue.
5. Download `generated_models.zip` from the Output tab.

## Option B — push it from the command line with your API token

Only needed if you want to script the upload instead of using the website.

1. Kaggle → Account → API → **Create New Token**, downloads `kaggle.json`.
2. Put it where the CLI expects it (never commit this file):
   ```bash
   mkdir -p ~/.kaggle
   mv ~/Downloads/kaggle.json ~/.kaggle/kaggle.json
   chmod 600 ~/.kaggle/kaggle.json
   pip install kaggle
   ```
3. Edit `kernel-metadata.json` in this folder — replace `YOUR_KAGGLE_USERNAME`
   with your actual Kaggle username.
4. Push and run it:
   ```bash
   cd kaggle
   kaggle kernels push
   ```
5. Check status / pull outputs once it finishes:
   ```bash
   kaggle kernels status YOUR_KAGGLE_USERNAME/hunyuan3d-zombie-assets
   kaggle kernels output YOUR_KAGGLE_USERNAME/hunyuan3d-zombie-assets -p ./output
   ```

## After generation

Unzip `generated_models.zip` — you'll have one `.glb` per concept image
(`zombie.glb`, `building.glb`, `prop.glb`, plus `_textured.glb` versions if
the optional texture-painting step built successfully). These are plain
glTF binary files, importable into any engine (Godot, Unity, Unreal,
Blender, etc.) or viewable directly at https://gltf-viewer.donmccurdy.com/.
