
describe("Menu", function() {
	//beforeEach(function() {
// console.log('here');
		
// 		menu = new Menu('.menu');
// 	})

	it("should have the menu class selector", function() {
	// var menu
		expect(new Menu('.menu')).toEqual('.menu');
		// expect(true).toEqual(true);
	})
})