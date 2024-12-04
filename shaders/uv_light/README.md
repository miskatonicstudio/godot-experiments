# UV light ![Godot v4.3](https://img.shields.io/badge/godot-v4.3-%23478cbf)

https://github.com/user-attachments/assets/ecf98cf7-b969-48a7-984a-e550e893b2fb

This is an example of a "UV light" effect, useful for secret objects and messages.
It works both with 3D geometry (where the shape is defined by a mesh) and with flat objects (where the shape/pattern is defined by texture's alpha).

Requirements:
* put all secret objects in a separate layer (property `layers`, in this example it's "Layer 2")
* remove that layer from normal light sources (property `light_cull_mask`)
* make sure that UV light sources affect that layer (property `light_cull_mask`)
