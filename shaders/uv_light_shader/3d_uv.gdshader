shader_type spatial;

uniform vec4 color: source_color = vec4(0, 1, 1, 1);
uniform float energy: hint_range(0, 16) = 1;

void fragment() {
	EMISSION = color.rgb * energy;
	ALPHA = 0.0;
}

void light() {
	DIFFUSE_LIGHT = vec3(0.0);
	SPECULAR_LIGHT = vec3(0.0);
	ALPHA = ATTENUATION;
	if (ATTENUATION == 1.0) {
		ALPHA = 0.0;
	}
}