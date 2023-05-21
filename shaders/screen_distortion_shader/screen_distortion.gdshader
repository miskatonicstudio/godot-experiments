shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
uniform sampler2D noise : repeat_enable, filter_linear_mipmap;
uniform float speed = 0.1;
uniform float scale = 0.5;

uniform float BIAS = 1.0;

void fragment() {
	vec2 uv_offset = (
		texture(noise, SCREEN_UV + vec2(TIME * speed, 0.0), BIAS).rb - 
		texture(noise, SCREEN_UV + vec2(0.0, TIME * speed), BIAS).rb
	);
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV + uv_offset * scale);
}