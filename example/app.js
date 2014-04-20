// This is a test harness for your module
// You should do something interesting in this harness
// to test out the module and to provide instructions
// to users on how to use it by example.

// open a single window
var win = Ti.UI.createWindow({
    backgroundColor : 'white'
});

//import the module
//NOTE : IMPORT ONLY ONCE, for Alloy run in app.js
var TiParallaxHeader = require('com.citytelecom.tiparallaxheader');

//height of the Parallax header, does not except DP
var PARALLAX_HEADER_HEIGHT = 350;

// ==== Parallax Header View ====
var headerView = Ti.UI.createView({
    width : Ti.UI.FILL,
    height : PARALLAX_HEADER_HEIGHT
});

var view1 = Ti.UI.createView({width : '150dp', backgroundColor : '#123'});
var view2 = Ti.UI.createView({width : '150dp', backgroundColor : '#256'});

var scrollableView = Ti.UI.createScrollableView({
    width : Ti.UI.FILL,
    height : 200,
    views : [view1, view2],
    showPagingControl : true
});

headerView.add(scrollableView);
// ==== Parallax Header View ====


// ==== List View ====
var listView = Ti.UI.createListView({
    width : Ti.UI.FILL,
    height : Ti.UI.FILL
});

var section = Ti.UI.createListSection();

//Floating section header view
var sectionHeaderView = Ti.UI.createView({
    width : Ti.UI.FILL,
    height:'50dp',
    backgroundColor:'red'
});
section.setHeaderView(sectionHeaderView);

//rows
var items = [];
for (var i = 0; i < 20; i++) {
    items[i] = {properties : {title : 'Item' + i}};
}
section.setItems(items);
listView.setSections([section]);
// ==== List View ====

function onListViewPostlayout(e) {

    //Parallax Image Background Image, remote / local urls accepted
    var imagePath = Titanium.Filesystem.getFile(Titanium.Filesystem.resourcesDirectory, 'ParallaxImage.jpg').nativePath;
    listView.addParallaxWithImage(imagePath, PARALLAX_HEADER_HEIGHT);
    
    win.remove(headerView);
    
    //Parallax HeaderView
    listView.addParallaxWithView(headerView, PARALLAX_HEADER_HEIGHT);
    
    //Scroll to first item to force redraw of list
    listView.scrollToItem(0, 0);

    var NAVBAR_HEIGHT = 50;

    // === Sticky ListView section header ===
    // adding a parallax header will cause the sticky section headers in your ListView,
    // to stick below the parallax header height, use this method to offset their sticky position.
    listView.setSectionHeaderInset(-PARALLAX_HEADER_HEIGHT + NAVBAR_HEIGHT); 
}

//must wait till ListView has sized itself
listView.addEventListener('postlayout',onListViewPostlayout);

//Before being inserted into the ListView, a HeaderView must be 
//added to the window or a viewable parent, to enforce sizing calculation 
win.add(listView);
win.add(headerView);
win.open();

