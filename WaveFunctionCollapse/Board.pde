class Board {
  private Cell[] cells;
  private TileStore tileStore;
  private int boardWidth;
  private int boardHeight;
  private int tileWidth;
  private int tileHeight;
  
  public Board(int boardWidth, int boardHeight, TileStore tileStore) {
    this.boardWidth = boardWidth;
    this.boardHeight = boardHeight;
    this.tileStore = tileStore;

    tileWidth = width / boardWidth;
    tileHeight = height / boardHeight;
    
    cells = new Cell[boardWidth * boardHeight];
    for (int j = 0; j < boardHeight; j++) {
      for (int i = 0; i < boardWidth; i++) {
        cells[j * boardWidth + i] = new Cell(i, j, tileStore);
      }
    }
  }
  
  public Cell[] getCells() {
    return cells;
  }
  
  public void setCell(int posX, int posY, int tileNumber, int iteration) {
    Cell cell = getCellAt(posX, posY);
    cell.setTileNumber(tileNumber);
    cell.setLastIteration(iteration);
    if (tileNumber == -1) {
      int[] resetTileData = new int[] {
        getCellAt(posX, posY - 1).getTileData()[2],
        getCellAt(posX + 1, posY).getTileData()[3],
        getCellAt(posX, posY + 1).getTileData()[0],
        getCellAt(posX - 1, posY).getTileData()[1],
      };
      cell.setTileData(resetTileData); //<>//
    } else {
      cell.setTileData(tileStore.getTileData(tileNumber));
    }
    
    Cell northCell = getCellAt(posX, posY - 1);
    northCell.updateTileData(2, cell.getTileData()[0]);
    
    Cell eastCell = getCellAt(posX + 1, posY);
    eastCell.updateTileData(3, cell.getTileData()[1]);
    
    Cell southCell = getCellAt(posX, posY + 1);
    southCell.updateTileData(0, cell.getTileData()[2]);
    
    Cell westCell = getCellAt(posX - 1, posY);
    westCell.updateTileData(1, cell.getTileData()[3]);
  }
    
  
  public void draw() {
    for (int j = 0; j < boardHeight; j++) {
      for (int i = 0; i < boardWidth; i++) {
        Cell cell = cells[j * boardWidth +i];
        if (cell.getTileNumber() != -1) {
          tileStore.draw(cell.getTileNumber(), i * tileWidth, j * tileHeight, tileWidth, tileHeight);
        }
      }
    }
  }
  
  public Cell getCellAt(int posX, int posY) {
    int x = (posX + boardWidth) % boardWidth;
    int y = (posY + boardHeight) % boardHeight;
    return cells[y * boardWidth + x];
  }
}
    
