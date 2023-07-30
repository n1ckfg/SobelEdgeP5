uniform sampler2D tex0;
uniform vec2 iResolution;

mat3 sx = mat3( 
    1.0, 2.0, 1.0, 
    0.0, 0.0, 0.0, 
   -1.0, -2.0, -1.0 
);

mat3 sy = mat3( 
    1.0, 0.0, -1.0, 
    2.0, 0.0, -2.0, 
    1.0, 0.0, -1.0 
);

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord.xy / iResolution.xy;
    //uv = vec2(uv.x, abs(1.0 - uv.y));
    vec3 texColor = texture2D(tex0, uv).xyz;

    mat3 I;
    for (int i=0; i<3; i++) {
        for (int j=0; j<3; j++) {
            vec3 col2 = texelFetch(tex0, ivec2(fragCoord) + ivec2(i-1, j-1), 0).rgb;
            I[i][j] = length(col2); 
    	}
	}

	float gx = dot(sx[0], I[0]) + dot(sx[1], I[1]) + dot(sx[2], I[2]); 
	float gy = dot(sy[0], I[0]) + dot(sy[1], I[1]) + dot(sy[2], I[2]);

	float g = sqrt(pow(gx, 2.0) + pow(gy, 2.0));
	//fragColor = vec4(texColor - vec3(g), 1.0);
	fragColor = vec4(vec3(1,1,1) - vec3(g), 1.0);
} 

void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy);
}
