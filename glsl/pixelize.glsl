// Author: gre
// License: MIT
// forked from https://gist.github.com/benraziel/c528607361d90a072e98

uniform ivec2 squaresMin/* = ivec2(20) */; // minimum number of squares (when the effect is at its higher level)
uniform int steps /* = 50 */; // zero disable the stepping

uniform float progress;
out vec4 fragColor;

float d = min(progress, 1.0 - progress);
float dist = steps>0 ? ceil(d * float(steps)) / float(steps) : d;
vec2 squareSize = 2.0 * dist / vec2(squaresMin);

vec4 transition() {
    vec2 p = dist>0.0 ? (floor(vUV.st / squareSize) + 0.5) * squareSize : vUV.st;
    return mix(texture(sTD2DInputs[0], p), texture(sTD2DInputs[1], p), progress);
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}