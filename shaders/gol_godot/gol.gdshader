shader_type canvas_item;

uniform sampler2D gol;

void fragment() {
	vec2 uv = SCREEN_UV;
	COLOR = texture(gol, uv);
	
	if (COLOR.b > 0.2 && COLOR.b < 0.8) {
		// This is the first iteration, convert the initial_texture
		COLOR = texture(TEXTURE, uv);
		// The initial noise texture uses grayscale, convert to black and white
		if (COLOR.b > 0.5) {
			COLOR.rgb = vec3(1.0);
		} else {
			COLOR.rgb = vec3(0.0);
		}
	} else {
		// This is every other iteration, use the results of the previous one
		vec2 ps = TEXTURE_PIXEL_SIZE;
		
		int neighbors = 0;
		for (float x = -ps.x; x <= ps.x; x += ps.x) {
			for (float y = -ps.y; y <= ps.y; y += ps.y) {
				vec2 new_uv = uv + vec2(x, y);
				vec4 new_pixel = texture(gol, new_uv);
				
				// Check if the pixel is not outside of the texture
				if (
					new_uv.x == clamp(new_uv.x, 0.0, 1.0) && 
					new_uv.y == clamp(new_uv.y, 0.0, 1.0)
				) {
					if (new_pixel.b > 0.5) {
						neighbors += 1;
					}
				}
			}
		}
		// If the original pixel is set, don't include it as a neighbor
		if (COLOR.b > 0.5) {
			neighbors -= 1;
		}
		float color = 0.0;
		
		if (COLOR.b > 0.5) {
			if (neighbors == 2 || neighbors == 3) {
				color = 1.0;
			}
		} else {
			if (neighbors == 3) {
				color = 1.0;
			}
		}
		COLOR.rgb = vec3(color);
	}
}