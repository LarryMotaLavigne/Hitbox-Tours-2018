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
//PFont fonteContours, fonteRemplissage;

// Character Management
Boss calmar;
Boss owen;
Decor decor;
Joueur joueur;
ArrayList<Ennemi> ennemis = new ArrayList<Ennemi>();

// Scene Management
enum Scene {
  Menu, Game, GameOver
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
  size(1280, 720, P2D);
  noSmooth();
  noStroke();
  noFill();
  citations = loadStrings("citations.txt");
  for (int i = 0; i < citations.length; i++)
  {
    citations[i] = citations[i].replaceAll("§","\n");
  }
  IDCitation = int(random(0, citations.length));
  //colorMode(HSB);
  police = createFont("Velvet Heart Font.ttf", 128);
  textSize(48);
  textFont(police);
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
  case GameOver:
    drawGameOver();
    break;
  }
}

void drawMenu()
{
  // Music de l'intro
  soundMaster.playIntro();
  
  text(mouseX+"    "+mouseY, mouseX, mouseY);
  background(204);
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
  fill(255,200);
  rect(width/2, height-140, 600, 140, 3);
  fill(0);
  noStroke();
  textAlign(CENTER, CENTER);
  textLeading(40);
  text(citations[IDCitation], width/2, height-150);
  rectMode(CORNER);
}

void drawGame()
{
  // Music du niveau
  soundMaster.playLevelMusic();
  
  if (focused && !pause)
  {
    surface.setTitle(str(frameRate));

    decor.afficherFond();
    joueur.afficher();
    gestionDesBoss();
    //gestionDesEnnemis();
    joueur.action(touches);
    decor.afficherFiligranes();
  } else if (moche++ == 0)
  {
    for (int i = 0; i < touches.length; i++) touches[i] = false;
    text("Pause", width/2, height/2-36, 72);
    text("Quitter", width/2, height/2+24, 48);
  }
}


void drawGameOver()
{
  background(204);
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
}

/******************************************************************************************/
/*                                       UTILITIES                                        */
/******************************************************************************************/


//void text(String t, int x, int y, int d)
//{
//  fill(255);
//  textFont(fonteRemplissage, d);
//  text(t, x, y);
//  fill(0);
//  textFont(fonteContours, d);
//  text(t, x, y);
//  noFill();
//}


void gestionDesEnnemis()
{
  if (int(random(100)) == 0)
  {
    ennemis.add(new Ennemi());
    ennemisGeneres++;
    //surface.setTitle("Ennemis : "+ennemis.size());
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


void gestionDesBoss()
{
  if(calmar==null){
    calmar = new Calmar();
  }
  
  if(calmar.collision())
  {
    calmar.vie--;
  }
  
  if(calmar.vie >= 0)
  {
    calmar.deplacer();
    calmar.afficher();
  }
  else
  {
    calmar.moveDead(); 
    calmar.afficherDeath();
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
      state = Scene.Game;
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
