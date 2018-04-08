class SoundMaster {
Minim minim;

Music introMusic;
Music musicLevel_1;

  SoundMaster(Minim p_minim){
    minim = p_minim;
    introMusic = new Music(minim, "intro", "/Sound/Music/Remastered/MenuIntroRM.mp3");
    musicLevel_1 = new Music(minim, "level1", "/Sound/Music/Remastered/FirstMusicRadioFM.mp3");
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
}

class Music{
  Minim minim;
  AudioPlayer player;
  
  String musicName = "";
  String musicPath = "";
  
  Music(Minim p_minim, String p_musicName, String p_musicPath){
    minim = p_minim;
    
    musicName = p_musicName;
    musicPath = p_musicPath;
    
    player = minim.loadFile(musicPath);
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
