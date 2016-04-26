
uniform highp sampler2D     u_Texture0;
uniform lowp float          u_Alpha;
uniform lowp vec3           u_Color;
uniform lowp float          u_shouldColorAll;
uniform lowp float          u_shouldColorShape;

varying lowp float          v_FogFactor;
varying highp vec3          v_NormalOut;
varying highp vec3          v_LightVector;
varying highp vec3          v_HalfwayVector;
varying highp vec2          v_TexCoordOut;

void main()
{
    highp vec3 normal_unit = normalize(v_NormalOut);
    highp vec3 light_unit = normalize(v_LightVector);
    highp vec3 halfway_unit = normalize(v_HalfwayVector);
    
    lowp vec4 light_color = vec4(1.0, 1.0, 1.0, 1.0);
    
    lowp vec4 light_emissive_color = vec4(1.0, 1.0, 1.0, 1.0);
    lowp vec4 light_ambient_color  = vec4(0.2, 0.2, 0.2, 1.0);
    lowp vec4 light_diffuse_color  = vec4(1.0, 1.0, 1.0, 1.0);
    lowp vec4 light_specular_color = vec4(1.0, 1.0, 1.0, 1.0);
    
    lowp float material_emissive_contribution = 0.10;
    lowp float material_ambient_contribution  = 0.10;
    lowp float material_diffuse_contribution  = 0.40;
    lowp float material_specular_contribution = 0.40;
    
    highp float d = dot(normal_unit, light_unit);
    bool facing = d > 0.0;
    
    highp vec4 emissive_component = light_emissive_color * material_emissive_contribution;
    highp vec4 ambient_component = light_ambient_color * material_ambient_contribution;
    highp vec4 diffuse_component = light_diffuse_color * material_diffuse_contribution * max(0.1, d);
    highp vec4 specular_component = facing ? light_specular_color * material_specular_contribution * light_color * max(pow(dot(normal_unit, halfway_unit), 5.0), 0.0) : vec4(0.0, 0.0, 0.0, 0.0);
    
    lowp vec4 pre_color = vec4(emissive_component + ambient_component + diffuse_component + specular_component);
    pre_color = vec4(pre_color.r, pre_color.g, pre_color.b, 1.0);
    
    lowp vec4 color;
    if (u_shouldColorAll > 0.5) {
        color = pre_color * vec4(u_Color, u_Alpha);
    } else {
        color = vec4(pre_color.rgb, u_Alpha) * texture2D(u_Texture0, v_TexCoordOut);
        if (u_shouldColorShape > 0.5) {
            if (color.a > 0.0) {
                color = vec4(u_Color, color.a);
            }
        }
    }
    gl_FragColor = color;
}
