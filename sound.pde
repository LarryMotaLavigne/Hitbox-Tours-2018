class SoundMaster {
Minim minim;

// MUSIQUES
Music introMusic;
Music musicLevel_1;

// SONS TIRS
SoundEffect baseShotLaser;

// SONS MISC
SoundEffect ennemyHit;

  SoundMaster(Minim p_minim){
    minim = p_minim;
    
    // MUSIQUE
    introMusic = new Music(minim, "intro", "/Sound/Music/Remastered/MenuIntroRM.mp3");
    musicLevel_1 = new Music(minim, "level1", "/Sound/Music/Remastered/FirstMusicRadioFM.mp3");
    
    // TIRS
    baseShotLaser = new SoundEffect(minim, "baseShot", "/Sound/Shoot/Remastered/BaseLaserShotRM.mp3");
    
    // MISC
    ennemyHit = new SoundEffect(minim, "ennemyHit", "/Sound/Misc/Remastered/EnnemyHitRM.mp3");
  }

  void playIntro(){
    stopLevelMusic();
    introMusic.start();
  }
  
  void stopIntro(){
    introMusic.stop();
  }
  
  void playLevelMusic(){
    stopIntro();
    musicLevel_1.start();
  }
  
  void stopLevelMusic(){
    musicLevel_1.stop();
  }
  
  void playSoundEffect(String effectName){
    switch(effectName){
      case "baseLaserShot":
        baseShotLaser.start();
      
      case "ennemyHit":
        ennemyHit.start();
    }
  }
}

class BaseSound{
  Minim minim;
  AudioPlayer player;
  
  String soundName = "";
  String soundPath = "";
  
  BaseSound(Minim p_minim, String p_soundName, String p_soundPath){
    minim = p_minim;
    
    soundName = p_soundName;
    soundPath = p_soundPath;
    
    player = minim.loadFile(soundPath);
  }
}

class Music extends BaseSound{
  Music(Minim p_minim, String p_musicName, String p_musicPath){
    super(p_minim, p_musicName, p_musicPath);
  }
  
  void start(){
    if(!player.isPlaying()){
      player.loop();
    }
  }
  
  void stop(){
    if(player.isPlaying()){
      player.pause();
      player.rewind();
    }
  }
  
}

class SoundEffect extends BaseSound {
  // A second player to avoid glitch when spamming the same sound ;)
  AudioPlayer player2;
  
  boolean usePlayer2 = false;
  
  SoundEffect(Minim p_minim, String p_effectName, String p_effectPath){
    super(p_minim, p_effectName, p_effectPath);
    player2 = minim.loadFile(p_effectPath);
  }
  
  void start(){
    if(usePlayer2){
      startPlayer(player2);
      usePlayer2 = false;
    }
    else{
      startPlayer(player);
      usePlayer2 = true;
    }
  }
  
  void startPlayer(AudioPlayer p_player){
    p_player.rewind();
    p_player.play();
  }
}
