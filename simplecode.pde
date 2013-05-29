//by Rick Companje, 8 june 2012
 
float scale = .001; // px per mm
int bedWidth = 370; // width in mm (morntech: 520) (hpc: 370)
int bedHeight = 235; // width in mm (morntech: 330) (hpc: 235)

String lines[];
String[] commands = {"move","cut","","","","","","set"};
String[] parameters = new String[103];


void setup() {
  size(bedWidth,bedHeight);
  mouseX = 0;
  smooth();
  lines = loadStrings("small2.txt");
  
  parameters[100] = "speed";
  parameters[101] = "power";
  parameters[102] = "frequency";
}
 
void draw() {
  background(0);
  float px=0;
  float py=0;
  float stepf = map(mouseX,0,width,0,lines.length); //progress
  int step = int(stepf);
  
  String description = " ";
  int c[] = int(split(lines[step],' '));
  int command = c[0];
  if(command > 1) {
    description += commands[command];
    description += ": ";
    description += parameters[c[1]];
    description += " = ";
    description += c[2]/100;
  }
  
  text(step + ": " + lines[step]+description,5,height-7);
  
  for (int i=0; i<lines.length; i++) {
    c = int(split(lines[i],' '));
    command = c[0];
    
    if (command<2) {
      float x = c[1]*scale; //scale
      float y = height - c[2]*scale;
      
      int a = i<=step ? 255:50;
      if (command==0) stroke(a, 0, 0, 200); //red
      else stroke(a); //white
      line(px,py,x,y);
 
      if (i==step) { //ellipse moves substeps on line
        float lx = lerp(px,x,stepf-step); //interpolate
        float ly = lerp(py,y,stepf-step); //using rest value of division
        ellipse(lx,ly,6,6);
      }
      
      px=x;
      py=y;
    }
  }
}
