shader_type spatial;

uniform sampler2D grass;
uniform sampler2D rock;

uniform float mix_amount;
uniform float transition;

void vertex() {
	COLOR = vec4(NORMAL, 0);
}

void fragment() {
	float mixval = clamp(pow(COLOR.y / mix_amount, transition), 0, 1);
	ALBEDO = mix(texture(rock, UV).rgb, texture(grass, UV).rgb, mixval);
}