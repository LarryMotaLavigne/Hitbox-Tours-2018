class Boss extends NonPlayableObject
{
  int[] pos = { width };
  int[] size = {300,300};
  PImage[] boss = new PImage[2];
  PImage deadBoss = new PImage();
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
  
  void afficherDeath()
  {
    image(deadBoss,pos[0], pos[1], size[0], size[1]);
  }
  
  void moveDead()
  {
    if(size[1] + pos[1] > 0){
      pos[1] += 5;  
    }
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
    }   }
  
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
        soundMaster.playSoundEffect("ennemyHit");
        joueur.tirs.remove(i);
        joueur.score++;
        return true;
      }
    }
    return false; 
  }
}
