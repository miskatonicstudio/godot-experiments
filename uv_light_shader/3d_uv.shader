shader_type spatial;

void fragment() {
	EMISSION = vec3(0.0, 0.4, 0.4);
	ALPHA = 0.0;
}

void light() {
	DIFFUSE_LIGHT = vec3(0.0);
	SPECULAR_LIGHT = vec3(0.0);
	ALPHA = length(ATTENUATION);
}