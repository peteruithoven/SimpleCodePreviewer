// by Rick Companje, 8 june 2012
// improved by Peter Uithoven, 1 juni 2013, 20 may 2014
 
float scale = 3; //0.1; //.001; 
float bedWidth = 370.0*scale;// *scale; // width in mm (morntech: 520) (hpc: 370)
float bedHeight = 235.0*scale;//*scale; // width in mm (morntech: 330) (hpc: 235)
boolean flipY = true;

float step = 0;
String lines[];
String[] commands = new String[255];
String[] parameters = new String[103];

float SIMPLECODE_SCALE = 0.001;

void setup() {
  println("  bedWidth: "+bedWidth);
  println("  bedHeight: "+bedHeight);
  
  commands[0] = "move";
  commands[1] = "cut";
  commands[7] = "set";
  commands[9] = "bitmap";
  commands[201] = "JobXmin";
  commands[202] = "JobXMax";
  commands[203] = "JobYMin";
  commands[204] = "JobYMax";
  
  parameters[100] = "speed";
  parameters[101] = "power";
  parameters[102] = "frequency";
  
  size(int(bedWidth),int(bedHeight));
  mouseX = 0;
  smooth();
  
  lines = loadStrings("output.simplecode");
  println("num: lines "+lines.length);
}

void draw() {
  background(0);
  float px=0;
  float py= (flipY)? 0 : bedHeight;
  float lineParts[] = float(split(lines[int(step)],' '));
  int command = int(lineParts[0]);
  
  // Display line description
  String description = " ";
  description += commands[command];
  description += ": ";
  switch(command) {
    case 0:
    case 1:
      description += lineParts[1]*SIMPLECODE_SCALE;
      description += lineParts[2]*SIMPLECODE_SCALE;
      break;
    case 7: // Set parameter 
      description += parameters[int(lineParts[1])];
      description += " = ";
      description += lineParts[2]*SIMPLECODE_SCALE;
      break;
    default: 
      for (int i=1; i<lineParts.length; i++) {
        description += lineParts[i];
        if(i < lineParts.length-1) {
          description += ", ";
        }
      }
      break;
  }
  text(int(step) + ": " + lines[int(step)]+": "+description,5,height-7);
  
  // draw preview
  for (int i=0; i<lines.length; i++) {
    lineParts = float(split(lines[i],' '));
    command = int(lineParts[0]);
    //println("command: "+command);
    if (command<2) { // only handle moves (0) and cuts (1) 
      float x = lineParts[1]*SIMPLECODE_SCALE*scale; //scale
      float y = lineParts[2]*SIMPLECODE_SCALE*scale;
      if(flipY) y = bedHeight-y;
      int a = i<=step ? 255:50;
      if (command==0) stroke(a, 0, 0, 200); //red
      else stroke(a); //white
      line(px,py,x,y);
      //println("  line: "+x+" x "+y);
      if (i==int(step)) { //ellipse moves substeps on line
        float lx = lerp(px,x,step-int(step)); //interpolate
        float ly = lerp(py,y,step-int(step)); //using rest value of division
        ellipse(lx,ly,6,6);
      }
      
      px=x;
      py=y;
    }
  }
}

void keyPressed() {
  switch(keyCode) {
   case RIGHT:
    setStep(getStep()+1);
    break; 
   case LEFT:
    setStep(getStep()-1);
    break; 
  }
}
void mouseMoved() {
  step = map(mouseX,0,width,0,lines.length); //progress
}

float getStep() {
  return step; 
}
void setStep(float value) {
  if(value < 0) value = 0;
  else if(value > lines.length-1) value = lines.length-1;
  step = value; 
}
