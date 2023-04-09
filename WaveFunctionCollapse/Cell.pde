import java.util.Arrays;

class Cell {
  private int posX;
  private int posY;
  private int tileNumber;
  private int[] tileData;
  private int potency;
  private TileStore tileStore;
  private int lastIteration;
  
  public Cell(int posX, int posY, TileStore tileStore) {
    this.posX = posX;
    this.posY = posY;
    this.tileStore = tileStore;
    
    lastIteration = 0;
    tileNumber = -1;
    tileData = new int[] { -1, -1, -1, -1 };
    updatePotency();
  }
  
  public void setTileNumber(int tileNumber) {
    this.tileNumber = tileNumber;
  }
  
  public int getTileNumber() {
    return tileNumber;
  }
  
  public void setTileData(int[] tileData) {
    this.tileData = tileData;
    updatePotency();
  }
  
  public int[] getTileData() {
    return tileData;
  }
  
  public void updateTileData(int pos, int value) {
    tileData[pos] = value;
    updatePotency();
  }
  
  private int getPotency() {
    return potency;
  }
  
  private void updatePotency() {
    potency = tileStore.getCompatibles(tileData).size();
    
    //potency = int(Arrays.stream(tileData).filter(data -> data != -1).count());
  }
  
  private int getPosX() {
    return posX;
  }
  
  private int getPosY() {
    return posY;
  }
  
  private void setLastIteration(int lastIteration) {
    this.lastIteration = lastIteration;
  }
  
  private int getLastIteration() {
    return lastIteration;
  }
}
