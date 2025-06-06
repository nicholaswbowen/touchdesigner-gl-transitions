// Author: mandubian
// License: MIT

uniform float progress;

out vec4 fragColor;

uniform float amplitude; // = 1.0
uniform float waves; // = 30.0
uniform float colorSeparation; // = 0.3
float PI = 3.14159265358979323846264;
float compute(vec2 p, float progress, vec2 center) {
    vec2 o = p*sin(progress * amplitude)-center;
    // horizontal vector
    vec2 h = vec2(1., 0.);
    // butterfly polar function (don't ask me why this one :))
    float theta = acos(dot(o, h)) * waves;
    return (exp(cos(theta)) - 2.*cos(4.*theta) + pow(sin((2.*theta - PI) / 24.), 5.)) / 10.;
}
vec4 transition() {
    vec2 p = vUV.xy / vec2(1.0).xy;
    float inv = 1. - progress;
    vec2 dir = p - vec2(.5);
    float dist = length(dir);
    float disp = compute(p, progress, vec2(0.5, 0.5)) ;
    vec4 texTo = texture(sTD2DInputs[1], p + inv*disp);
    vec4 texFrom = vec4(
        texture(sTD2DInputs[0], p + progress*disp*(1.0 - colorSeparation)).r,
        texture(sTD2DInputs[0], p + progress*disp).g,
        texture(sTD2DInputs[0], p + progress*disp*(1.0 + colorSeparation)).b,
        1.0);
    return texTo*progress + texFrom*inv;
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}