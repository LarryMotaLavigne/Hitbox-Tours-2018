class Tir
{
  int[] pos = {0, 0};
  int[] size = {20, 20};
  int speed = 2;
  
  Tir(int x, int y, int w, int h)
  {
    pos[0] = x + 90;
    pos[1] = y + 100;
    size[0] = w;
    size[1] = h;
  }
  
  Tir(int x, int y)
  {
    pos[0] = x + 90;
    pos[1] = y + 100;
  }
  
  void deplacer()
  {
    pos[0] += 25 * speed;
  }
  
  void afficher()
  {
    //stroke(4, 168, 255);
    stroke(255,0,0);
    strokeWeight(7);  
    line(pos[0], pos[1], pos[0]+size[0], pos[1]);
    stroke(255);
    strokeWeight(1);
    line(pos[0], pos[1], pos[0]+size[1], pos[1]);
  }

}
