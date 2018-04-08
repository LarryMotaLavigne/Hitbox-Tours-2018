class Tir
{
  int[] pos = {0, 0};
  int[] size = {20, 20};
  
  Tir(int x, int y)
  {
    pos[0] = x + 170;
    pos[1] = y + 220;
  }
  
  void deplacer()
  {
    pos[0] += 50;
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