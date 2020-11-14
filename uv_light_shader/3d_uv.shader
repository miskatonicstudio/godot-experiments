shader_type spatial;

uniform vec4 color: hint_color = vec4(0, 1, 1, 1);
uniform float energy: hint_range(0, 16) = 1;

void fragment() {
	EMISSION = color.rgb * energy;
	ALPHA = 0.0;
}

void light() {
	DIFFUSE_LIGHT = vec3(0.0);
	SPECULAR_LIGHT = vec3(0.0);
	ALPHA = length(ATTENUATION);
}