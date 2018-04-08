class Calmar extends Boss
{
  Calmar(SoundMaster p_soundMaster)
  {
    super(p_soundMaster, "calmarBossDeath");
    
    for (int i = 0; i < 2; i++) 
    {
      boss[i] = loadImage("boss/calmar img"+i+".png");
    }
    deadBoss = loadImage("boss/calmar-dead.png");
    
    for (int i = 1; i <= 5; i++) 
    {
      attack[i-1] = loadImage("boss/jet_d_encre"+i+".png");
    }
    
    pos = append(pos, height/2);
    vie = 12;
  }
}
