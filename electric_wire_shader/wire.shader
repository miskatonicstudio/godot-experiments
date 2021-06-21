shader_type spatial;

uniform float width : hint_range(0, 1) = 0.05;
uniform float speed = 0.5;
uniform vec4 color : hint_color;

void fragment() {
	EMISSION = color.rgb * 1.6;
	float uv = UV.y - TIME * speed + float(int(TIME * speed));
	if (uv > 0.0 && uv < width) {
		ALPHA = 1.0;
	} else {
		ALPHA = 0.0;
	}
}