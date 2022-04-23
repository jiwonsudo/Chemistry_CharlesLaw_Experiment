// (c) 2022. Jiwon Jeong all rights reserved.
/*
! The external atmospheric pressure and atmospheric pressure are fixed at 1 atm.
! The input number of moles and the volume value according to the temperature change are
calculated according to the ideal gas equation(PV=nRT, R = 0.08206).
! Whenever the 'UP' or 'DN' button is pressed once, 
the absolute temperature (K) inside the cylinder increases or decreases by 10 degrees.
! The gas particle animation is just to show the behavior of the particles according
to the temperature, and it is not calculated according to actual physical laws,
but is implemented through approximate proportions.
! Volume values ​​are rounded to three decimal places.
! Maximum temperature is 600(K).
*/

PFont fontLight, fontRegular;

//******************************************************************************************

//initial settings

int temp = 100; // temperature of gas (K, C = K + 273.15)
float volume; // volume of gas (L)
int mol_Of_particle = 5; // * N(A)
float ideal_Gas_Constant = 0.08206;

//******************************************************************************************

int volumeRoundingDigits = 3; // Number of decimal places to round to volume values

int tempSX = 550;
int tempSY = 500;

float distanceToUP = dist(550, 558, mouseX, mouseY);
float distanceToDN = dist(625, 558, mouseX, mouseY);

void drawCylinder(int cydSX, int cydSY, int cydWidth, int cydHeight) // cydS means cylinderStart
{
  // drawing cylinder
  stroke(0);
  strokeWeight(3);
  line(cydSX, cydSY, cydSX, cydSY + cydHeight); // left line
  line(cydSX + cydWidth, cydSY, cydSX + cydWidth, cydSY + cydHeight); // right line
  line(cydSX, cydSY + cydHeight, cydSX + 300, cydSY + cydHeight); // bottom line
}

void drawWindow(int winSX, int winSY, int winWidth, int winHeight, int winDivLine)
// winDivline : adding it as X condition to vertical window dividing line
{
  // drawing indicator window
  stroke(0);
  strokeWeight(2);
  // horizontal lines
  line(winSX, winSY, winSX + winWidth, winSY);
  line(winSX, winSY + winHeight / 2, winSX + winWidth, winSY + winHeight / 2); // middle line
  line(winSX, winSY + winHeight, winSX + winWidth, winSY + winHeight);
  // vertical lines
  line(winSX, winSY, winSX, winSY + winHeight);
  line(winSX + winDivLine, winSY, winSX + winDivLine, winSY + winHeight);
  line(winSX + winWidth, winSY, winSX + winWidth, winSY + winHeight);
  // texts
  fill(0);
  textFont(fontLight, 50);
  text("V", winSX + 12, winSY + 45); // Volume title
  text("T", winSX + 12, winSY + 95); // Temperature title
  textFont(fontLight, 30);
  text("(L)", winSX + 260, winSY + 37); // volume unit as Liter(L)
  text("(K)", winSX + 260, winSY + 87); // temp unit as Kelvin(K)
  textFont(fontRegular, 15);
  text("Calculated according to 'PV=nRT'.", winSX + 50, winSY + 140); // calculation way
}

void drawTemp(int tempBtnSX, int tempBtnSY, int btnWidth)
{
  // title
  fill(0);
  textFont(fontLight, 30);
  text("T  E  M  P", tempBtnSX, tempBtnSY);
  
  // info, max / min temp text
  fill(0);
  textFont(fontRegular, 15);
  text("      10K / click \nMaximum: 600K", tempBtnSX, tempBtnSY + 120);
  
  // draw buttons
  fill(250);
  ellipseMode(CENTER);
  if (distanceToUP > 20) {
    stroke(0);
    strokeWeight(1);
  } else {
    stroke(227, 58, 43);
    strokeWeight(3);
  }
  ellipse(tempBtnSX + 10, tempBtnSY + 50, btnWidth, btnWidth); // temp up button
  
  if (distanceToDN > 20) {
    stroke(0);
    strokeWeight(1);
  } else {
    stroke(227, 58, 43);
    strokeWeight(3);
  }
  ellipse(tempBtnSX + 90, tempBtnSY + 50, btnWidth, btnWidth); // temp down button
  
  fill(0);
  textFont(fontLight, 20);
  text("UP", tempBtnSX, tempBtnSY + 58); // text on temp up button
  text(" DN", tempBtnSX + 75, tempBtnSY + 58); // text on temp down button
  textFont(fontRegular, 15);
}

void drawPiston(int cydSX, int cydSY, int cydWidth)
{
  stroke(170);
  strokeWeight(5);
  strokeCap(SQUARE);
  float pistonDepth = volume * 2.031; // 2.031 length per liter
  line(cydSX, cydSY + 600 - pistonDepth, cydSX + cydWidth, cydSY + 600 - pistonDepth);
}

void indicateResult(int winSX, int winSY)
{
  fill(0);
  textFont(fontLight, 30);
  text(volume, winSX + 70, winSY + 37);
  text(temp, winSX + 70, winSY + 87);
}

void calculate()
{
  volume = Math.round(mol_Of_particle * ideal_Gas_Constant * temp * 1000) / 1000.0;
}

void animateParticles()
{
  
}

void setup()
{
  size(800, 800);
  
  frameRate(30);
  
  fontLight = loadFont("AppleSDGothicNeo-Thin-45.vlw");
  fontRegular = loadFont("AppleSDGothicNeo-Regular-50.vlw");
  
  print("(c) 2022. Jiwon Jeong all rights reserved. \n");
  print("! The external atmospheric pressure and atmospheric pressure are fixed at 1 atm. \n");
  print("! The input number of moles and the volume value according to the temperature change are calculated according to the ideal gas equation(PV=nRT, R = 0.08206). \n");
  print("! Whenever the 'UP' or 'DN' button is pressed once, the absolute temperature (K) inside the cylinder increases or decreases by 10 degrees. \n");
  print("! The gas particle animation is just to show the behavior of the particles according to the temperature, and it is not calculated according to actual physical laws, but is implemented through approximate proportions. \n");
  print("! Volume values ​​are rounded to three decimal places. \n");
  print("! Maximum temperature is 600(K). \n");
  print("\n");
  print("Starting program. \n");
  print("Initial number of moles of gas:", mol_Of_particle, ", \nInitial(current) gas temperature (K):", temp, ", Initial(current) gas volume (L):", Math.round(mol_Of_particle * ideal_Gas_Constant * temp * 1000) / 1000.0, "\n(Ideal gas constant:", ideal_Gas_Constant, ", Atmospheric pressure: 1 atm) \n");
  print("\n");
  print("*******************\n");
  print("\n");
}

void draw()
{
  background(250);
  
  distanceToUP = dist(tempSX + 10, tempSY + 50, mouseX, mouseY);
  distanceToDN = dist(tempSX + 90, tempSY + 50, mouseX, mouseY);
  
  drawCylinder(50, 100, 300, 600);
  drawWindow(450, 200, 300, 100, 50);
  drawTemp(tempSX, tempSY, 40);
  calculate();
  indicateResult(450, 200);
  drawPiston(50, 100, 300);
  
}

void mousePressed()
{
  if (distanceToUP <= 20){
    temp = temp + 10;
    if (temp > 600){
      print("! Maximum temperature ! \n"); // alert maximum temp
      temp = 600;
    } else {
      print("Current Gas Volume:", volume, ", Current Gas Temperature:", temp, "\n");
    }
  }
  if (distanceToDN <= 20){
    temp = temp - 10;
    if (temp < 0){
      print("! Minimum temperature ! \n"); // alert minimum temp
      temp = 0;
    } else {
      print("Current Gas Volume:", volume, ", Current Gas Temperature:", temp, "\n");
    }
  }
}
