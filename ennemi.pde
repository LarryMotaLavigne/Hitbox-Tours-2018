class Ennemi
{
  int[] pos = { width };
  PImage[] ennemi = new PImage[2];
  Ennemi()
  {
    for (int i = 0; i < 2; i++) ennemi[i] = loadImage("poisson img"+i+".png");

    pos = append(pos, int(random(height-90-98-10)));
  }
  void deplacer()
  {
    pos[0] -= 5;
  }
  void afficher()
  {
    //stroke(255, 0, 0);
    //rect(pos[0], pos[1], 110, 90);
    image(ennemi[(frameCount/5)%2],pos[0], pos[1], 168, 90);
  }
  boolean collision()
  {
    if ((joueur.pos[0] > pos[0] && joueur.pos[0] < pos[0]+110 || joueur.pos[0]+152 > pos[0] && joueur.pos[0]+152 < pos[0]+110) && (pos[1] > joueur.pos[1] && pos[1] < joueur.pos[1]+120 || pos[1]+90 > joueur.pos[1] && pos[1]+90 < joueur.pos[1]+120)) // joueur.pos[1] >= pos[1] && joueur.pos[1] < pos[1]+120 || joueur.pos[0] > pos[0] || joueur.pos[0]+152 < 152)
    {
      joueur.degat();
      return true;
    }
    for (int i = 0; i < joueur.tirs.size(); i++)
    {
      if (joueur.tirs.get(i).pos[1] >= pos[1] && joueur.tirs.get(i).pos[1] < pos[1]+90 && joueur.tirs.get(i).pos[0] > pos[0] && joueur.tirs.get(i).pos[0]+20 < pos[0]+110)
      {
        joueur.tirs.remove(i);
        joueur.score++;
        return true;
      }
    }
    return false;
  }
}
