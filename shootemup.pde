import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// Game Parameters
boolean pause = false;
boolean[] touches = new boolean[5];
int ennemisGeneres = 0, moche = 0, vitesse = 5, IDCitation;
String[] citations;

// Image & Font Management
PFont police;
PImage[] guillemets = new PImage[2];
//PFont fonteContours, fonteRemplissage;

// Character Management
Boss calmar;
Boss owen;
Decor decor;
Joueur joueur;
ArrayList<Ennemi> ennemis = new ArrayList<Ennemi>();
boolean isOwenDead = false;
boolean isCalmarDead = false;
boolean isFirstWaveDead = false;
long firstWaveMilli = 0;
boolean isSecondWaveDead = false;
long secondWaveMilli = 0;
int waveTime = 15; // in seconds

// Scene Management
enum Scene {
  Menu, Game, GameOver, Intro, Win
}
Scene state=Scene.Menu;

// Music Management
Minim minim;
SoundMaster soundMaster;

/******************************************************************************************/
/*                                       GAME INIT                                        */
/******************************************************************************************/
void setup()
{
  surface.setTitle("Darwin's Quest: A Bad Owen");
  //surface.setLocation(200,200);
  size(1280, 720, P2D);
  frameRate(30);
  noSmooth();
  noStroke();
  noFill();
  citations = loadStrings("citations.txt");
  for (int i = 0; i < citations.length; i++)
  {
    citations[i] = citations[i].replaceAll("§", "\n");
  }
  IDCitation = int(random(0, citations.length));
  //colorMode(HSB);
  police = createFont("Velvet Heart Font.ttf", 128);
  textSize(48);
  textFont(police);
  guillemets[0] = loadImage("guillemets0.png");
  guillemets[1] = loadImage("guillemets1.png");
  //fonteContours = createFont("data/WIDEAWAKE.TTF", 128);
  //fonteRemplissage = createFont("data/WIDEAWAKEBLACK.ttf", 128);

  // Musiques et Sons
  minim = new Minim(this);
  soundMaster = new SoundMaster(minim);


  joueur = new Joueur(soundMaster);
  decor = new Decor();
}

/******************************************************************************************/
/*                                  DRAWING FUNCTIONS                                     */
/******************************************************************************************/

// Main Loop
void draw()
{
  switch(state) {
  case Menu:
    drawMenu();
    break;
  case Game:
    drawGame();
    break;
  case Intro:
    drawIntro();
    break;
  case GameOver:
    drawGameOver();
    break;
  case Win:
    drawWin();
    break;
  }
}

void drawMenu()
{
  background(255);
  // Music de l'intro
  soundMaster.playIntro();
  pushMatrix();
  translate(0, random(8)-4);
  text(mouseX+"    "+mouseY, mouseX, mouseY);
  decor.afficherFond();
  fill(255, 255, 255);
  rect(width/2 - 60, height/2 - 85, 120, 30, 3);
  fill(255, 255, 255);
  rect(width/2 - 60, height/2 + 15, 120, 30, 3);
  textAlign(CENTER);
  textSize(128);
  text("Darwin's Quest", width/2, 150);
  textSize(80);
  text("A Bad Owen", width/2, 200);
  textSize(48);
  fill(0, 0, 0);
  text("Start", width/2, 300);
  text("Exit", width/2, 400);
  rectMode(CENTER);
  stroke(0);
  fill(255, 200);
  rect(width/2, height-140, 600, 140, 3);
  image(guillemets[0], width/2-300, height-208, 57, 45);
  image(guillemets[1], width/2+300-58, height-70-47, 57, 45);
  fill(0);
  noStroke();
  textAlign(CENTER, CENTER);
  textLeading(40);
  text(citations[IDCitation], width/2, height-150);
  rectMode(CORNER);
  decor.afficherFiligranes();
  popMatrix();
}

void drawWin()
{
  // Music de l'intro
  soundMaster.playIntro();

  decor.afficherFond();
  textAlign(CENTER);
  textSize(128);
  text("Darwin's Quest", width/2, 350);
  textSize(80);
  text("A Bad Owen", width/2, 400);
  textSize(68);
  text("Félicitations !\nVous avez finis la démo de :", width/2, 200);
  textSize(38);
  text("Réalisation : Valentine, Clément, Florian et Larry.", width/2, 680);
  textSize(28);
  text("Avec le soutien de David Goodenough", width/2, 710);
  textSize(48);
  rectMode(CENTER);
  stroke(0);
  fill(255, 200);
  rect(width/2, height-140, 600, 140, 3);
  fill(0);
  noStroke();
  textAlign(CENTER, CENTER);
  textLeading(40);
  text(citations[IDCitation], width/2, height-150);
  rectMode(CORNER);
  decor.afficherFiligranes();
}


void drawIntro()
{
  soundMaster.playIntro();
  decor.afficherFond();
  textAlign(CENTER);
  textSize(48);
  rectMode(CENTER);
  stroke(0);
  fill(255, 200);
  rect(width/2, height-340, 600, 800, 3);
  fill(0);
  noStroke();
  textAlign(CENTER, CENTER);
  textLeading(40);
  text("Charles Darwin a découvert que l’Homme avait \n un ancêtre en commun avec les primates!\n\n Tellement content de sa découverte\n il décide de publier un livre de cette théorie.\n Il en parle à son rival\n 'Sir Richard Owen'\n qui n’est pas d’accord avec lui.\n Ce dernier décide de prendre les notes\n de sa découverte afin de l'empêcher\n de publier son fameux livre :\n 'L'origine des espèces'", width/2, height-370);
  rectMode(CORNER);
  text("Appuyez sur 'Espace' pour aider Darwin !", width/2, height-60);
  PImage darwin = loadImage("darwin.png");
  image(darwin, -140, -30);
  text("Charles Darwin", 170, 600);
  PImage owen = loadImage("owen.png");
  image(owen, 800, 200);
  text("Richard Owen", 1080, 200);
  text("Utilise les flèches pour Bouger !", 1111, 20);
  text("Et la barre Espace pour Tirer !", 1111, 60);
  decor.afficherFiligranes();
}


void drawGame()
{
  if (focused && !pause)
  {
    decor.afficherFond();
    joueur.afficher();
    wave();
    joueur.action(touches);
    decor.afficherFiligranes();
  } else if (moche++ == 0)
  {
    for (int i = 0; i < touches.length; i++) touches[i] = false;
    text("Pause", width/2, height/2-36, 72);
    //text("Quitter", width/2, height/2+24, 48);
  }
}


void drawGameOver()
{
  background(255);
  pushMatrix();
  translate(0, random(8)-4);
  decor.afficherFond();
  fill(255, 255, 255);
  rect(width/2 - 60, height/2 - 85, 120, 30, 3);
  fill(255, 255, 255);
  rect(width/2 - 60, height/2 + 15, 120, 30, 3);
  textAlign(CENTER);
  textSize(80);
  text("GAME OVER", width/2, 150);
  textSize(48);
  fill(0, 0, 0);
  textAlign(CENTER);
  text("Retry", width/2, 300);
  textAlign(CENTER);
  text("Menu", width/2, 400);
  decor.afficherFiligranes();
  popMatrix();
}

/******************************************************************************************/
/*                                       UTILITIES                                        */
/******************************************************************************************/

void wave()
{
  if(!isFirstWaveDead)
  {
    // Music du niveau
    soundMaster.playLevelMusic();
    
    if(firstWaveMilli==0)
    {
      firstWaveMilli = millis();
    }
    waveEnnemies(waveTime, firstWaveMilli);
  }
  else if(!isCalmarDead)
  {
    waveCalmar();
  }
  else if(!isSecondWaveDead)
  {
    if(secondWaveMilli==0)
    {
      secondWaveMilli = millis();
    }
    waveEnnemies(waveTime, secondWaveMilli); 
  }
  else if(!isOwenDead)
  {
    waveOwen();
  }
  else{
    state = Scene.Win;
    soundMaster.playIntro();
  }
}

void waveEnnemies(int seconds, long beginTime)
{
  if(millis()-beginTime > seconds * 1000)
  {
    if(!isFirstWaveDead)
      isFirstWaveDead = true;
    else if(!isSecondWaveDead)
      isSecondWaveDead = true;
  }
  
  if (int(random(70)) == 0)
  {
    ennemis.add(new Ennemi(soundMaster));
    ennemisGeneres++;
  }
  for (int i = 0; i < ennemis.size(); i++)
  {
    if (ennemis.get(i).pos[0] < -168 || ennemis.get(i).collision())
    {
      ennemis.remove(i);
      if (joueur.vie <= 0)
      {
        state = Scene.GameOver;
        joueur.resetPlayer();
      }
    }
  }
  for (Ennemi ennemi : ennemis)
  {
    ennemi.deplacer();
    ennemi.afficher();
  }
}


void waveCalmar()
{
  if(calmar==null){
    calmar = new Calmar(soundMaster);
  }

  if (calmar.collision())
  {
    calmar.vie--;
  }
  if (calmar.vie >= 0)
  {
    calmar.attack();
    calmar.attackCollision();
    calmar.deplacer();
    calmar.afficher();
  } 
  else
  {
    calmar.afficherDeath();
    isCalmarDead = calmar.moveDead();
  }
}

void waveOwen()
{
  if(owen==null){
    owen = new Owen(soundMaster);
    soundMaster.playOwenMusic();
  }

  if (owen.collision())
  {
    owen.vie--;
  }
  if (owen.vie >= 0)
  {
    owen.attack();
    owen.attackCollision();
    owen.deplacer();
    owen.afficher();
  } else
  {
    owen.afficherDeath();
    isOwenDead = owen.moveDead(); 
  }
}


/******************************************************************************************/
/*                                   INPUT MANAGER                                        */
/******************************************************************************************/

void keyPressed()
{
  if (key == 'z' || key == 'Z' || keyCode == UP    ) touches[0] = true;
  if (key == 'q' || key == 'Q' || keyCode == LEFT  ) touches[1] = true;
  if (key == 's' || key == 'S' || keyCode == DOWN  ) touches[2] = true;
  if (key == 'd' || key == 'D' || keyCode == RIGHT ) touches[3] = true;
  if (key == ' ') touches[4] = true;

  //contrôles pour tester les dégâts et soins
  if (key == '-') joueur.degat();
  if (key == '+') joueur.soin();
  if (keyCode == TAB) surface.setLocation(275, 150);
  if ((key == ' ' || keyCode == ENTER) && state==Scene.Menu) state = Scene.Intro;
  if ((key == ' ' || keyCode == ENTER) && state==Scene.Intro) state = Scene.Game;
  if ((key == ' ' || keyCode == ENTER) && state==Scene.Win) state = Scene.Menu;
  if ((key == ' ' || keyCode == ENTER) && state==Scene.GameOver) state = Scene.Game;
  if (key == ESC)
  {
    pause = !pause;
    moche = 0;
  }
  key = 0;
}

void keyReleased()
{
  if (key == 'z' || key == 'Z' || keyCode == UP    ) touches[0] = false;
  if (key == 'q' || key == 'Q' || keyCode == LEFT  ) touches[1] = false;
  if (key == 's' || key == 'S' || keyCode == DOWN  ) touches[2] = false;
  if (key == 'd' || key == 'D' || keyCode == RIGHT ) touches[3] = false;
  if (key == ' ') touches[4] = false;
}

void mousePressed()
{
  if (state==Scene.Menu)
  {
    if ((mouseX>=(width/2-60) && mouseX<=(width/2+60)) && (mouseY>=(height/2-85) && mouseY<=(height/2-55)))
    {
      state = Scene.Intro;
    } else if ((mouseX>=(width/2-60) && mouseX<=(width/2+60)) && (mouseY>=(height/2+15) && mouseY<=(height/2+45)))
    {
      exit();
    }
  } else if (state==Scene.GameOver)
  {
    if ((mouseX>=(width/2-60) && mouseX<=(width/2+60)) && (mouseY>=(height/2-85) && mouseY<=(height/2-55)))
    {
      state = Scene.Game;
    } else if ((mouseX>=(width/2-60) && mouseX<=(width/2+60)) && (mouseY>=(height/2+15) && mouseY<=(height/2+45)))
    {
      IDCitation = int(random(0, citations.length));
      state = Scene.Menu;
    }
  }
}
