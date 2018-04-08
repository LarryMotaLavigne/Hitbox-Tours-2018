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
    vie = 30;
  }
}
