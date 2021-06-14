shader_type spatial;

// Scale of deformation
uniform float height_scale = 0.5;
// Noise texture, OpenSimplexNoise works very well
uniform sampler2D noise;
// The transparency of the entire ghost (set to 0.0 to hide it completely)
uniform float alpha : hint_range(0, 1) = 1.0;
// Emission light color
uniform vec4 color : hint_color = vec4(0.0, 1.0, 1.0, 1.0);

float fresnel(float amount, vec3 normal, vec3 view)
{
	return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0 )), amount);
}

void vertex() {
	// Deform the vertices using the noise texture
	vec2 tex_position = VERTEX.xy / 2.0 + 0.5 + 0.3 * TIME;
	float height = texture(noise, tex_position).x;
	VERTEX = VERTEX * (1.0 + height * height_scale);
	// Set billboard mode, with scale (requires a camera to work)
	MODELVIEW_MATRIX = INV_CAMERA_MATRIX * mat4(
		CAMERA_MATRIX[0],CAMERA_MATRIX[1],CAMERA_MATRIX[2],WORLD_MATRIX[3]
	);
	MODELVIEW_MATRIX = MODELVIEW_MATRIX * mat4(
		vec4(length(WORLD_MATRIX[0].xyz), 0.0, 0.0, 0.0),
		vec4(0.0, length(WORLD_MATRIX[1].xyz), 0.0, 0.0),
		vec4(0.0, 0.0, length(WORLD_MATRIX[2].xyz), 0.0),
		vec4(0.0, 0.0, 0.0, 1.0)
	);
}

void fragment() {
	float basic_fresnel = fresnel(3.0, NORMAL, VIEW);
	EMISSION = color.xyz * basic_fresnel * 2.0;
	ALPHA = basic_fresnel * alpha;
}