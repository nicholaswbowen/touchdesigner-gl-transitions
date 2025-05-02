// License: MIT
// Author: fkuteken
// ported by gre from https://gist.github.com/fkuteken/f63e3009c1143950dee9063c3b83fb88

uniform vec4 bgcolor; // = vec4(0.0, 0.0, 0.0, 1.0)

uniform float progress;

out vec4 fragColor;

vec2 res = uTD2DInfos[0].res.zw;
float ratio = res.x / res.y;
vec2 ratio2 = vec2(1.0, 1.0 / ratio);
float s = pow(2.0 * abs(progress - 0.5), 3.0);

vec4 transition() {
    vec2 p = vUV.xy/vec2(1.0).xy;
    float dist = length((vec2(p) - 0.5) * ratio2);
    return mix(
        progress < 0.5 ? texture(sTD2DInputs[0], p) : texture(sTD2DInputs[1], p), // branching is ok here as we statically depend on progress uniform (branching won't change over pixels)
        bgcolor,
        step(s, dist));
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}