class SoundMaster {
Minim minim;

// MUSIQUES
Music introMusic;
Music musicLevel_1;

// SONS TIRS
SoundEffect baseLaserShot;

// SONS MISC
// ENNEMY
SoundEffect ennemyHit;
OneTimeSoundEffect bossDeath;
OneTimeSoundEffect ennemyDeath;

// PLAYER
SoundEffect playerHit;
OneTimeSoundEffect playerDeath;

  SoundMaster(Minim p_minim){
    minim = p_minim;
    
    // MUSIQUE
    introMusic = new Music(minim, "intro", "/Sound/Music/Remastered/MenuIntroRM.mp3");
    musicLevel_1 = new Music(minim, "level1", "/Sound/Music/Remastered/VolumeAdjusted/Level1MusicRM.mp3");
    
    // TIRS
    baseLaserShot = new SoundEffect(minim, "baseLaserShot", "/Sound/Shoot/Remastered/VolumeAdjusted/BaseLaserShotRM.mp3");
    
    // MISC
    // ENNEMY
    ennemyHit = new SoundEffect(minim, "ennemyHit", "/Sound/Misc/Remastered/VolumeAdjusted/EnnemyHitRM.mp3");
    ennemyDeath = new OneTimeSoundEffect(minim, "ennemyDeath", "/Sound/Misc/Remastered/EnnemyDeathRM.mp3");
    bossDeath = new OneTimeSoundEffect(minim, "bossDeath", "/Sound/Misc/Remastered/VolumeAdjusted/BossDeathRM.mp3");
    
    // PLAYER
    playerHit = new SoundEffect(minim, "playerHit", "/Sound/Misc/Remastered/PlayerHitRM.mp3");
    playerDeath = new OneTimeSoundEffect(minim, "playerDeath", "/Sound/Misc/Remastered/PlayerDeathRM.mp3");
    
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
      // SHOT
      case "baseLaserShot":
        baseLaserShot.start();
        break;
      
      // ENNEMY
      case "ennemyHit":
        ennemyHit.start();
        break;
      
      case "ennemyDeath":
        ennemyDeath.start();
        break;
      
      case "bossDeath":
        bossDeath.start();
        break;
        
      // PLAYER
      case "playerHit":
        playerHit.start();
        break;
      
      case "playerDeath":
        playerDeath.start();
        break;
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
  
  void startOneTimeEffect(){
  
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

class OneTimeSoundEffect extends SoundEffect{
  boolean hasBeenPlayed = false;
  
  OneTimeSoundEffect(Minim p_minim, String p_effectName, String p_effectPath){
    super(p_minim, p_effectName, p_effectPath);
  }
  
  void start(){
    if(!hasBeenPlayed){
      hasBeenPlayed = true;
      super.start();
    }
  }
}
