// Author: gre
// License: MIT
uniform float amplitude; // = 100.0
uniform float speed; // = 50.0

uniform float progress;

out vec4 fragColor;

vec4 transition () {
    vec2 dir = vUV.st - vec2(.5);
    float dist = length(dir);
    vec2 offset = dir * (sin(progress * dist * amplitude - progress * speed) + .5) / 30.;
    return mix(
        texture(sTD2DInputs[1] ,vUV.st + offset),
        texture(sTD2DInputs[1] , vUV.st),
        smoothstep(0.2, 1.0, progress));
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}