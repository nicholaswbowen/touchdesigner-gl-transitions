// Author: gre
// License: MIT

uniform float progress;

out vec4 fragColor;
// Custom parameters
uniform float size; // = 0.2

float rand (vec2 co) {
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

vec4 transition () {
    float r = rand(vec2(0, vUV.y));
    float m = smoothstep(0.0, -size, vUV.x*(1.0-size) + size*r - (progress * (1.0 + size)));
    return mix(
        texture(sTD2DInputs[0] , vUV.st),
        texture(sTD2DInputs[1] , vUV.st),
        m);
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}