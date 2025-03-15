shader_type canvas_item;
uniform float speed = 2.0;
uniform float dist = 20.0;
uniform float offset = 0.5;

void vertex(){
	VERTEX.x += sin((TIME+offset)*speed) * dist * (UV.y - 1.0);
}