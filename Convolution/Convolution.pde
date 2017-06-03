/*
    Names: Laura Viviana Alvarez Carvajal y Laura Alejandra Chaparro Gutierrez
    Visual Computing - Universidad Nacional de Colombia

    Convolution matrix taken from: https://en.wikipedia.org/wiki/Kernel_(image_processing)
*/
import processing.video.*;

PShader currentShader;
Movie myMovie;

float[] convolutionMatrix;

void setup(){
    size(1280, 720, P3D);
    currentShader = loadShader("shader.glsl");

    // Default convolution matrix
    convolutionMatrix = new float[]{
                        0, -1, 0,
                        -1, 5, -1,
                        0, -1, 0};

    // Load movie
    myMovie = new Movie(this, "video.mp4");
    myMovie.loop();
}

void draw(){
    currentShader.set("convolutionMatrix", convolutionMatrix);
    shader(currentShader);
    if(myMovie.available()){
        myMovie.read();
    }
    image(myMovie.get(), 0, 0);
}

void keyPressed(){
    switch (key) {
        // Identity matrix
        case 'i':
            convolutionMatrix = new float[]{
                                0, 0, 0, 0, 0,
                                0, 0, 0, 0, 0,
                                0, 0, 1, 0, 0,
                                0, 0, 0, 0, 0,
                                0, 0, 0, 0, 0};
            break;
        // Edge detection
        case 'e':
            convolutionMatrix = new float[]{
                                0, 0, 0, 0, 0,
                                0, 1, 0, -1, 0,
                                0, 0, 0, 0, 0,
                                0, -1, 0, 1, 0,
                                0, 0, 0, 0, 0};
            break;
        case 'r':
            convolutionMatrix = new float[]{
                                0, 0, 0, 0, 0,
                                0, 0, 1, 0, 0,
                                0, 1, -4, 1, 0,
                                0, 0, 1, 0, 0,
                                0, 0, 0, 0, 0};
            break;
        case 't':
            convolutionMatrix = new float[]{
                                0, 0, 0, 0, 0,
                                0, -1, -1, -1, 0,
                                0, -1, 8, -1, 0,
                                0, -1, -1, -1, 0,
                                0, 0, 0, 0, 0};
            break;
        // Sharpen
        case 's':
            convolutionMatrix = new float[]{
                                0, 0, 0, 0, 0,
                                0, 0, -1, 0, 0,
                                0, -1, 5, -1, 0,
                                0, 0, -1, 0, 0,
                                0, 0, 0, 0, 0};
            break;
        // Box blur
        case 'b':
            convolutionMatrix = new float[]{
                                0, 0, 0, 0, 0,
                                0, 1, 1, 1, 0,
                                0, 1, 1, 1, 0,
                                0, 1, 1, 1, 0,
                                0, 0, 0, 0, 0};
            convolutionMatrix = scalarMultiplication(convolutionMatrix, 1/9.0);
            break;
        // Gaussian Blur
        case 'g':
            convolutionMatrix = new float[]{
                                0, 0, 0, 0, 0,
                                0, 1, 2, 1, 0,
                                0, 2, 4, 2, 0,
                                0, 1, 2, 1, 0,
                                0, 0, 0, 0, 0};
            convolutionMatrix = scalarMultiplication(convolutionMatrix, 1/16.0);
            break;
    }
}

float[] scalarMultiplication(float[] matrix, float scalar){
    for(int i = 0; i < matrix.length; ++i){
        matrix[i] *= scalar;
    }
    return matrix;
}