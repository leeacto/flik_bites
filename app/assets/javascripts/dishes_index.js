var Menu = function(el) {
	this.el = $(el);
	this.tabs = [];
	this.init();
};

Menu.prototype.init = function() {
	var starter = new Tab('#starters_tab', this);
	var entrees = new Tab('#entrees_tab', this);
	var desserts = new Tab('#desserts_tab', this);

	this.addTab(starter);
	this.addTab(entrees);
	this.addTab(desserts);
};

Menu.prototype.addTab = function(tab) {
	this.tabs.push(tab);
}

Menu.prototype.selectTab = function(tab) {
	var self = this;
	for(var i in this.tabs) {
		if(self.tabs[i] === tab) {
			tab.list.el.removeClass('hidden');
		}
		else {
			self.tabs[i].list.el.addClass('hidden');
		}
	}
}

var Tab = function(el, menu) {
	this.el = $(el);
	this.menu = menu;
	var self = this;
	this.list = new List("."+el.substring(1,el.length-4), this);
	this.el.on('click', function(event) {
		self.menu.selectTab(self);
	});
}

var List = function(el, tab) {
	this.el = $(el);
	this.tab = tab;
}

$(document).ready(function(){
	menu = new Menu('.menu');
});