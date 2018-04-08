class Decor
{
  PImage gameBackground;
  PImage[] filigranes = new PImage[10];
  PImage menuBackground;
  
  Decor()
  {
    menuBackground = loadImage("décor/background.png");
    gameBackground = loadImage("fond.png");
    for (int i = 1; i < 9; i++) filigranes[i-1] = loadImage("filigranes/texture00"+i+".png");
  }
  
  void afficherFond()
  {
    background(gameBackground);
  }
  void afficherFiligranes()
  {
    image(filigranes[(frameCount/3)%8], 0, 0);
  }
  
  void afficherMenu()
  {
     background(menuBackground);
  }
}
