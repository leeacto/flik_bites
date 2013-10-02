var catList = function(el) {
  this.el = $(el);
  this.categories = [];
}

catList.prototype.initialize = function(){
  var self = this;

  $.each(this.el.find('li'), function(){
    var newCat = new Category(this.id, self);
    self.addCat(newCat);
  })
}

catList.prototype.addCat = function(cat) {
  this.categories.push(cat);
}

var Category = function(el, list) {
  this.el = $('#'+el);
  this.list = list;
  this.buttonDown = false;
  this.initialize();
}

Category.prototype.initialize = function(){
  var self = this;
  this.el.on("click", function(event) {
    event.stopPropagation();
    $(self.list.categories).each(function(){
      this.buttonDown = false;
      $(this.el).removeClass('button_down');
    })
    self.buttonDown = true;
    $(this).addClass('button_down');
  });
}

Category.prototype.clicked = function(event) {
}

function setup() {
  catBoard = new catList('.dish_categories');
  catBoard.initialize();
}

$(document).on('ready', setup);
$(document).on('page:load', setup);
