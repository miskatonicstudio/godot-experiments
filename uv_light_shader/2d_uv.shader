shader_type spatial;

uniform sampler2D tex;

void fragment() {
	EMISSION = vec3(0.0, 1.9, 1.9);
	ALPHA = 0.0;
}

void light() {
	vec4 pixel = textureLod(tex, UV, 1.0);
	DIFFUSE_LIGHT = vec3(0.0);
	ALPHA = length(ATTENUATION) * pixel.a;
}