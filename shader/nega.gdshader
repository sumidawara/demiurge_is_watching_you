shader_type canvas_item;

uniform sampler2D screen_texture:hint_screen_texture, repeat_disable, filter_nearest;

uniform vec2 center_pos;
uniform float inside_radius;
uniform float outside_radius;
uniform float display_ratio;

void fragment() {
	vec4 color = texture(screen_texture, SCREEN_UV);
	
	vec2 center_pos2 = vec2(0.5 + (center_pos.x-0.5) / display_ratio, center_pos.y);
	
	vec2 scaleUV = (SCREEN_UV - vec2(0.5, 0.0) ) / vec2(display_ratio, 1.0) + vec2(0.5, 0.0);
	
	float dist = length(center_pos - scaleUV);
	
	if(inside_radius < dist && dist < outside_radius){
		color.rgb = vec3(1.0f - color.r, 1.0f - color.g, 1.0f - color.b);
	}
	COLOR = color;
}