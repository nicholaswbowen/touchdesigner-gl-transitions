// Author: Zeh Fernando
// License: MIT

// Definitions --------
#define DEG2RAD 0.03926990816987241548078304229099 // 1/180*PI

// Transition parameters --------

// In degrees
uniform float rotation; // = 6

// Multiplier
uniform float scale; // = 1.2

uniform float progress;

out vec4 fragColor;

vec2 res = uTD2DInfos[0].res.zw;
float ratio = res.x / res.y;

// The code proper --------

vec4 transition() {
    // Massage parameters
    float phase = progress < 0.5 ? progress * 2.0 : (progress - 0.5) * 2.0;
    float angleOffset = progress < 0.5 ? mix(0.0, rotation * DEG2RAD, phase) : mix(-rotation * DEG2RAD, 0.0, phase);
    float newScale = progress < 0.5 ? mix(1.0, scale, phase) : mix(scale, 1.0, phase);

    vec2 center = vec2(0, 0);

    // Calculate the source point
    vec2 assumedCenter = vec2(0.5, 0.5);
    vec2 p = (vUV.xy - vec2(0.5, 0.5)) / newScale * vec2(ratio, 1.0);

    // This can probably be optimized (with distance())
    float angle = atan(p.y, p.x) + angleOffset;
    float dist = distance(center, p);
    p.x = cos(angle) * dist / ratio + 0.5;
    p.y = sin(angle) * dist + 0.5;
    vec4 c = progress < 0.5 ? texture(sTD2DInputs[0], p) : texture(sTD2DInputs[1], p);

    // Finally, apply the color
    return c + (progress < 0.5 ? mix(0.0, 1.0, phase) : mix(1.0, 0.0, phase));
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}