shader_type canvas_item;

uniform sampler2D noise;
uniform float speed = 0.1;
uniform float scale = 0.5;

void fragment() {
	vec2 uv_offset = (
		texture(noise, SCREEN_UV + vec2(TIME * speed, 0.0)).rb - 
		texture(noise, SCREEN_UV + vec2(0.0, TIME * speed)).rb
	);
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV + uv_offset * scale);
}