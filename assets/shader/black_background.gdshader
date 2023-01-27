shader_type canvas_item;

void fragment(){
	vec4 tex = texture(TEXTURE,UV);
	COLOR.rgb = tex.rgb*tex.a;
//	if (tex.a != 0.0){
//		COLOR.rgba = tex;
//	}else{
//		vec4 tex_left = texture(TEXTURE,UV+vec2(-TEXTURE_PIXEL_SIZE.x,0.0));
////		vec4 tex_right = texture(TEXTURE,UV+vec2(TEXTURE_PIXEL_SIZE.x,0.0));
//		vec4 tex_up = texture(TEXTURE,UV+vec2(0.0, -TEXTURE_PIXEL_SIZE.y));
////		vec4 tex_down = texture(TEXTURE,UV+vec2(0.0, TEXTURE_PIXEL_SIZE.y));
//		COLOR.rgb = vec3(0.0);
//
//		COLOR.a = tex_left.a+tex_up.a;
//
//	}
	
	
	
	
	
}