// Author: gre
// License: MIT
uniform float progress;

out vec4 fragColor;
uniform float size; // = 0.04
uniform float zoom; // = 50.0
uniform float colorSeparation; // = 0.3

vec4 transition() {
    vec2 p = vUV.xy/vec2(1.0).xy;
    float inv = 1. - progress;
    vec2 disp = size*vec2(cos(zoom*p.x), sin(zoom*p.y));
    vec4 texTo = texture(sTD2DInputs[1], p + inv*disp);
    vec4 texFrom = vec4(
        texture(sTD2DInputs[0],p + progress*disp*(1.0 - colorSeparation)).r,
        texture(sTD2DInputs[0],p + progress*disp).g,
        texture(sTD2DInputs[0],p + progress*disp*(1.0 + colorSeparation)).b,
        1.0);
    return texTo*progress + texFrom*inv;
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}