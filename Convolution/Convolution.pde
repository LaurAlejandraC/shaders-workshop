PShader currentShader;
PImage img;

void setup(){
    size(680, 453, P3D);
    img = loadImage("dog.jpg");
    currentShader = loadShader("shader.glsl");

    float[] convolutionMatrix = {0, -1, 0,
                                -1, 5, -1,
                                0, -1, 0};

    float[] convolutionMatrix2 = {-1, -1, -1,
                                  -1, 8, -1,
                                  -1, -1, -1};
    currentShader.set("convolutionMatrix", convolutionMatrix2);
}

void draw(){
    background(0);
    shader(currentShader);
    image(img, 0, 0);
}