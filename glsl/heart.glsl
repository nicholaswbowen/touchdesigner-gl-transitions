// Author: gre
// License: MIT


uniform float progress;

out vec4 fragColor;

float inHeart (vec2 p, vec2 center, float size) {
  if (size==0.0) return 0.0;
  vec2 o = (p-center)/(1.6*size);
  float a = o.x*o.x+o.y*o.y-0.3;
  return step(a*a*a, o.x*o.x*o.y*o.y*o.y);
}
vec4 transition () {
  return mix(
    texture(sTD2DInputs[0], vUV.st),
    texture(sTD2DInputs[1], vUV.st),
    inHeart(vUV.st, vec2(0.5, 0.4), progress)
  );
}

void main()
{
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}




