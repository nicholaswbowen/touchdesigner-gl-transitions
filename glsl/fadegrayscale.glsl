// Author: gre
// License: MIT

uniform float intensity; // = 0.3; // if 0.0, the image directly turn grayscale, if 0.9, the grayscale transition phase is very important
 
vec3 grayscale (vec3 color) {
  return vec3(0.2126*color.r + 0.7152*color.g + 0.0722*color.b);
}
 
uniform float progress;

out vec4 fragColor;

vec4 transition () {
  vec4 fc = texture(sTD2DInputs[0] , vUV.st);
  vec4 tc = texture(sTD2DInputs[1] , vUV.st);
  return mix(
    mix(vec4(grayscale(fc.rgb), 1.0), fc, smoothstep(1.0-intensity, 0.0, progress)),
    mix(vec4(grayscale(tc.rgb), 1.0), tc, smoothstep(    intensity, 1.0, progress)),
    progress);
}

void main()
{
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}