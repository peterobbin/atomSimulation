
float plot(vec2 st, float pct){
    return  smoothstep( pct-0.02, pct, st.y) -
    smoothstep( pct, pct+0.02, st.y);
}


void main(void) {
    vec4 color = texture2D(u_texture,v_tex_coord);
    
    
    if (color.x > 0.6 ) {
        color.xyz = vec3(0.2, 0.2, 0.5);
        //color.xyz = vec3(0.0);
        
    }else{
        float c = pow(color.x , 4.0);
        //color.xyz = vec3(pow(color.x , 8.0), pow(color.x , 8.0), pow(color.x * 1.5, 12.0)) ;
        color.xyz = vec3(2.0 * c, 2.0 * c, 5.0 *  c);
    }

    gl_FragColor =  color;
   
    
}

