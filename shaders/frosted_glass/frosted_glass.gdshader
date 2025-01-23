shader_type spatial;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D glass_normal : hint_normal;
uniform float distortion_size = 0.2;

void fragment() {
	vec2 d = texture(glass_normal, UV).rg * 2.0 - vec2(1.0);
	ALBEDO = texture(SCREEN_TEXTURE, SCREEN_UV + d * distortion_size).rgb;
}