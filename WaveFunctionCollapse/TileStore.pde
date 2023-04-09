import java.util.stream.IntStream;
import java.util.stream.Collectors;

class TileStore {
  private PImage[] tiles;
  //private int[][] tileData = 
  //{
  //  { 0, 0, 0, 0 },
  //  { 0, 1, 1, 1 },
  //  { 1, 0, 1, 1 },
  //  { 1, 1, 0, 1 },
  //  { 1, 1, 1, 0 }
  //};
  
  private int[][] tileData =
  {
    { 0, 1, 1, 0 },
    { 1, 0, 0, 1 },
    { 2, 0, 0, 2 },
    { 2, 2, 1, 0 },
    { 3, 1, 1, 3 },
    { 3, 1, 2, 1 },
    { 3, 1, 2, 1 },
    { 3, 3, 0, 1 },

    { 4, 5, 5, 4 },
    { 5, 4, 4, 5 },
    { 0, 1, 2, 2 },
    { 1, 2, 2, 1 },
    { 1, 2, 1, 3 },
    { 2, 2, 2, 2 },
    { 2, 2, 2, 2 },
    { 0, 3, 0, 2 },

    { 3, 3, 3, 3 },
    { 3, 3, 3, 3 },
    { 3, 3, 3, 3 },
    { 3, 3, 3, 3 },
    { 1, 2, 1, 3 },
    { 2, 2, 2, 2 },
    { 2, 2, 2, 2 },
    { 0, 3, 0, 2 },

    { 6, 6, 6, 6 },
    { 6, 6, 6, 6 },
    { 6, 6, 6, 6 },
    { 6, 6, 6, 6 },
    { 1, 0, 3, 3 },
    { 2, 0, 3, 0 },
    { 2, 0, 3, 0 },
    { 0, 3, 3, 0 },
    
    { 3, 5, 5, 3 },
    { 3, 5, 6, 5 },
    { 3, 5, 6, 5 },
    { 3, 3, 4, 5 },
    { 7, 7, 7, 7 },
    { 3, 9, 9, 3 },
    { 3, 9, 7, 9 },
    { 3, 3, 8, 9 },

    { 5, 6, 5, 3 },
    { 6, 4, 4, 6 },
    { 6, 6, 5, 4 },
    { 4, 3, 4, 6 },
    { 7, 7, 7, 7 },
    { 9, 7, 9, 3 },
    { 7, 7, 7, 7 },
    { 8, 3, 8, 7 },

    { 5, 6, 5, 3 },
    { 4, 5, 6, 6 },
    { 5, 6, 6, 5 },
    { 4, 3, 4, 6 },
    { 7, 7, 7, 7 },
    { 9, 8, 3, 3 },
    { 7, 8, 3, 8 },
    { 8, 3, 3, 8 },

    { 5, 4, 3, 3 },
    { 6, 4, 3, 4 },
    { 6, 4, 3, 4 },
    { 4, 3, 3, 4 },
    { 8, 9, 7, 7 },
    { 9, 7, 7, 9 },
    { 7, 8, 8, 7 },
    { 7, 7, 9, 8 }
  };
  
  public TileStore(String fileName, int tileCount, int tileWidth, int tileHeight, int tileColumns, int tileRows) {
    tiles = new PImage[tileColumns * tileRows];
    
    PImage img = loadImage(fileName);
    for (int j = 0; j < tileRows; j++) {
      for (int i = 0; i < tileColumns; i++) {      
        if (j * tileColumns + i < tileCount) {
          tiles[j * tileColumns + i] = img.get(i * tileWidth, j * tileHeight, tileWidth, tileHeight);
        }
      }
    }
  }
  
  public int getTileCount() {
    return tiles.length;
  }
  
  public void draw(int tileNumber, int posX, int posY, int tileWidth, int tileHeight) {
    image(tiles[tileNumber], posX, posY, tileWidth, tileHeight);
  }  
  
  public int[] getTileData(int tileNumber) {
    return tileData[tileNumber];
  }
  
  public List<Integer> getCompatibles(int[] tileData) {
    return IntStream.range(0, this.tileData.length)
             .filter(index -> isCompatible(this.tileData[index], tileData))
             .boxed()
             .collect(Collectors.toList());
  }
  
  private boolean isCompatible(int[] data1, int[] data2) {
    for (int i = 0; i < data1.length; i++) {
      if (data1[i] != -1 && data2[i] != -1 && data1[i] != data2[i]) {
        return false;
      }
    }
    return true;    
  }
}
  
  
    
