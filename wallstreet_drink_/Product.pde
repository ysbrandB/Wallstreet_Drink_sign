class Product {
  int id;
  PImage img;
  float price;
  float diff;
  PVector pos;
  PVector size;
  float xSpeed;
  String name;

  Product(JSONObject product, PVector pos, PVector size, float xSpeed) {
    this.price=product.getFloat("price");
    this.id=product.getInt("id");
    this.diff= product.getFloat("diff");
    this.name= product.getString("name");
    String img= product.getString("img");
    if (!img.equals("")) {
      try {
        this.img= loadImage(img);
      } 
      catch(Exception e) {
        println(e);
      }
    }
    this.pos=pos;
    this.size=size;
    this.xSpeed= xSpeed;
  }

  void update() {
    pos.x+=xSpeed;
  }

  void show() {
    imageMode(CORNER);
    fill(200, 200, 200);
    //circle(this.pos.x, this.pos.y, 20);
    pushMatrix();
    translate(this.pos.x, this.pos.y);
    fill(20, 20, 20);
    rect(0, 0, this.size.x, this.size.y);
    if (this.img!=null) {
      this.img.resize((int)this.size.y, (int)this.size.y);
      image( this.img, 20, 0);
    }
    textSize(80);
    translate(this.size.x/2-70, 0);
    if (this.diff>0) {
      fill(0, 200, 0);
    } else {
      fill(200, 0, 0);
    }
    textFont(bigFont);
    text(this.name.toUpperCase(), 0, 0, this.size.x/1.5, this.size.y/2);
    textFont(smallFont);
    text(("€"+nf(this.price, 1, 2)).toUpperCase(), 0, this.size.y/2, this.size.x/1.5, this.size.y/2);
    text((nf(this.diff, 2, 1)).toUpperCase()+"%", this.size.x/2.5, this.size.y/2, this.size.x/1.5, this.size.y/2);
    pushMatrix();
    translate(this.size.x/4+15, this.size.y-this.size.y/3);
    if (this.diff>0) {
      tint(0, 200, 0);
    } else {
      tint(200, 0, 0);
      scale(1, -1);
    }
    imageMode(CENTER);
    arrow.resize((int)this.size.y/2, (int)this.size.y/2);
    image(arrow, 0, 0);
    popMatrix();
    noTint();
    popMatrix();
  }
}
