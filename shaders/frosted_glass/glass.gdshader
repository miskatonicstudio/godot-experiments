shader_type spatial;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D glass;
uniform float distortion_size = 0.2;
uniform float brightness = 4.0;

void fragment() {
	vec2 d = texture(glass, UV).xy - vec2(0.5);
	ALBEDO = texture(SCREEN_TEXTURE, SCREEN_UV + d * distortion_size).rgb * brightness;
}