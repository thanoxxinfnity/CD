# Hunyuan3D-2 Game Asset Generator

Kaggle notebook that generates 3D game assets (zombie, building, prop) from
scratch: text-to-image for concept art, then Tencent's **Hunyuan3D-2**
model to convert each image into a `.glb` 3D mesh — all running on Kaggle's
free GPU, no paid API involved.

## Structure

- `kaggle/hunyuan3d_generate.ipynb` — the notebook. Generates concept
  images, sets up Hunyuan3D-2, converts each image to a `.glb`, and zips
  the results.
- `kaggle/kernel-metadata.json` — metadata for pushing the notebook via
  the Kaggle CLI (`kaggle kernels push`).
- `kaggle/README.md` — how to run it: either upload it on kaggle.com
  directly (no token needed), or push/pull it with your Kaggle API token
  from the command line.

## Quick start

See `kaggle/README.md`. Short version: upload `hunyuan3d_generate.ipynb`
to a new Kaggle notebook, turn on GPU in the notebook settings, run all
cells, download `generated_models.zip` from the Output tab.
