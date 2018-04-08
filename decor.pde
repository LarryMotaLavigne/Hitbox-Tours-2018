class Decor
{
  PImage fond;
  PImage[] filigranes = new PImage[10];

  Decor()
  {
    fond = loadImage("fond.png");
    for (int i = 1; i < 9; i++) filigranes[i-1] = loadImage("filigranes/texture00"+i+".png");
  }
  
  void afficherFond()
  {
    background(fond); //, 0, 0, width, height);
  }
  void afficherFiligranes()
  {
    image(filigranes[(frameCount/3)%8], 0, 0);
  }
}