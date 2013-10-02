var catList = function(el) {
  this.el = $(el);
  this.categories = [];
}

catList.prototype.initialize = function(){
  var self = this;
  $.each(this.el.find('li'), function(){
    var newCat = new Category(el);
    self.addCat(this);
  })
}

catList.prototype.addCat = function(cat) {
  this.categories.push(cat);
}

var Category = function(el) {
  this.el = $(el);
  this.buttonDown = false;
  this.initialize();
}

Category.prototype.initialize = function(){
  var self = this;
  this.el.on("click", self.clicked);
}

Category.prototype.clicked = function(event) {
  event.stopPropagation();
  this.buttonDown = true;
}

function setup() {
  catBoard = new catList('.dish_categories');
  catBoard.initialize();
}

$(document).on('ready', setup);
$(document).on('page:load', setup);
