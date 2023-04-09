import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.OptionalInt;

TileStore tileStore;
int BOARD_WIDTH = 100;
int BOARD_HEIGHT = 100;
Board board;

int iteration = 0;


void setup() {
  size(800, 800);
  
  tileStore = new TileStore("tiles2.png", 64, 256, 256, 8, 8); //<>//
  board = new Board(BOARD_WIDTH, BOARD_HEIGHT, tileStore);
  board.setCell(int(random(BOARD_WIDTH)), int(random(BOARD_HEIGHT)), int(random(tileStore.getTileCount())), 0);
  //board.setCell(int(random(BOARD_WIDTH)), int(random(BOARD_HEIGHT)), 36, 0);
}



void draw() { 
  //if (1==1) {
  //  for (int i=0; i<16; i++) {
  //    tileStore.draw(i, 50*i, 50*i, 50, 50);
  //  }
  //  noLoop();
  //  return;
  //}
  OptionalInt minPotencyOptional = Arrays.stream(board.getCells())
    .filter(cell -> cell.getTileNumber() == -1)
    .mapToInt(cell -> cell.getPotency())
    .min();
    
  if (!minPotencyOptional.isPresent()) {
    board.draw();
    noLoop();
    System.out.println("Done!");
    return;
  }
    
  int minPotency = minPotencyOptional.getAsInt();
    
  List<Cell> list = Arrays.stream(board.getCells())
    .filter(cell -> cell.getTileNumber() == -1)
    .filter(cell -> cell.getPotency() == minPotency)
    .collect(Collectors.toList());
    
  int minLastIteration = list.stream()
    .mapToInt(cell -> cell.getLastIteration())
    .min()
    .getAsInt();
    
  list = list.stream().filter(it -> it.getLastIteration() == minLastIteration).collect(Collectors.toList());

  Cell chosenCell = list.get(int(random(list.size())));
  
  List<Integer> tileNumbers = tileStore.getCompatibles(chosenCell.getTileData());
  

  if (tileNumbers.size() == 0) {
    //if (1==1) {
    //  noLoop();
    //  return;
    //}
    chosenCell.setTileData(new int[] { -1, -1, -1, -1 });
    int rad = 4;
    for (int i = -rad; i <= rad; i++) {
      for (int j = -rad; j <= rad; j++) {
        if (i > -rad && i < rad && j > -rad && j < rad) {
          Cell c = board.getCellAt(chosenCell.getPosX()+i, chosenCell.getPosY()+j);
          c.setTileData(new int[] { -1, -1, -1, -1 });
          c.setTileNumber(-1);          
        } else {
          board.setCell(chosenCell.getPosX()+i, chosenCell.getPosY()+j, -1, iteration);
        }
      }
    }
      
    board.setCell(chosenCell.getPosX()-1, chosenCell.getPosY()-1, -1, iteration);
    board.setCell(chosenCell.getPosX(), chosenCell.getPosY()-1, -1, iteration);
    board.setCell(chosenCell.getPosX()+1, chosenCell.getPosY()-1, -1, iteration);
    board.setCell(chosenCell.getPosX()-1, chosenCell.getPosY(), -1, iteration);
    board.setCell(chosenCell.getPosX()+1, chosenCell.getPosY(), -1, iteration);
    board.setCell(chosenCell.getPosX()-1, chosenCell.getPosY()+1, -1, iteration);
    board.setCell(chosenCell.getPosX(), chosenCell.getPosY()+1, -1, iteration);
    board.setCell(chosenCell.getPosX()+1, chosenCell.getPosY()+1, -1, iteration);
  } else {  
    int chosenTileNumber = tileNumbers.get(int(random(tileNumbers.size())));  
    board.setCell(chosenCell.getPosX(), chosenCell.getPosY(), chosenTileNumber, iteration);
  }
 
  iteration++;
  //if (iteration % 100 == 0) {
    background(120, 120, 120);
    board.draw();
  //}
}
