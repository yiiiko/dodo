PImage photo;
int NUMBALLS = 30;
int x;
int y;
float[] ballX = new float[NUMBALLS];
float[] ballY = new float[NUMBALLS];
float[] dx = new float[NUMBALLS];
float[] dy = new float[NUMBALLS];

import processing.video.*;
int[] arrayX = new int[5];
int[] arrayY = new int[4];


float r;
float m;
float movementSum;
int numPixels;
int[] previousFrame; 
Capture video;

void setup() {
  x=700;
  y=700;
  size(1200, 480);
  photo = loadImage("wdd.png");

  noStroke();


  for (int i = 0; i < NUMBALLS; i++) {
    ballX[i] = width/2-50;
    ballY[i] = height/2-50;
    dx[i] = random(-1, 1);
    dy[i] = random(-1, 1);
  }
  video = new Capture(this, width, height);


  video.start(); 

  numPixels = video.width * video.height;
  // Create an array to store the previously captured frame
  previousFrame = new int[numPixels];
  loadPixels();
  //for (int i = 0; i < arrayX.length; i++) {
  //    ballX[i] = 120+i * 100;
      
  //    //println(arrayX[i] + ", " + arrayY[j]);
  //  }
  
}

void draw() {

  background(234, 164, 152);
  fill(237, 160, 148);
  rect(width/2-300, height/2-200, 600, 400);
  //image(photo,0,0);
  fill(240, 157, 143);
  rect(width/2-150, height/2-150, 300, 300);

  if (video.available()) {
    // When using video to manipulate the screen, use video.available() and
    // video.read() inside the draw() method so that it's safe to draw to the screen
    video.read(); // Read the new frame from the camera
    video.loadPixels(); // Make its pixels[] array available

    int movementSum = 0; // Amount of movement in the frame
    for (int i = 0; i < numPixels; i++) { // For each pixel in the video frame...
      color currColor = video.pixels[i];
      color prevColor = previousFrame[i];
      // Extract the red, green, and blue components from current pixel
      int currR = (currColor >> 16) & 0xFF; // Like red(), but faster
      int currG = (currColor >> 8) & 0xFF;
      int currB = currColor & 0xFF;
      // Extract red, green, and blue components from previous pixel
      int prevR = (prevColor >> 16) & 0xFF;
      int prevG = (prevColor >> 8) & 0xFF;
      int prevB = prevColor & 0xFF;
      // Compute the difference of the red, green, and blue values
      int diffR = abs(currR - prevR);
      int diffG = abs(currG - prevG);
      int diffB = abs(currB - prevB);
      // Add these differences to the running tally
      movementSum += diffR + diffG + diffB;
      // Render the difference image to the screen
      //pixels[i] = color(diffR, diffG, diffB);
      // The following line is much faster, but more confusing to read
      //pixels[i] = 0xff000000 | (diffR << 16) | (diffG << 8) | diffB;
      // Save the current color into the 'previous' buffer
      previousFrame[i] = currColor;
    }

    if (movementSum > 0) {
      //updatePixels();
      m= movementSum*0.000001;
      println(movementSum, ",", m); // Print the total amount of movement to the console
    }
  }
  


  for (int i = 0; i < NUMBALLS; i++) {


    //fill(map(i, 0, NUMBALLS, 50, 255));
    image(photo, ballX[i], ballY[i], i+30, i+45);
    
    if (m > 30) {
      text("ahhh!!!", ballX[i], ballY[i]);
    }
    textSize(10);
    fill(10);
    //text("dodo citizen " + i + ": x" +ballX[i], 0, 20+(i*8));
    //text("dodo citizen " + i + ": y" +ballY[i], width - 300 + cos(millis()/100.0)*(m+cos(i/8.0)), 200+(cos(i/8.0)*8+7));
    textSize(10);
    text("dodo citizen " + i + ": y" +ballY[i], width - 300 + cos(millis()/(110.0+i))*m+5, 100+i*(10));
    r= random(1, 2);
    ballX[i] += dx[i]/7*m;
    ballY[i] += dy[i]/7*m;


    if (ballX[i] > width-100 || ballX[i] <100) {
      ballX[i] -= dx[i]*1.3;
      dx[i] = -dx[i]*1.3;
    }

    if (ballY[i] > height-100 || ballY[i] < 100) {
      ballY[i] -= dy[i];
      dy[i] = -dy[i];
    }

    fill(255);
    ellipse(x, y, 50, 50);
    fill(255);
    ellipse(x+100, y, 50, 50);


    if (mousePressed == true) { 
      if (mouseX > 25 && mouseY< x+25 && mouseY > y-25 && mouseY < y+25) {
        background(255);
      }
    }
  }
  fill(255);
  textSize(10);
  text("m " + m, 400, 400);
  
  for (int i = 0; i < int(m); i++) {
    //textSize(cos(i/3.3)*8+10);
    //text("DODO", 300 + i*10, 300);
  }
}
void keyPressed() {
  if (key == CODED) {
    if (keyCode ==UP) {
      for (int i = 0; i < NUMBALLS; i++) {
        ballX[i]=width/2-50;        
        ballY[i]=height/2-50;
      }


      if (key == CODED) {
        if (keyCode ==DOWN) {
          for (int i = 0; i < NUMBALLS; i++) {
            ballX[i]=width/2-50;        
            ballY[i]=height/2-50;
          }
          
        }
      }
    }
  }
}