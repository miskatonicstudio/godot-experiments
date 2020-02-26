shader_type spatial;
render_mode unshaded, depth_test_disable;

uniform sampler2D tex;

void fragment() {
	vec3 c = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
	
//	ALBEDO.rgb = texture(tex, SCREEN_UV).rgb;
	
	if (c.r >= 0.99 && c.g <= 0.01 && c.b >= 0.99) {
		ALBEDO.rgb = texture(tex, SCREEN_UV).rgb;
	} else {
		ALPHA = 0.0;
	}
}