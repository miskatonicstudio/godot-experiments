shader_type spatial;
render_mode unshaded, vertex_lighting, particle_trails;

uniform float normal_factor = 1.0;

void fragment() {
	ALBEDO = normalize(normal_factor * NORMAL * 0.5 + vec3(0.5));
}