class Owen extends Boss
{
  Owen(SoundMaster p_soundMaster)
  {
    super(p_soundMaster, "owenBossDeath");
    
    for (int i = 0; i < 2; i++) 
    {
      boss[i] = loadImage("boss/owen img"+i+".png");
    }
    deadBoss = loadImage("boss/owen-dead.png");
    
    for (int i = 1; i <= 5; i++) 
    {
      attack[i-1] = loadImage("boss/os"+i+".png");
    }
        
    pos = append(pos, height/2);
    vie = 20;
  }
}
