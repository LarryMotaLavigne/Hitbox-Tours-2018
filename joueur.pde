class Joueur extends PlayableObject
{
  int[] pos = { 100, 360 };
  int[] size = {245, 169};

  PImage[] coeur = new PImage[8];
  PImage[][] joueur = new PImage[3][2];
  SoundMaster soundMaster;

  Joueur(SoundMaster p_soundMaster)
  {
    for (int i = 0; i < 3; i++)
    {
      for (int j = 0; j < 2; j++)
      {
        joueur[i][j] = loadImage("sous-marin img"+i+""+j+".png");
      }
    }
    for (int i = 1; i < 9; i++)
    {
      coeur[i-1] = loadImage("data/joueur/Health/frame-"+i+".png");
    }

    soundMaster = p_soundMaster;
  }

  void resetPlayer()
  {
    frequenceTirs = 0;
    vie = 3;
    degat = 0;
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
    
    if (vie <= 0)
    {
      image(joueur[2][(frameCount/5)%2], pos[0], pos[1], size[0], size[1]);
    }
    else if (degat > 0)
    {
      image(joueur[1][(frameCount/5)%2], pos[0], pos[1], size[0], size[1]);
    }
    else
    {
      image(joueur[0][(frameCount/5)%2], pos[0], pos[1], size[0], size[1]);
    }

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
    if (touches[0] && pos[1] > 0) pos[1] -= 10 * speed; 
    if (touches[1] && pos[0] > 0) pos[0] -= 10 * speed; 
    if (touches[2] && pos[1] < height-size[1]) pos[1] += 10 * speed; 
    if (touches[3] && pos[0] < width-size[0]) pos[0] += 10 * speed; 
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

  void tirer()
  {
    tirs.add(new Tir(pos[0], pos[1]));
    soundMaster.playSoundEffect("baseLaserShot");
  }
}