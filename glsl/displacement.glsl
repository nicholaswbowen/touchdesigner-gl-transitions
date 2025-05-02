// Author: Travis Fischer
// License: MIT
//
// Adapted from a Codrops article by Robin Delaporte
// https://tympanus.net/Development/DistortionHoverEffect

// uniform sampler2D displacementMap

uniform float strength; // = 0.5

uniform float progress;

out vec4 fragColor;

vec4 transition () {
    float displacement = texture(sTD2DInputs[2], vUV.st).r * strength;

    vec2 uvFrom = vec2(vUV.x + progress * displacement, vUV.y);
    vec2 uvTo = vec2(vUV.x - (1.0 - progress) * displacement, vUV.y);

    return mix(
        texture(sTD2DInputs[0], uvFrom),
        texture(sTD2DInputs[1], uvTo),
        progress);
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}