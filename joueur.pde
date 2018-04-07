class Joueur
{
  int frequenceTirs = 0, vie = 3, degat = 0, score;
  int[] pos = { 100, 360 };
  PImage[] joueur = new PImage[2], coeur = new PImage[8];
  ArrayList<Tir> tirs = new ArrayList<Tir>();
  
  Joueur()
  {
    for (int i = 0; i < 2; i++) 
      joueur[i] = loadImage("sous-marin img"+i+".png");
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
  
  void action(boolean[] touches)
  {
    if (touches[0] && pos[1] > 0) pos[1] -= 10;
    if (touches[1] && pos[0] > 0) pos[0] -= 10;
    if (touches[2] && pos[1] < height-120-98) pos[1] += 10;
    if (touches[3] && pos[0] < width-152) pos[0] += 10;
    if (touches[4])
    {
      if (frequenceTirs%12 == 0)
      {
        tirer();
      }
      frequenceTirs++;
    } else
    {
      frequenceTirs = 0;
    }
    for (Tir tir : tirs)
    {
      tir.deplacer();
      tir.afficher();
    }
  }
  
  void afficher()
  {
    for (int i = 0; i < vie; i++)
    {
      if (int(frameCount/4)%64 <= 8) image(coeur[int(frameCount/4)%coeur.length], i*48, 0, 48, 48);
      else image(coeur[0], i*48, 0, 48, 48);
    }
    textAlign(CENTER, CENTER);
    texte(str(score)+"/"+ennemisGeneres, width/2, 24, 48);
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
    //stroke(4,168,255);
    //rect(pos[0], pos[1],152,120);
    pos[0] += (int(touches[3])-int(touches[1]))*vitesse;
    pos[1] += (int(touches[2])-int(touches[0]))*vitesse;
    image(joueur[(frameCount/5)%2],pos[0], pos[1], 280, 280);

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
    //println(tirs.size());
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
  
  void tirer()
  {
    tirs.add(new Tir(pos[0], pos[1]));
  }
  
  
  
  class Tir
  {
    int[] pos = new int[2];
    
    Tir(int x, int y)
    {
      pos[0] = x + 110;
      pos[1] = y + 90;
    }
    
    void deplacer()
    {
      pos[0] += 50;
    }
    
    void afficher()
    {
      //stroke(4, 168, 255);
      stroke(255,0,0);
      strokeWeight(7);
      line(pos[0], pos[1], pos[0]+20, pos[1]);
      stroke(255);
      strokeWeight(1);
      line(pos[0], pos[1], pos[0]+20, pos[1]);
    }
  }
}
