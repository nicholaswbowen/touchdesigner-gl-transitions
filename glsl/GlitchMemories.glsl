// author: Gunnar Roth
// based on work from natewave
// license: MIT

uniform float progress;

out vec4 fragColor;

vec4 transition() {
    vec2 p = vUV.xy/vec2(1.0).xy;
    vec2 block = floor(p.xy / vec2(16));
    vec2 uv_noise = block / vec2(64);
    uv_noise += floor(vec2(progress) * vec2(1200.0, 3500.0)) / vec2(64);
    vec2 dist = progress > 0.0 ? (fract(uv_noise) - 0.5) * 0.3 *(1.0 -progress) : vec2(0.0);
    vec2 red = p + dist * 0.2;
    vec2 green = p + dist * .3;
    vec2 blue = p + dist * .5;

    return vec4(mix(texture(sTD2DInputs[0], red), texture(sTD2DInputs[1], red), progress).r,mix(texture(sTD2DInputs[0], green), texture(sTD2DInputs[1], green), progress).g,mix(texture(sTD2DInputs[0], blue), texture(sTD2DInputs[1], blue), progress).b,1.0);
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}