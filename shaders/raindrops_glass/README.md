# Raindrops glass ![Godot v4.3](https://img.shields.io/badge/godot-v4.3-%23478cbf)

https://github.com/user-attachments/assets/8d5d1f6d-a10f-4ed5-bdd2-720b9ecd6b5a

This shader uses a normalmap texture to distort the view and create a raindrops effect. This repo provides 2 ways of generating such a texture.

The first mesh uses an animation created in Blender. The raindrops are represented by Metaball objects, so they merge with each other if they are close enough. The animation was exported as an .ogv file and used as a video texture in Godot.

The second version uses a particle system (with trails enabled) made entirely in Godot. It is rendered in real time in a viewport and used as a viewport texture.

The night environment HDRI is in public domain and can be downloaded from [ambientCG](https://ambientcg.com/view?id=NightEnvironmentHDRI005).
