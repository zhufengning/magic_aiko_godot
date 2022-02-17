shader_type canvas_item;
uniform vec2 mouse_position = vec2(0.0, 0.0);
uniform float length_threshold = 0.0;
uniform float shade_factor = -0.2;

void fragment() {
	float pct = (UV.x - mouse_position.x)+(UV.y - mouse_position.y);
	//distance(UV, mouse_position);
	
	COLOR = texture(TEXTURE, UV);
	
	if (pct < length_threshold) {
		COLOR.rgb = COLOR.rgb * (2.0 - shade_factor);
	}
}