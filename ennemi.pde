class Ennemi extends NonPlayableObject
{
  int[] pos = { width };
  int[] size = {150, 109};
  PImage[] ennemi = new PImage[2];
  SoundMaster soundMaster;
  
  Ennemi(SoundMaster p_soundMaster)
  {
    for (int i = 0; i < 2; i++) 
    {
      ennemi[i] = loadImage("poisson img"+i+".png");
    }
    
    pos = append(pos, int(random(height-90-98-10)));
    
    soundMaster = p_soundMaster;
  }
  
  void deplacer()
  {
    pos[0] -= 5;
  }
  
  void afficher()
  {
    image(ennemi[(frameCount/5)%2],pos[0], pos[1], size[0], size[1]);
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
        soundMaster.playSoundEffect("ennemyHit");
        joueur.tirs.remove(i);
        joueur.score++;
        return true;
      }
    }
    return false; 
  } 
}
