class Calmar extends Boss
{
  Calmar(SoundMaster p_soundMaster)
  {
    super(p_soundMaster);
    for (int i = 0; i < 2; i++) 
    {
      boss[i] = loadImage("boss/calmar img"+i+".png");
    }
    deadBoss = loadImage("boss/calmar-dead.png");
    attack = loadImage("boss/jet_d_encre.png");
    
    
    pos = append(pos, height/2);
    vie = 10;
  }
}
