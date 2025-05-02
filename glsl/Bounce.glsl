// Author: Adrian Purser
// License: MIT

uniform vec4 shadow_colour; // = vec4(0.,0.,0.,.6)
uniform float shadow_height; // = 0.075
uniform float bounces; // = 3.0
uniform float progress;

out vec4 fragColor;

const float PI = 3.14159265358;

vec4 transition () {
  float time = progress;
  float stime = sin(time * PI / 2.);
  float phase = time * PI * bounces;
  float y = (abs(cos(phase))) * (1.0 - stime);
  float d = vUV.y - y;
  return mix(
    mix(
      texture(sTD2DInputs[1], vUV.st),
      shadow_colour,
      step(d, shadow_height) * (1. - mix(
        ((d / shadow_height) * shadow_colour.a) + (1.0 - shadow_colour.a),
        1.0,
        smoothstep(0.95, 1., progress) // fade-out the shadow at the end
      ))
    ),
    texture(sTD2DInputs[0], vec2(vUV.x, vUV.y + (1.0 - y))),
    step(d, 0.0)
  );
}


void main()
{
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}