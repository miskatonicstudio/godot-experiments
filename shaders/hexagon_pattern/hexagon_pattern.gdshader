shader_type spatial;
render_mode unshaded;

uniform float scale = 8.0;
uniform float radius = 1.0;
uniform float offset = 0.268;
uniform float cutoff = 0.0;
uniform float falloff = 4.0;
uniform bool hide_incomplete = false;
uniform vec4 color : source_color = vec4(0.05, 0.4, 0.75, 1.0);

float hex_distance(float hex_radius, vec2 local_point) {
	const vec2 AXIS[3] = {
		vec2(sqrt(3) * 0.5, 0.5),
		vec2(0.0, 1.0),
		vec2(-sqrt(3) * 0.5, 0.5)
	};
	float max_r = 0.0;
	for (int i = 0; i < 3; i++) {
		float r = dot(local_point, AXIS[i]);
		r /= (sqrt(3) * 0.5 * hex_radius);
		max_r = max(max_r, abs(r));
	}
	return max_r;
}

float snap_to_center(float local_coord, float hex_radius) {
	return float(floor((local_coord + hex_radius)/(2.0 * hex_radius))) * 2.0 * hex_radius;
}

vec2 calculate_local_center(vec2 uv, float r) {
	float y_coord_1 = snap_to_center(uv.y, r);
	float x_coord_1 = snap_to_center(uv.x, r * sqrt(3));
	vec2 point_1 = vec2(x_coord_1, y_coord_1);
	
	float x_coord_2 = snap_to_center(uv.x - r * sqrt(3), r * sqrt(3));
	float y_coord_2 = snap_to_center(uv.y - r, r);
	vec2 point_2 = vec2(x_coord_2, y_coord_2) + vec2(r * sqrt(3), r);
	
	if (length(uv - point_1) < length(uv - point_2)) {
		return point_1;
	} else {
		return point_2;
	}
}

void fragment() {
	vec2 uv = (UV - vec2(0.5, 0.5)) * scale;
	float r = (radius * sqrt(3) + offset)/2.0;
	vec2 local_center = calculate_local_center(uv, r);
	vec2 local_coords = uv - local_center;
	
	if (hide_incomplete && (
			abs(local_center.x) > scale/2.0 - radius ||
			abs(local_center.y) > scale/2.0 - radius * sqrt(3)
		)
	) {
		ALPHA = 0.0;
	} else if (hex_distance(radius, local_coords) <= 1.0) {
		float d = hex_distance(radius, local_coords);
		if (d < cutoff) {
			d = 0.0;
		}
		d = pow(d, falloff);
		ALBEDO = color.rgb;
		ALPHA = d;
	} else {
		ALPHA = 0.0;
	}
}