// Author: paniq
// License: MIT

uniform float progress;

out vec4 fragColor;
uniform float strength; // = 0.1

vec4 transition() {
    vec2 p = vUV.xy / vec2(1.0).xy;
    vec4 ca = texture(sTD2DInputs[0], p);
    vec4 cb = texture(sTD2DInputs[1], p);

    vec2 oa = (((ca.rg + ca.b) * 0.5) * 2.0 - 1.0);
    vec2 ob = (((cb.rg + cb.b) * 0.5) * 2.0 - 1.0);
    vec2 oc = mix(oa, ob, 0.5) * strength;

    float w0 = progress;
    float w1 = 1.0 - w0;
    return mix(texture(sTD2DInputs[0], p + oc * w0), texture(sTD2DInputs[1], p - oc * w1), progress);
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}