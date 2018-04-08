interface IGameObject
{
  void afficher();
}

abstract class NonPlayableObject implements IGameObject
{
  abstract boolean collision();
}

abstract class PlayableObject implements IGameObject
{
  // Parameters
  int frequenceTirs = 0;
  int vie = 3;
  int degat = 0;
  int score;
  int[] pos = {0, 0};
  ArrayList<Tir> tirs = new ArrayList<Tir>();
  
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
  
  void tirer()
  {
    tirs.add(new Tir(pos[0], pos[1]));
  }

}
