
attribute vec4      a_Position;
attribute vec3      a_Normal;
attribute vec2      a_TexCoordIn;

uniform mat4        u_ProjectionMatrix;
uniform mat4        u_ViewMatrix;
uniform mat4        u_ModelMatrix;
uniform mat3        u_NormalMatrix;

varying vec3        v_NormalOut;
varying vec3        v_LightVector;
varying vec3        v_HalfwayVector;
varying vec2        v_TexCoordOut;

void main()
{
    vec4 viewModelPos = u_ViewMatrix * u_ModelMatrix * a_Position;
    //vec3 lightPos = vec3(-100.0, 1.0, 1.0);
    vec3 lightPos = vec3(0.0, 0.0, 1.0);
    
    // vertex shader outputs
    gl_Position = u_ProjectionMatrix * viewModelPos;
    
    // fragment shader inputs
    v_NormalOut = u_NormalMatrix * a_Normal;
    //v_FogFactor = min(-viewModelPos.z / 50.0, 1.0);
    v_LightVector = normalize((u_ViewMatrix * vec4(lightPos, 1.0)).xyz - viewModelPos.xyz);
    v_HalfwayVector = v_LightVector + normalize(-viewModelPos.xyz);
    v_TexCoordOut = a_TexCoordIn;
}
