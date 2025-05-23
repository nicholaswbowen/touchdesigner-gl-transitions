// License: MIT
// Author: pthrasher
// adapted by gre from https://gist.github.com/pthrasher/04fd9a7de4012cbb03f6

uniform vec2 center; // = vec2(0.5)
uniform float threshold; // = 3.0
uniform float fadeEdge; // = 0.1

uniform float progress;

out vec4 fragColor;

float rand(vec2 co) {
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}
vec4 transition() {
    vec2 p = vUV.xy/vec2(1.0).xy;
    float dist = distance(center, p) / threshold;
    float r = progress - min(rand(vec2(p.y, 0.0)), rand(vec2(0.0, p.x)));
    return mix(texture(sTD2DInputs[0], p), texture(sTD2DInputs[1], p), mix(0.0, mix(step(dist, r), 1.0, smoothstep(1.0-fadeEdge, 1.0, progress)), smoothstep(0.0, fadeEdge, progress)));
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}