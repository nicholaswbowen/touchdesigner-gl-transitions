// author: gre
// License: MIT
uniform vec3 color;// = vec3(0.0)
uniform float colorPhase/* = 0.4 */; // if 0.0, there is no black phase, if 0.9, the black phase is very important
uniform float progress;

out vec4 fragColor;

vec4 transition () {
  return mix(
    mix(vec4(color, 1.0), texture(sTD2DInputs[0] , vUV.st), smoothstep(1.0-colorPhase, 0.0, progress)),
    mix(vec4(color, 1.0), texture(sTD2DInputs[1] , vUV.st), smoothstep(    colorPhase, 1.0, progress)),
    progress);
}

void main()
{
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}