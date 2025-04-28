// Author: Fabien Benetou
// License: MIT

uniform float progress;

out vec4 fragColor;

vec4 transition () {

  float t = progress;
  if (mod(floor(vUV.y*100.*progress),2.)==0.)
    t*=2.-.5;
  
  return mix(
    texture(sTD2DInputs[0] , vUV.st),
    texture(sTD2DInputs[1], vUV.st),
    mix(t, progress, smoothstep(0.8, 1.0, progress))
  );
}

void main()
{
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}