shader_type canvas_item;

uniform vec2 frequency = vec2(1.0, 0.0);
uniform vec2 amplitude = vec2(1.0, 0.0);
uniform vec2 speed = vec2(1.0, 0.0);

uniform sampler2D tex: repeat_disable;


void vertex() {
	// Called for every vertex the material is visible on.
	//VERTEX.x += sin((UV.y - TIME * speed) * freq_x) * amp_x * UV.y;
}

void fragment() {
	vec2 pos = clamp(mod(
		(UV - amplitude * sin(TIME + vec2(UV.y, UV.x) * speed)) 
		/ TEXTURE_PIXEL_SIZE, 1.0 / TEXTURE_PIXEL_SIZE) 
		* TEXTURE_PIXEL_SIZE, 0.0, 1.0);
	COLOR = texture(tex, pos);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
/*vec2 pos = mod((UV - amplitutde * sin(TIME + vec2(UV.y, UV.x) * speed)) / TEXTURE_PIXEL_SIZE,
			1.0 / TEXTURE_PIXEL_SIZE) * TEXTURE_PIXEL_SIZE;
	COLOR = texture(TEXTURE, pos);*/