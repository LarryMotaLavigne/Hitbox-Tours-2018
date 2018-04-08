class Boss extends NonPlayableObject
{
  int[] pos = { width };
  int[] size = {300,300};
  PImage[] boss = new PImage[2];
  boolean goToTop=true;
  int vie;
 
  SoundMaster soundMaster;
 
  Boss(SoundMaster p_soundMaster){
    soundMaster = p_soundMaster;
  }
  
  void afficher()
  {
    image(boss[(frameCount/5)%2],pos[0], pos[1], size[0], size[1]);
  }
  
  void deplacer()
  {
    if(pos[0]+size[0]>width)
    {
      pos[0] -= 5;
    }
    else{ 
      // Go top
      if(goToTop)
      {
        if(pos[1]+size[1]>=height)
        {
          goToTop = !goToTop;
        }
        else
        {
          pos[1] += 5;
        }
      }
      // Go down
      else
      {
        if(pos[1]<0)
        {
          goToTop = !goToTop;
        }
        else
        {
          pos[1] -= 5;
        }
      }
    }
  }
  
  boolean collision()
  {
    if(joueur.pos[0] < pos[0]+size[0] && joueur.pos[0]+joueur.size[0] > pos[0] && joueur.pos[1] < pos[1]+size[1] && joueur.pos[1]+joueur.size[1] > pos[1])   
    {
      joueur.degat();
      return true;
    }
    
    for (int i = 0; i < joueur.tirs.size(); i++)
    {
      if (joueur.tirs.get(i).pos[1] >= pos[1] && joueur.tirs.get(i).pos[1] < pos[1]+size[1] && joueur.tirs.get(i).pos[0] > pos[0] && joueur.tirs.get(i).pos[0]+20 < pos[0]+size[0])
      {
        joueur.tirs.remove(i);
        joueur.score++;
        return true;
      }
    }
    return false; 
  }
}


class Calmar extends Boss
{
  Calmar(SoundMaster p_soundMaster)
  {
    super(p_soundMaster);
    for (int i = 0; i < 2; i++) 
    {
      boss[i] = loadImage("calmar img"+i+".png");
    }
    
    pos = append(pos, height/2);
    vie = 10;
  }
}


class Owen extends Boss
{
  Owen(SoundMaster p_soundMaster)
  {
    super(p_soundMaster);
    
    for (int i = 0; i < 2; i++) 
    {
      boss[i] = loadImage("owen img"+i+".png");
    }
    
    pos = append(pos, height/2);  
  }
}
