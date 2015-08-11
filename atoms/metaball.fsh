#define M_PI 3.1415926535897932384626433832795

float random( vec2 p )
{
    // We need irrationals for pseudo randomness.
    // Most (all?) known transcendental numbers will (generally) work.
    const vec2 r = vec2(
                        23.1406926327792690,  // e^pi (Gelfond's constant)
                        2.6651441426902251); // 2^sqrt(2) (Gelfond–Schneider constant)
    return fract( cos( mod( 123456789., 1e-7 + 256. * dot(p,r) ) ) );
}


void main(void) {
    vec4 color = texture2D(u_texture,v_tex_coord);
    
    // metaballs here
    if (color.x > 0.6 ) {
        float dist = float(color.x);
        //color.xyz = vec3(0.2, 0.2, 0.5);
        float a = random(vec2(color.x * sin(u_time * 0.00001), color.y* cos(u_time * 0.00001 + M_PI)) );
        //color.xyz = vec3(0.0);
        
        // create rings
        if (dist > 0.92) {
            color.xyz =vec3(0.6, 0.6, 0.3);
        }else if (dist > 0.75){
            color.xyz = vec3(0.0);
        }else if (dist > 0.65){
            color.xyz =vec3(a);
        }else if (dist > 0.62){
            color.xyz = vec3(0.0);
        }else{
            color.xyz =vec3(a);
        }
    }else{
        //outer glow
        float c = pow(color.x , 4.0);
        //color.xyz = vec3(pow(color.x , 8.0), pow(color.x , 8.0), pow(color.x * 1.5, 12.0)) ;
        color.xyz = vec3(2.0 * c, 2.0 * c, 5.0 *  c);
    }

    gl_FragColor =  color;
   
  
}

