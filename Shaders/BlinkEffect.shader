shader_type canvas_item;

// uniform eh como um export no gdscript
uniform bool active = false;

// Fragment atua em cada pixel da imagem, eh um for loop basicamente
void fragment() {
	// TEXTURE é a textura do sprite em questão
	// UV é a posição (x,y) do algum ponto do sprite
	vec4 previous_color = texture(TEXTURE, UV);
	vec4 white_color = vec4(1.0,1.0,1.0,previous_color.a);
	vec4 new_color = previous_color;
	if(active == true) {
		new_color = white_color;
	}
	// COLOR seta a cor do pixel utilizando um vec4(R,G,B,A)
	COLOR = new_color;
}