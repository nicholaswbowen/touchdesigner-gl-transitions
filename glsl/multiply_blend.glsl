// Author: Fernando Kuteken
// License: MIT

uniform float progress;

out vec4 fragColor;

vec4 blend(vec4 a, vec4 b) {
  return a * b;
}

vec4 transition () {
  
  vec4 blended = blend(texture(sTD2DInputs[0], vUV.st), texture(sTD2DInputs[1], vUV.st));
  
  if (progress < 0.5)
    return mix(texture(sTD2DInputs[0], vUV.st), blended, 2.0 * progress);
  else
    return mix(blended, texture(sTD2DInputs[1], vUV.st), 2.0 * progress - 1.0);
}

void main()
{
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}


