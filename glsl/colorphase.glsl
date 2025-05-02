// Author: gre
// License: MIT

// Usage: fromStep and toStep must be in [0.0, 1.0] range 
// and all(fromStep) must be < all(toStep)

uniform vec4 fromStep; // = vec4(0.0, 0.2, 0.4, 0.0)
uniform vec4 toStep; // = vec4(0.6, 0.8, 1.0, 1.0)

uniform float progress;

out vec4 fragColor;

vec4 transition () {
  vec4 a = texture(sTD2DInputs[0] , vUV.st);
  vec4 b = texture(sTD2DInputs[1] , vUV.st);
  return mix(a, b, smoothstep(fromStep, toStep, vec4(progress)));
}

void main()
{
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}