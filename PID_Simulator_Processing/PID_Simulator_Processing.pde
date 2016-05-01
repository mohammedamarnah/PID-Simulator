/*
  PID Simulator

  Created by Mohammed Amarnah on 5/1/16.
  Copyright © 2016 Mohammed Amarnah. All rights reserved.
*/

/*
  Proportional-Integral-Derivative Line Follower Simulator for EV3 Mindstorms Robots.
  This simulator is a simple attempt from someone who's coached a robotics team for several years.
  It was done for more than one reason:
  1- First, it was done for the sake of easening the process of choosing the kp, ki, and 
      kd factors for any PID line following algorithm.
  2- It's also a beautiful way of explaining the differences between the Proportional line follower, 
      and the PI, and the PID one. 
  Whether to kids or to adults, it'll make them understand the algorithm easily.
  
  USAGE: 
  The program is really simple, in the draw() function you can edit the kp, ki, and kd factors for each line follower.
  You can also change the colors of each one. 
  To simulate pushing the robot, just click on any key or click the mouse, and the program
  will generate a random place and put the robot in it.
*/

int x = 0;
float integral, lastError, derivative;

void setup() {
  size(640, 360);
  setupPID();
  setupPI();
  setupP();
  integral = lastError = derivative = 0;
  background(255);
  noSmooth();
}

float midpointPID, lightValuePID;
void setupPID() {
  midpointPID = 80;
  lightValuePID = 120;
}

float midpointPI, lightValuePI;
void setupPI() {
  midpointPI = 160; 
  lightValuePI = 200;
}

float midpointP, lightValueP;
void setupP() {
  midpointP = 240;
  lightValueP = 280;
}

void PID(float kp_, float ki_, float kd_, int col) {
  float kp, ki, kd, turn, error;
  kp = kp_; ki = ki_; kd = kd_;
  
  fill(col, 0, 205);
  smooth();
  textSize(16);
  text("Proportional-Integral-Derivative: " + (int)lightValuePID + "                " + kp + "                " + ki + "                " + kd, 10, 20);
  
  stroke(col, 0, 205);
  strokeWeight(7);
  smooth();
  point(x, lightValuePID);
  
  error = lightValuePID - midpointPID;
  integral += error;
  derivative = error - lastError;
  turn = (kp*error) + (ki*integral) + (kd*derivative);
  if (turn > 0)
    lightValuePID -= turn/5;
  else
    lightValuePID += (turn*-1)/5;
  lastError = error;
}

void PI(float kp_, float ki_, int col) {
  float kp, ki, kd, turn, error;
  kp = kp_; ki = ki_; kd = 0;
  
  fill(col, 0, 205);
  text("Proportional-Integral: " + (int)lightValuePI + "                " + kp + "                " + ki + "                " + kd, 10, 40);
  
  stroke(col, 0, 205);
  strokeWeight(7);
  smooth();
  point(x, lightValuePI);
  
  error = lightValuePI - midpointPI;
  integral += error;
  derivative = error - lastError;
  turn = (kp*error) + (ki*integral) + (kd*derivative);
  if (turn > 0)
    lightValuePI -= turn/5;
  else
    lightValuePI += (turn*-1)/5;
  lastError = error;
}

void P(float kp_, int col) {
  float kp, ki, kd, turn, error;
  kp = kp_; ki = 0; kd = 0;
  
  fill(col, 0, 205);
  text("Proportional: " + (int)lightValueP + "                " + kp + "                " + ki + "                " + kd, 10, 60);
  
  stroke(col, 0, 205);
  strokeWeight(7);
  smooth();
  point(x, lightValueP);
  
  error = lightValueP - midpointP;
  integral += error;
  derivative = error - lastError;
  turn = (kp*error) + (ki*integral) + (kd*derivative);
  if (turn > 0)
    lightValueP -= turn/5;
  else
    lightValueP += (turn*-1)/5;
  lastError = error;
}

void draw() {
  // PID(kp, ki, kd, color);
  PID(0.7, 0.04, 3, 101);
  // PI(kp, ki, color);
  PI(0.7, 0.04, 10);
  // P(kp, color);
  P(0.7, 200);
  // Generating random coordinates when any key
  // is pressed to simulate real life movements
  // for the robot.
  if (mousePressed || keyPressed) {
    lightValuePID = random(80, height);
    lightValuePI = random(80, height);
    lightValueP = random(80, height);
  }
  // Resetting whenever the line has passed the width
  // of the screen
  if (x > width) {
    clear();
    background(255);
    x = 0;
  }
  x += 1;
}