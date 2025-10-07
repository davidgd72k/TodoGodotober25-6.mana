shader_type canvas_item;

uniform sampler2D sampler_tex: filter_nearest;
uniform float alpha_transparency: hint_range(0.0, 1.0) = 1.0;
uniform float alpha_threshold: hint_range(0.0, 1.0) = 1.0;
uniform vec4 mix_color: source_color;

// Wavy uniforms.
uniform float wave_x_amp: hint_range(0.0, 1.0) = 0.1;
uniform float wave_y_amp: hint_range(0.0, 1.0) = 0.1;
uniform float wave_x_freq: hint_range(0.0, 20.0) = 5.0;
uniform float wave_y_freq: hint_range(0.0, 20.0) = 5.0;
uniform vec2 wave_speed = vec2(1.0, 1.0);

void vertex() {
	// Called for every vertex the material is visible on.
	// Vertex don't show effect very good in 2D.
}

vec2 waving(vec2 uv_coord, vec2 wave_freq, vec2 wave_amp) {
	vec2 wave;
	wave.x = sin(uv_coord.y * wave_freq.x + TIME * wave_speed.x) * wave_amp.x;
	wave.y = cos(uv_coord.x * wave_freq.y + TIME * wave_speed.y) * wave_amp.y;
	
	return wave;
}

void fragment() {
	// Applying wavy effect to texture UV;
	vec2 wave_frequency = vec2(wave_x_freq, wave_y_freq);
	vec2 wave_amplitude = vec2(wave_x_amp, wave_y_amp);
	vec2 uv_coord = UV;
	
	uv_coord += waving(uv_coord, wave_frequency, wave_amplitude);;
	uv_coord = clamp(uv_coord, vec2(0.0), vec2(1.0));
	
	// Applying pixel color effects.
	vec4 color = texture(sampler_tex, uv_coord);
	float avg = (color.r + color.g + color.b) / 3.0;
    color.rgb = vec3(avg);
	color.rgb = mix(color.rgb, mix_color.rgb, 0.5);
	
	if (color.a > alpha_threshold) {
		color.a = alpha_transparency;
	}
	
	//color.rgb = mix(color.rgb, mix_color.rgb, 1.0);
	//color.a = alpha_transparency;
	
	COLOR = color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
