/*
    Names: Laura Viviana Alvarez Carvajal and Laura Alejandra Chaparro Gutierrez
    Visual Computing - Universidad Nacional de Colombia

    Convolution matrices taken from: https://en.wikipedia.org/wiki/Kernel_(image_processing)
                                     http://setosa.io/ev/image-kernels/
*/
import processing.video.*;
import controlP5.*; 

PGraphics pg;

PShader currentShader;
Movie myMovie;

float[] convolutionMatrix;

ControlP5 cp5;
DropdownList d1;

ArrayList<String> shaders;

void setup(){
    size(1280, 720, P3D);
    
    // Shaders names for dropdown list
    shaders = new ArrayList<String>();
    fillShadersList(); 
    
    // Create a DropdownList
    cp5 = new ControlP5(this);    
    d1 = cp5.addDropdownList("myList-d1")
            .setPosition(10, 10);
                                  
    customize(d1); // customize the dropdown list
    
    // PGraphics for video
    pg = createGraphics( 1280, 720, P3D );
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
    
    pg.beginDraw();
    pg.shader(currentShader);
    
    if(myMovie.available()){
        myMovie.read();
    }
    
    pg.image(myMovie.get(), 0, 0);
    
    pg.endDraw();
    
    image(pg, 0, 0); 
}

void setShader( int index ){
    switch ( index ) {
        // Identity matrix
        case 0:
            convolutionMatrix = new float[]{
                                0, 0, 0, 0, 0,
                                0, 0, 0, 0, 0,
                                0, 0, 1, 0, 0,
                                0, 0, 0, 0, 0,
                                0, 0, 0, 0, 0};
            break;
        // Edge detection
        case 1:
            convolutionMatrix = new float[]{
                                0, 0, 0, 0, 0,
                                0, 1, 0, -1, 0,
                                0, 0, 0, 0, 0,
                                0, -1, 0, 1, 0,
                                0, 0, 0, 0, 0};
            break;
        case 2:
            convolutionMatrix = new float[]{
                                0, 0, 0, 0, 0,
                                0, 0, 1, 0, 0,
                                0, 1, -4, 1, 0,
                                0, 0, 1, 0, 0,
                                0, 0, 0, 0, 0};
            break;
        case 3:
            convolutionMatrix = new float[]{
                                0, 0, 0, 0, 0,
                                0, -1, -1, -1, 0,
                                0, -1, 8, -1, 0,
                                0, -1, -1, -1, 0,
                                0, 0, 0, 0, 0};
            break;
        // Sharpen
        case 4:
            convolutionMatrix = new float[]{
                                0, 0, 0, 0, 0,
                                0, 0, -1, 0, 0,
                                0, -1, 5, -1, 0,
                                0, 0, -1, 0, 0,
                                0, 0, 0, 0, 0};
            break;
        // Box blur
        case 5:
            convolutionMatrix = new float[]{
                                0, 0, 0, 0, 0,
                                0, 1, 1, 1, 0,
                                0, 1, 1, 1, 0,
                                0, 1, 1, 1, 0,
                                0, 0, 0, 0, 0};
            convolutionMatrix = scalarMultiplication(convolutionMatrix, 1/9.0);
            break;
        // Gaussian Blur
        case 6:
            convolutionMatrix = new float[]{
                                0, 0, 0, 0, 0,
                                0, 1, 2, 1, 0,
                                0, 2, 4, 2, 0,
                                0, 1, 2, 1, 0,
                                0, 0, 0, 0, 0};
            convolutionMatrix = scalarMultiplication(convolutionMatrix, 1/16.0);
            break;
        // Gaussian Blur 5x5
        case 7:
            convolutionMatrix = new float[]{
                                1, 4, 6, 4, 1,
                                4, 16, 24, 16, 4,
                                6, 24, 36, 24, 6,
                                4, 16, 24, 16, 4,
                                1, 4, 6, 4, 1};
            convolutionMatrix = scalarMultiplication(convolutionMatrix, 1/256.0);
            break;
        // Unsharp masking 5x5
        case 8:
            convolutionMatrix = new float[]{
                                1, 4, 6, 4, 1,
                                4, 16, 24, 16, 4,
                                6, 24, -476, 24, 6,
                                4, 16, 24, 16, 4,
                                1, 4, 6, 4, 1};
            convolutionMatrix = scalarMultiplication(convolutionMatrix, -1/256.0);
            break;
        // Bottom sobel
        case 9:
            convolutionMatrix = new float[]{
                                0, 0, 0, 0, 0,
                                0, -1, -2, -1, 0,
                                0, 0, 0, 0, 0,
                                0, 1, 2, 1, 0,
                                0, 0, 0, 0, 0};
            break;
        // Emboss
        case 10:
            convolutionMatrix = new float[]{
                                0, 0, 0, 0, 0,
                                0, -2, -1, 0, 0,
                                0, -1, 1, 1, 0,
                                0, 0, 1, 2, 0,
                                0, 0, 0, 0, 0};
            break;
        // Left sobel
        case 11:
            convolutionMatrix = new float[]{
                                0, 0, 0, 0, 0,
                                0, 1, 0, -1, 0,
                                0, 2, 0, -2, 0,
                                0, 1, 0, -1, 0,
                                0, 0, 0, 0, 0};
            break;
        // Right sobel
        case 12:
            convolutionMatrix = new float[]{
                                0, 0, 0, 0, 0,
                                0, -1, 0, 1, 0,
                                0, -2, 0, 2, 0,
                                0, -1, 0, 1, 0,
                                0, 0, 0, 0, 0};
            break;
    }
}

float[] scalarMultiplication(float[] matrix, float scalar){
    for(int i = 0; i < matrix.length; ++i){
        matrix[i] *= scalar;
    }
    return matrix;
}

void fillShadersList(){
    shaders.add("Identity");
    shaders.add("Edge detection 1");
    shaders.add("Edge detection 2");
    shaders.add("Edge detection 3");
    shaders.add("Sharpen");
    shaders.add("Box blur");
    shaders.add("Gaussian Blur");
    shaders.add("Gaussian Blur 5x5");
    shaders.add("Unsharp masking 5x5");
    shaders.add("Bottom sobel");
    shaders.add("Emboss");
    shaders.add("Left sobel");
    shaders.add("Right sobel");
}

void customize(DropdownList ddl) {
    // Function to customize a DropdownList
    ddl.setBackgroundColor(color(190));
    ddl.setHeight(350);
    ddl.setWidth(140);
    ddl.setItemHeight(25);
    ddl.setBarHeight(25);
    ddl.getCaptionLabel().set("Shaders");
    ddl.getCaptionLabel().getStyle().marginTop = 3;
    ddl.getCaptionLabel().getStyle().marginLeft = 3;
    ddl.getValueLabel().getStyle().marginTop = 3;
    
    // Add shader names to dropdown list
    for (int i = 0; i < shaders.size(); i++) {
        ddl.addItem(shaders.get(i), i);
    }
    
    //ddl.scroll(0);
    ddl.setColorBackground(color(60));
    ddl.setColorActive(color(255, 128));
}

void controlEvent(ControlEvent theEvent) {
  // DropdownList is of type ControlGroup.
  // A controlEvent will be triggered from inside the ControlGroup class.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message thrown by controlP5.

  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  } 
  else if (theEvent.isController()) {
    setShader((int)theEvent.getController().getValue());
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
  }
}