shader_type spatial;
render_mode unshaded, cull_disabled;

uniform int flag_type : hint_range(0, 3);

void vertex() {
	VERTEX.z = 0.05 * sin(VERTEX.x * 4.0 + TIME * 3.0);
}

vec3 color_pride(vec2 uv) {
	if (uv.y < 1.0/6.0) {
		return vec3(237.0/255.0, 34.0/255.0, 37.0/255.0);
	}
	else if (1.0/6.0 < uv.y && uv.y < 2.0/6.0) {
		return vec3(249.0/255.0, 150.0/255.0, 33.0/255.0);
	}
	else if (2.0/6.0 < uv.y && uv.y < 3.0/6.0) {
		return vec3(241.0/255.0, 234.0/255.0, 26.0/255.0);
	}
	else if (3.0/6.0 < uv.y && uv.y < 4.0/6.0) {
		return vec3(12.0/255.0, 155.0/255.0, 73.0/255.0);
	}
	else if (4.0/6.0 < uv.y && uv.y < 5.0/6.0) {
		return vec3(57.0/255.0, 84.0/255.0, 165.0/255.0);
	}
	else {
		return vec3(147.0/255.0, 40.0/255.0, 142.0/255.0);
	}
}

vec3 color_trans(vec2 uv) {
	if (uv.y < 1.0/5.0 || uv.y > 4.0/5.0) {
		return vec3(91.0/255.0, 206.0/255.0, 250.0/255.0);
	}
	else if (uv.y < 2.0/5.0 || uv.y > 3.0/5.0) {
		return vec3(245.0/255.0, 168.0/255.0, 184.0/255.0);
	} else {
		return vec3(1);
	}
	return vec3(1,1,0);
}

vec3 color_asexual(vec2 uv) {
	if (uv.y < 1.0/4.0) {
		return vec3(0);
	} else if (1.0/4.0 < uv.y && uv.y < 2.0/4.0) {
		return vec3(162.0/255.0, 162.0/255.0, 162.0/255.0);
	} else if (2.0/4.0 < uv.y && uv.y < 3.0/4.0) {
		return vec3(1.0);
	} else {
		return vec3(127.0/255.0, 1.0/255.0, 127.0/255.0);
	}
}

vec3 color_progressive(vec2 uv) {
	vec3 color = vec3(0.0);
	if (uv.y < 1.0/6.0) {
		color = vec3(237.0/255.0, 34.0/255.0, 37.0/255.0);
	}
	else if (1.0/6.0 < uv.y && uv.y < 2.0/6.0) {
		color = vec3(249.0/255.0, 150.0/255.0, 33.0/255.0);
	}
	else if (2.0/6.0 < uv.y && uv.y < 3.0/6.0) {
		color = vec3(241.0/255.0, 234.0/255.0, 26.0/255.0);
	}
	else if (3.0/6.0 < uv.y && uv.y < 4.0/6.0) {
		color = vec3(12.0/255.0, 155.0/255.0, 73.0/255.0);
	}
	else if (4.0/6.0 < uv.y && uv.y < 5.0/6.0) {
		color = vec3(57.0/255.0, 84.0/255.0, 165.0/255.0);
	}
	else {
		color = vec3(147.0/255.0, 40.0/255.0, 142.0/255.0);
	}
	if (uv.y > -0.25 + 2.0 * uv.x && uv.y < 1.25 -2.0 * uv.x) {
		color = vec3(0);
	}
	if (uv.y > -0.125 + 2.0 * uv.x && uv.y < 1.125 -2.0 * uv.x) {
		color = vec3(104.0/255.0, 54.0/255.0, 3.0/255.0);
	}
	if (uv.y > 0.0 + 2.0 * uv.x && uv.y < 1.0 -2.0 * uv.x) {
		color = vec3(91.0/255.0, 206.0/255.0, 250.0/255.0);
	}
	if (uv.y > 0.125 + 2.0 * uv.x && uv.y < 0.875 -2.0 * uv.x) {
		color = vec3(245.0/255.0, 168.0/255.0, 184.0/255.0);
	}
	if (uv.y > 0.25 + 2.0 * uv.x && uv.y < 0.75 -2.0 * uv.x) {
		color = vec3(1.0);
	}
	
	return color;
}

void fragment() {
	vec3 color = vec3(0);
	switch(flag_type) {
		case 0:
			color = color_pride(UV);
			break;
		case 1:
			color = color_trans(UV);
			break;
		case 2:
			color = color_asexual(UV);
			break;
		case 3:
			color = color_progressive(UV);
			break;
	}
	ALBEDO = color;
}