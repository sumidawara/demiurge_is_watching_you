shader_type canvas_item;

uniform sampler2D screen_texture:hint_screen_texture, repeat_disable, filter_nearest;

uniform float threshold = 0.5;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	
	float brightness = ( color.r + color.g + color.b ) / 3.0;
	
	if(brightness > threshold)
	{
		color.rgb = vec3(0.0);
	}
	else
	{
		color.rgb = vec3(1.0);
	}
	
	COLOR = color;
}
