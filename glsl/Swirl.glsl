// License: MIT
// Author: Sergey Kosarevsky
// ( http://www.linderdaum.com )
// ported by gre from https://gist.github.com/corporateshark/cacfedb8cca0f5ce3f7c

uniform float progress;

out vec4 fragColor;

vec4 transition()
{
	float Radius = 1.0;

	float T = progress;

	vec2 UV = vUV.st;
	UV -= vec2( 0.5, 0.5 );

	float Dist = length(UV);

	if ( Dist < Radius )
	{
		float Percent = (Radius - Dist) / Radius;
		float A = ( T <= 0.5 ) ? mix( 0.0, 1.0, T/0.5 ) : mix( 1.0, 0.0, (T-0.5)/0.5 );
		float Theta = Percent * Percent * A * 8.0 * 3.14159;
		float S = sin( Theta );
		float C = cos( Theta );
		UV = vec2( dot(UV, vec2(C, -S)), dot(UV, vec2(S, C)) );
	}
	UV += vec2( 0.5, 0.5 );

	vec4 C0 = texture(sTD2DInputs[0] , UV);
	vec4 C1 = texture(sTD2DInputs[1] , UV);

	return mix( C0, C1, T );
}

void main()
{
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}
