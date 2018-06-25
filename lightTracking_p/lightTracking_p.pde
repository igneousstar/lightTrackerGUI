import processing.serial.*;

Serial port;
String fromSerial;

int data1, data2, data3;
String[] split;

int error = 5;

long timer;

void setup() {
  size(800, 600);
  frameRate(10);
  //start the timer for com select
  timer = millis() - 3000;  
}

void draw() {
  background(200);
  if(port == null){
    selectCom();
  }
  else{
    readSerial();
    showData();
    drawSun();
  }
}

float angle;
int max;
int diff;
void drawSun() {
  //need to calculate the angle of the sun based on those values.
  pushMatrix();
  translate(width/2, height);
  line(0, 0, 0, -height);
  rotate(PI/4);
  line(0, 0, 0, -height);
  rotate(-PI/2);
  line(0, 0, 0, -height);
  popMatrix();

  max = 0;
  if (data1 > data2)
    max = (data1 > data3) ? 1:3;
  else
    max = (data2 > data3) ? 2:3;

  println(findDifference(max)+"\n");

  pushMatrix();
  translate(width/2, height);
  switch(max) {
  case 1:
    //diff = findDifference(max);
    //diff = constrain(diff, 0, 50);
    //angle = map(diff, 0, 50, 0, PI/4);
    //rotate(-PI/4+angle);
    rotate(-PI/4);
    break;
  case 2:
    diff = findDifference(max);
    if (diff < 0) {
      diff = constrain(diff, -70, 0);
      angle = map(diff, 0, -70, 0, -PI/4);
      rotate(-PI/4-angle);
    } else if (diff > 0) {
      diff = constrain(diff, 0, 70);
      angle = map(diff, 0, 70, 0, PI/4);
      rotate(PI/4-angle);
    } else {
      //do nothing
    }
    break;
  case 3:
    //diff = findDifference(max);
    //diff = constrain(diff, -50, 0);
    //angle = map(diff, -50, 0, 0, -PI/4);
    //rotate(PI/4-angle);
    rotate(PI/4);
    break;
  }
  fill(255);
  ellipse(0, -height*2/3, 100, 100);
  popMatrix();
}

int findDifference(int data) {
  if (data == 1) {
    return abs(data1-data2);
  } else if (data == 2) {
    if (data1 > data3) {
      return -abs(data1-data2);
    } else {
      return abs(data2-data3);
    }
  } else {
    return -abs(data3-data2);
  }
}

void showData() {
  fill(0);
  text(data1, width/2-width/10, height-height/10);
  text(data2, width/2, height-height/10);
  text(data3, width/2+width/10, height-height/10);
}

//reads information from the Serail port and grabs the data
void readSerial() {
  if (port.available() > 0) {
    fromSerial = port.readStringUntil('\n');
  }

  if (fromSerial != null) {
    split = fromSerial.split(",");
    if (split.length == 3) {
      data1 = Integer.parseInt(split[0]);
      data2 = Integer.parseInt(split[1]);
      data3 = Integer.parseInt(split[2].substring(0, split[2].length()-1));
      System.out.println(data1+" "+data2+" "+data3);
    }
  }
}