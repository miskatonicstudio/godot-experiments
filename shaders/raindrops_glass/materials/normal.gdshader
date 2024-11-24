// This shader generates a normal map output based on geometry
shader_type spatial;
render_mode unshaded, particle_trails;


void fragment() {
	vec3 normal = NORMAL * 0.5 + vec3(0.5, 0.5, 0.5);
	// convert linear to sRGB
	ALBEDO = pow((normal + vec3(0.055)) / vec3(1.055), vec3(2.4));
}