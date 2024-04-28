shader_type spatial;
render_mode cull_disabled;

uniform sampler2D tex;
uniform sampler2D noise;
uniform sampler2D gradient;
uniform float emission_strength = 1.0;
uniform float burn : hint_range(0.0, 1.0, 0.01) = 0.0;

void fragment() {
	vec4 color = texture(tex, UV);
	float noise_value = texture(noise, UV).r * 0.5;
	if (noise_value < burn) {
		float gradient_coord = clamp(burn - noise_value, 0.01, 0.99);
		vec4 gradient_color = texture(gradient, vec2(gradient_coord, 1.0));
		color *= gradient_color;
		float gradient_intensity = (
			abs(gradient_color.r - gradient_color.g) +
			abs(gradient_color.r - gradient_color.b) +
			abs(gradient_color.b - gradient_color.g)
		) / 3.0;
		EMISSION = gradient_color.rgb * gradient_intensity * emission_strength;
	}
	ALBEDO = color.rgb;
	ALPHA = color.a;
}
