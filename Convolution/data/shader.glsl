#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 texOffset;
uniform float[25] convolutionMatrix;

varying vec4 vertColor;
varying vec4 vertTexCoord;

const vec4 lumcoeff = vec4(0.299, 0.587, 0.114, 0);

void main(){
    vec2 tc0  = vertTexCoord.st + vec2(-2 * texOffset.s, -2 * texOffset.t);
    vec2 tc1  = vertTexCoord.st + vec2(    -texOffset.s, -2 * texOffset.t);
    vec2 tc2  = vertTexCoord.st + vec2(             0.0, -2 * texOffset.t);
    vec2 tc3  = vertTexCoord.st + vec2(    +texOffset.s, -2 * texOffset.t);
    vec2 tc4  = vertTexCoord.st + vec2(+2 * texOffset.s, -2 * texOffset.t);
    vec2 tc5  = vertTexCoord.st + vec2(-2 * texOffset.s,     -texOffset.t);
    vec2 tc6  = vertTexCoord.st + vec2(    -texOffset.s,     -texOffset.t);
    vec2 tc7  = vertTexCoord.st + vec2(             0.0,     -texOffset.t);
    vec2 tc8  = vertTexCoord.st + vec2(    +texOffset.s,     -texOffset.t);
    vec2 tc9  = vertTexCoord.st + vec2(+2 * texOffset.s,     -texOffset.t);
    vec2 tc10 = vertTexCoord.st + vec2(-2 * texOffset.s,              0.0);
    vec2 tc11 = vertTexCoord.st + vec2(    -texOffset.s,              0.0);
    vec2 tc12 = vertTexCoord.st + vec2(             0.0,              0.0);
    vec2 tc13 = vertTexCoord.st + vec2(    +texOffset.s,              0.0);
    vec2 tc14 = vertTexCoord.st + vec2(+2 * texOffset.s,              0.0);
    vec2 tc15 = vertTexCoord.st + vec2(-2 * texOffset.s,     +texOffset.t);
    vec2 tc16 = vertTexCoord.st + vec2(    -texOffset.s,     +texOffset.t);
    vec2 tc17 = vertTexCoord.st + vec2(             0.0,     +texOffset.t);
    vec2 tc18 = vertTexCoord.st + vec2(    +texOffset.s,     +texOffset.t);
    vec2 tc19 = vertTexCoord.st + vec2(+2 * texOffset.s,     +texOffset.t);
    vec2 tc20 = vertTexCoord.st + vec2(-2 * texOffset.s, +2 * texOffset.t);
    vec2 tc21 = vertTexCoord.st + vec2(    -texOffset.s, +2 * texOffset.t);
    vec2 tc22 = vertTexCoord.st + vec2(             0.0, +2 * texOffset.t);
    vec2 tc23 = vertTexCoord.st + vec2(    +texOffset.s, +2 * texOffset.t);
    vec2 tc24 = vertTexCoord.st + vec2(+2 * texOffset.s, +2 * texOffset.t);

    vec4 col0 = texture2D(texture, tc0);
    vec4 col1 = texture2D(texture, tc1);
    vec4 col2 = texture2D(texture, tc2);
    vec4 col3 = texture2D(texture, tc3);
    vec4 col4 = texture2D(texture, tc4);
    vec4 col5 = texture2D(texture, tc5);
    vec4 col6 = texture2D(texture, tc6);
    vec4 col7 = texture2D(texture, tc7);
    vec4 col8 = texture2D(texture, tc8);
    vec4 col9 = texture2D(texture, tc9);
    vec4 col10 = texture2D(texture, tc10);
    vec4 col11 = texture2D(texture, tc11);
    vec4 col12 = texture2D(texture, tc12);
    vec4 col13 = texture2D(texture, tc13);
    vec4 col14 = texture2D(texture, tc14);
    vec4 col15 = texture2D(texture, tc15);
    vec4 col16 = texture2D(texture, tc16);
    vec4 col17 = texture2D(texture, tc17);
    vec4 col18 = texture2D(texture, tc18);
    vec4 col19 = texture2D(texture, tc19);
    vec4 col20 = texture2D(texture, tc20);
    vec4 col21 = texture2D(texture, tc21);
    vec4 col22 = texture2D(texture, tc22);
    vec4 col23 = texture2D(texture, tc23);
    vec4 col24 = texture2D(texture, tc24);
    /*
    vec2 tc0 = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t);
    vec2 tc1 = vertTexCoord.st + vec2(         0.0, -texOffset.t);
    vec2 tc2 = vertTexCoord.st + vec2(+texOffset.s, -texOffset.t);
    vec2 tc3 = vertTexCoord.st + vec2(-texOffset.s,          0.0);
    vec2 tc4 = vertTexCoord.st + vec2(         0.0,          0.0);
    vec2 tc5 = vertTexCoord.st + vec2(+texOffset.s,          0.0);
    vec2 tc6 = vertTexCoord.st + vec2(-texOffset.s, +texOffset.t);
    vec2 tc7 = vertTexCoord.st + vec2(         0.0, +texOffset.t);
    vec2 tc8 = vertTexCoord.st + vec2(+texOffset.s, +texOffset.t);
    
    vec4 col0 = texture2D(texture, tc0);
    vec4 col1 = texture2D(texture, tc1);
    vec4 col2 = texture2D(texture, tc2);
    vec4 col3 = texture2D(texture, tc3);
    vec4 col4 = texture2D(texture, tc4);
    vec4 col5 = texture2D(texture, tc5);
    vec4 col6 = texture2D(texture, tc6);
    vec4 col7 = texture2D(texture, tc7);
    vec4 col8 = texture2D(texture, tc8);
    */
    vec4 sum = col0 * convolutionMatrix[0] + col1 * convolutionMatrix[1] + col2 * convolutionMatrix[2] 
             + col3 * convolutionMatrix[3] + col4 * convolutionMatrix[4] + col5 * convolutionMatrix[5] 
             + col6 * convolutionMatrix[6] + col7 * convolutionMatrix[7] + col8 * convolutionMatrix[8] 
             + col9 * convolutionMatrix[9] + col10 * convolutionMatrix[10] + col11 * convolutionMatrix[11] 
             + col12 * convolutionMatrix[12] + col13 * convolutionMatrix[13] + col14 * convolutionMatrix[14] 
             + col15 * convolutionMatrix[15] + col16 * convolutionMatrix[16] + col17 * convolutionMatrix[17] 
             + col18 * convolutionMatrix[18] + col19 * convolutionMatrix[19] + col20 * convolutionMatrix[20] 
             + col21 * convolutionMatrix[21] + col22 * convolutionMatrix[22] + col23 * convolutionMatrix[23] 
             + col24 * convolutionMatrix[24];
    gl_FragColor = vec4(sum.rgb, 1.0) * vertColor;
}