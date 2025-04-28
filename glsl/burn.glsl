// author: gre
// License: MIT
uniform vec4 color;
uniform float progress;

out vec4 fragColor;

vec4 transition () {

    vec4 from = texture(sTD2DInputs[0] , vUV.st) + vec4(progress*color);
    vec4 to = texture(sTD2DInputs[1], vUV.st) + vec4((1.0-progress)*color);

    return mix(
      from,
      to,
      progress
    );
}

void main()
{
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}
