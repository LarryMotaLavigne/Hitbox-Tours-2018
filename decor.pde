class Decor
{
  PImage[] fonds = new PImage[2];
  PImage[] filigranes = new PImage[10];

  Decor()
  {
    fonds[0] = loadImage("Background_intro.png");
    fonds[1] = loadImage("fond.png");
    for (int i = 1; i < 9; i++) filigranes[i-1] = loadImage("filigranes/texture00"+i+".png");
  }
  
  void afficherFond()
  {
    background(fonds[state == Scene.Menu ? 0 : 1]); //, 0, 0, width, height);
  }
  void afficherFiligranes()
  {
    image(filigranes[(frameCount/3)%8], 0, 0);
  }
}