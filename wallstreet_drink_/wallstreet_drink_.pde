Bar upperBar;
Bar lowerBar;
PImage arrow;
PFont bigFont;
PFont smallFont;
JSONArray products;
int timer=0;
void setup() {
  fullScreen();
  arrow = loadImage("up_arrow.png");
  JSONObject henk = loadJSONObject("http://localhost:8080/api/wallstreet/updated_prices");
  products=henk.getJSONArray("products");
  println(products);
  upperBar=new Bar(new PVector(width, height/2), new PVector(0, 0), products, -3);
  lowerBar=new Bar(new PVector(width, height/2), new PVector(0, height/2), products, 3);
  bigFont = createFont("Minecraft.ttf", 60);
  smallFont = createFont("Minecraft.ttf", 50);
  noStroke();
}

void draw() {  
  background(255);
  upperBar.show();
  lowerBar.show();
  upperBar.update();
  lowerBar.update();
  if (millis()-timer>5000) {
    thread("newData");
    timer=millis();
    println(millis());
  }
}

void newData() {
  JSONObject henk = loadJSONObject("http://localhost:8080/api/wallstreet/updated_prices");
  JSONArray newProducts=henk.getJSONArray("products");
  if (products!=newProducts) {
    upperBar.newData(newProducts);
    lowerBar.newData(newProducts);
  }
}
