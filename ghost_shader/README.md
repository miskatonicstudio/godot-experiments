# Ghost shader

![Screenshot](./screenshot.png?raw=true)

A shader that randomly deforms a mesh and applies an emission lighting based on the Fresnel effect.
Combined with an animated alpha value which makes the "ghost" appear and disappear.

The texture used in this example is a seamless `NoiseTexture` with `OpenSimplexNoise`, offered by Godot Engine out-of-the-box.
The mesh is a `SphereMesh`, but it should work with other geometries as well.
