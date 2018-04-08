class Decor
{
  PImage[] filigranes = new PImage[10], fonds = new PImage[2];

  Decor()
  {
    fonds[0] = loadImage("décor/background.png");
    fonds[1] = loadImage("fond.png");
    for (int i = 1; i < 9; i++) filigranes[i-1] = loadImage("filigranes/texture00"+i+".png");
  }

  void afficherFond()
  {
    image(fonds[state != Scene.Game ? 0 : 1], 0, 0);
  }
  void afficherFiligranes()
  {
    image(filigranes[(frameCount/3)%8], 0, 0);
  }
}