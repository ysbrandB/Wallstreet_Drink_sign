class Bar {
  PVector size;
  PVector pos;
  float xSpeed;
  ArrayList<Product> products = new ArrayList<Product>();
  Bar(PVector size, PVector pos, JSONArray products, float xSpeed) {
    this.size=size;
    this.pos=pos;
    this.xSpeed=xSpeed;
    for (int i = 0; i < products.size(); i++) {
      JSONObject product= products.getJSONObject(i); 
      println(product);
      this.products.add(new Product(product, new PVector (this.size.x/2*i, this.size.y*0.15), new PVector(this.size.x/2, this.size.y*0.7), xSpeed));
    }
  }

  void show() {
    fill(0);
    pushMatrix();
    translate(this.pos.x, this.pos.y);
    rect(0, 0, this.size.x, this.size.y);
    for (Product product : this.products) {
      product.show();
    }
    popMatrix();
  }

  void pixelize() {
    fill(0);
    int boxSize=10;
    loadPixels();
    for (int x=0; x<=this.size.x; x+=boxSize) {
      for (int y=0; y<this.size.y; y+=boxSize) {
        fill(pixels[floor((this.pos.x+x)+(this.pos.y+y)*width)]);
        rect(this.pos.x+x, this.pos.y+y, this.size.x/boxSize, this.size.y/boxSize);
      }
    }
  }

  void update() {
    for (Product product : this.products) {
      product.update();
      if (product.pos.x>width+10&&product.xSpeed>0) {
        product.pos.x-=products.size()*product.size.x;
      }
      if (product.pos.x<-product.size.x&&product.xSpeed<0) {
        product.pos.x+=products.size()*product.size.x;
      }
    }
  }

  void newData(JSONArray newData) {
    for (int i = 0; i < newData.size(); i++) {
      JSONObject newProduct= newData.getJSONObject(i); 
      int newId=newProduct.getInt("id");
      boolean found=false;
      for (Product product : products) {
        if (newId==product.id) {
          product.price=newProduct.getFloat("price");
          product.diff= newProduct.getFloat("diff");
          found=true;
          println(newProduct.getString("name"));
        }
      }
      if (!found) {
        this.products.add(new Product(newProduct, new PVector (this.size.x/2*i, this.size.y*0.15), new PVector(this.size.x/2, this.size.y*0.7), xSpeed));
      }
    }
  }
}
