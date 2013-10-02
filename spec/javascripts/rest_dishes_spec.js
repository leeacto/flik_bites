//= require jquery
//= require jquery_ujs
//= require dishes_index

describe("catList", function(){
  beforeEach(function(){
    list = $("<ul class='catList'><li id='category_0'></li></ul>");
    $(document.body).append(list);
    catBoard = new catList('.catList');
  });

  afterEach(function(){
    list.remove();
    list = null;
  });

  it("should have the correct el", function(){
    expect(catBoard.el.selector).toBe('.catList');
  });

  it("should have an array of categories", function(){
    expect(catBoard.categories.length).toBe(0);
  });

  it("should have an initialize function", function(){
    spyOn(catBoard, 'initialize');
    catBoard.initialize();
    expect(catBoard.initialize).toHaveBeenCalled();
  });

  describe("initialize()", function(){
    beforeEach(function(){
      catBoard.initialize();
    });

    it("should add categories to its array", function(){
      expect(catBoard.categories.length).toBe(1);
    });
  });
});

describe("Category", function(){
  beforeEach(function(){
    list = $("<ul class='catList'><li id='category_0'></li></ul>");
    $(document.body).append(list);
    catBoard = new catList('.catList');
    category = new Category('category_0');
  });
  
  afterEach(function(){
    list.remove();
    list = null;
  });

  it("should have the correct el", function(){
    expect(category.el.selector).toBe('#category_0');
  });

  it("should have an initialize function", function(){
    spyOn(category, "initialize");
    category.initialize();
    expect(category.initialize).toHaveBeenCalled;
  });

  it("should have button down status when clicked", function(){
    $('#category_0').trigger('click');
    expect(category.buttonDown).toBe(true);
  });
});