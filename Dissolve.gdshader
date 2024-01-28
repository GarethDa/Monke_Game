shader_type spatial;

uniform sampler2D tex;
uniform sampler2D noise;
uniform float amt;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = texture(tex,UV).rgb;
	float a = texture(noise,UV).r;
	if (a < amt){
		ALPHA = 0.f;
		}
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
