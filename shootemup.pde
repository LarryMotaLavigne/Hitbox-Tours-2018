// Game Parameters
boolean pause = false;
boolean[] touches = new boolean[5];
int ennemisGeneres = 0, moche = 0;
int vitesse = 5;

// Image & Font Management
PFont fonteContours, fonteRemplissage;

// Character Management
//Boss boss;
Decor decor;
Joueur joueur;
ArrayList<Ennemi> ennemis = new ArrayList<Ennemi>();


// Scene Management
enum Scene{Menu, Game, GameOver}
Scene state=Scene.Menu;

/******************************************************************************************/
/*                                       GAME INIT                                        */
/******************************************************************************************/
void setup()
{
  size(1280, 720, P2D);
  noSmooth();
  noFill();
  //colorMode(HSB);
  fonteContours = createFont("data/WIDEAWAKE.TTF", 128);
  fonteRemplissage = createFont("data/WIDEAWAKEBLACK.ttf", 128);
  joueur = new Joueur();
  decor = new Decor();
}

/******************************************************************************************/
/*                                  DRAWING FUNCTIONS                                     */
/******************************************************************************************/

// Main Loop
void draw()
{
  switch(state){
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
  text(mouseX+"    "+mouseY, mouseX, mouseY);
  background(204);
  fill(255, 255, 255);
  rect(width/2 - 60, height/2 - 85 , 120, 30);
  fill(255, 255, 255);
  rect(width/2 - 60, height/2 + 15, 120, 30);
  textAlign(CENTER);
  textSize(26);
  text("Darwin Quest : A Bad Owen", width/2, 150);
  fill(0, 0, 0);
  textAlign(CENTER);
  text("Start", width/2, 300);
  textAlign(CENTER);
  text("Exit", width/2, 400);
}

void drawGame()
{
    
  if (focused && !pause)
  {
    surface.setTitle(str(frameRate));

    decor.afficher();
    joueur.afficher();
    gestionDesEnnemis();
    joueur.action(touches);
    
  } else if (moche++ == 0)
  {
    for (int i = 0; i < touches.length; i++) touches[i] = false;
    texte("Pause", width/2, height/2-36, 72);
    texte("Quitter", width/2, height/2+24, 48);
  }
}


void drawGameOver()
{
  background(204);
  fill(255, 255, 255);
  rect(width/2 - 60, height/2 - 85 , 120, 30);
  fill(255, 255, 255);
  rect(width/2 - 60, height/2 + 15, 120, 30);
  textAlign(CENTER);
  textSize(35);
  text("GAME OVER", width/2, 150);
  fill(0, 0, 0);
  textAlign(CENTER);
  text("Retry", width/2, 300);
  textAlign(CENTER);
  text("Menu", width/2, 400);
}

/******************************************************************************************/
/*                                       UTILITIES                                        */
/******************************************************************************************/


void texte(String t, int x, int y, int d)
{
  fill(255);
  textFont(fonteRemplissage, d);
  text(t, x, y);
  fill(0);
  textFont(fonteContours, d);
  text(t, x, y);
  noFill();
}


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
      if(joueur.vie <= 0)
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


/******************************************************************************************/
/*                                   INPUT MANAGER                                        */
/******************************************************************************************/

void keyPressed()
{
  if (key == 'z' || keyCode == UP    ) touches[0] = true;
  if (key == 'q' || keyCode == LEFT  ) touches[1] = true;
  if (key == 's' || keyCode == DOWN  ) touches[2] = true;
  if (key == 'd' || keyCode == RIGHT ) touches[3] = true;
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
  if (key == 'z' || keyCode == UP    ) touches[0] = false;
  if (key == 'q' || keyCode == LEFT  ) touches[1] = false;
  if (key == 's' || keyCode == DOWN  ) touches[2] = false;
  if (key == 'd' || keyCode == RIGHT ) touches[3] = false;
  if (key == ' ') touches[4] = false;
}

void mousePressed()
{
  if(state==Scene.Menu)
  {
    if ((mouseX>=(width/2-60) && mouseX<=(width/2+60)) && (mouseY>=(height/2-85) && mouseY<=(height/2-55)))
    {
      state = Scene.Game;
    }
    else if((mouseX>=(width/2-60) && mouseX<=(width/2+60)) && (mouseY>=(height/2+15) && mouseY<=(height/2+45)))
    {
      exit();    
    }
  }
  else if(state==Scene.GameOver)
  {
    if ((mouseX>=(width/2-60) && mouseX<=(width/2+60)) && (mouseY>=(height/2-85) && mouseY<=(height/2-55)))
    {
      state = Scene.Game;
    }
    else if((mouseX>=(width/2-60) && mouseX<=(width/2+60)) && (mouseY>=(height/2+15) && mouseY<=(height/2+45)))
    {
      state = Scene.Menu;   
    }
  }
}
