// Author: Fernando Kuteken
// License: MIT

#define PI 3.141592653589

uniform float startingAngle; // = 90;

uniform float progress;

out vec4 fragColor;

vec4 transition () {
  
  float offset = startingAngle * PI / 180.0;
  float angle = atan(vUV.y - 0.5, vUV.x - 0.5) + offset;
  float normalizedAngle = (angle + PI) / (2.0 * PI);
  
  normalizedAngle = normalizedAngle - floor(normalizedAngle);

  return mix(
    texture(sTD2DInputs[0] , vUV.st),
    texture(sTD2DInputs[1] , vUV.st),
    step(normalizedAngle, progress)
    );
}

void main()
{
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}
