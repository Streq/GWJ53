shader_type canvas_item;
uniform int palette_size = 4;
uniform float offset : hint_range(0, 8, 1);
uniform sampler2D palette;
uniform float blue_index_offset = 0.0;


void fragment(){
	vec4 screen_tex = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec4 tex = texture(TEXTURE, UV);
	//used as index for the palette texture
	float blue_1 = screen_tex.b;
	
	float palette_index = mod(blue_1 * (255.0) - blue_index_offset + offset+0.5,float(palette_size));
	float h_pixel_size = 1.0/float(palette_size);
	vec2 palette_pixel = vec2(palette_index*(h_pixel_size), 0.0);
	
	COLOR.rgb = mix(screen_tex.rgb,texture(palette, palette_pixel).rgb,tex.a);

	COLOR.a = tex.a;
//	COLOR.rgb = vec3(1.0);
	
}