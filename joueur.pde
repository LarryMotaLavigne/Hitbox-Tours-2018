class Joueur extends PlayableObject
{
  int[] pos = { 100, 360 };
  int[] size = {245, 169};
  
  PImage[] joueur = new PImage[2], coeur = new PImage[8];
  
  Joueur()
  {
    for (int i = 0; i < 2; i++)
    {
      joueur[i] = loadImage("sous-marin img"+i+".png");
    }
    for (int i = 1; i < 9; i++)
    {
      coeur[i-1] = loadImage("data/joueur/Health/frame-"+i+".png");
    }
  }
  
  void resetPlayer()
  {
    frequenceTirs = 0;
    vie = 3;
    degat = 0;
    //pos = [100, 360];
    //joueur = new PImage[4]; coeur = new PImage[8];
    //tirs = new ArrayList<Tir>();
  }
    
  void afficher()
  {
    for (int i = 0; i < vie; i++)
    {
      if (int(frameCount/4)%64 <= 8) image(coeur[int(frameCount/4)%coeur.length], i*48, 0, 48, 48);
      else image(coeur[0], i*48, 0, 48, 48);
    }
    textAlign(CENTER, CENTER);
    text(str(score)+"/"+ennemisGeneres, width/2, 24, 48);
    if (degat > 0)
    {
      tint(255, 0, 0);
      degat--;
    }
    if (degat < 0)
    {
      tint(0, 255, 0);
      degat++;
    }

    image(joueur[(frameCount/5)%2],pos[0], pos[1], size[0], size[1]);
 
    tint(255, 255, 255);
    for (int i = 0; i < tirs.size(); i++)
    {
      if (tirs.get(i).pos[0] > width) tirs.remove(i);
    }
    for (Tir tir : tirs)
    {
      tir.afficher();
    }
    tint(255, 255, 255);
  }
  
  void degat()
  {
    vie --;
    degat = 15;
  }
  
  void soin()
  {
    vie ++;
    degat = -15;
  }
  
    void action(boolean[] touches)
  {
    if (touches[0] && pos[1] > 0) pos[1] -= 10; 
    if (touches[1] && pos[0] > 0) pos[0] -= 10; 
    if (touches[2] && pos[1] < height-size[1]) pos[1] += 10; 
    if (touches[3] && pos[0] < width-size[0]) pos[0] += 10; 
    if (touches[4])
    {
      if (frequenceTirs%12 == 0)
      {
        tirer();
      }
      frequenceTirs++;
    } 
    else
    {
      frequenceTirs = 0;
    }
    
    
    for (Tir tir : tirs)
    {
      tir.deplacer();
      tir.afficher();
    }
  }
  
  void tirer()
  {
    tirs.add(new Tir(pos[0], pos[1]));
  }
  

}
