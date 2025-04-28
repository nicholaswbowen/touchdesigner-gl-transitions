// author: bobylito
// license: MIT
const float SQRT_2 = 1.414213562373;
uniform float dots;// = 20.0;
uniform vec2 center;// = vec2(0, 0);

uniform float progress;

out vec4 fragColor;

vec4 transition() {
  bool nextImage = distance(fract(vUV.st * dots), vec2(0.5, 0.5)) < ( progress / distance(vUV.st, center));
  return nextImage ? texture(sTD2DInputs[1], vUV.st) : texture(sTD2DInputs[0], vUV.st);
}

void main()
{
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}


