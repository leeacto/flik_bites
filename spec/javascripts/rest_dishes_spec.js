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
    searcher = new searchBar('#search_field');
    list = $("<ul class='catList'><li id='category_0'>Appetizers</li><li id='category_1'></li></ul>");
    $(document.body).append(searcher);
    $(document.body).append(list);
    catBoard = new catList('.catList');
    catBoard.initialize();
    category = catBoard.categories[0];
    category_1 = catBoard.categories[1];
  });

  afterEach(function(){
    list.remove();
    list = null;
    search_bar = null;
  });

  it("should have the correct el", function(){
    expect(category.el.selector).toBe('#category_0');
  });

  it("should have an initialize function", function(){
    spyOn(category, "initialize");
    category.initialize();
    expect(category.initialize).toHaveBeenCalled;
  });

  describe("button clicks", function() {
    beforeEach(function(){
      $(category.el).trigger('click');
    });

    it("should have button down status when clicked", function(){
      expect(category.buttonDown).toBe(true);
    });

    it("should have other buttons with false button down status", function(){
      expect(category_1.buttonDown).toBe(false);
    });

    it("should only have one category with down status", function(){
      category_1.el.trigger('click');
      expect(category_1.buttonDown).toBe(true);
      expect(category.buttonDown).toBe(false);
    });

    describe("functionality", function(){
      it("should set the search bar object's text",function(){
        expect(catBoard.searchBar.search).toBe('Appetizers');
      });
    });
  });
});