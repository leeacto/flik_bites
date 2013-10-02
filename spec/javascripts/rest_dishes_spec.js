//= require jquery
//= require jquery_ujs
//= require dishes_index

describe("catList", function(){
  beforeEach(function(){
    catBoard = new catList('.catList');
    list = $("<ul class='catList'><li id='category_0'></li></ul>");
    $(document.body).append(list);
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
    spyOn(catBoard, 'addCat');
    catBoard.initialize();
    expect(catBoard.addCat).toHaveBeenCalled();
  });

  describe("initialize()", function(){
    beforeEach(function(){
      var spy = jasmine.createSpy(window, "cat").andCallThrough();
      catBoard.initialize();
    });

    it("should add categories to its array", function(){
      expect(catBoard.categories.length).toBe(1);
    });
  });
});

describe("Category", function(){
  beforeEach(function(){
    catBoard = new catList('.catList');
    category = new Category('#category_0');
  });

  it("should have the correct el", function(){
    expect(category.el.selector).toBe('#category_0');
  });

  it("should have an initialize function", function(){
    spyOn(category.el, "on");
    category.initialize();
    expect(category.el.on).toHaveBeenCalledWith('click', category.clicked);
  });

  it("should react when button is clicked", function(){
    category.el.trigger('click');
    expect(category.buttonDown).toBe(true);
  });
});