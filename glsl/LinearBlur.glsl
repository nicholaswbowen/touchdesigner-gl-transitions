// author: gre
// license: MIT
uniform float intensity; // = 0.1

uniform float progress;

out vec4 fragColor;

const int passes = 6;

vec4 transition() {
    vec4 c1 = vec4(0.0);
    vec4 c2 = vec4(0.0);

    float disp = intensity*(0.5-distance(0.5, progress));
    for (int xi=0; xi<passes; xi++) {
        float x = float(xi) / float(passes) - 0.5;
        for (int yi=0; yi<passes; yi++) {
            float y = float(yi) / float(passes) - 0.5;
            vec2 v = vec2(x,y);
            float d = disp;
            c1 += texture(sTD2DInputs[0], vUV.st + d*v);
            c2 += texture(sTD2DInputs[1],  vUV.st + d*v);
        }
    }
    c1 /= float(passes*passes);
    c2 /= float(passes*passes);
    return mix(c1, c2, progress);
}

void main()
{
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}