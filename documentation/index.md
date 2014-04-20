# TiParallaxHeader Module

## Description

Insert a slightly bouncy parallax scrolling header for a Titanium ListView.
Similar effect to Spotify/Path apps.

## Referencing the module in your Ti mobile application 

Simply add the following lines to your `tiapp.xml` file:
    
    <modules>
        <module platform="iphone">com.citytelecom.tiparallaxheader</module> 
    </modules>
    
## Accessing the TiParallaxHeader Module

To access this module from JavaScript, you would do the following:

```javascript
var TiParallaxHeader = require("com.citytelecom.tiparallaxheader");
```

Do this only once for your app, preferably in your app.js / alloy.js file.
This will extend ListView with additional methods


## Usage

ListView will be extended with the following methods. Only call them after the ListView has finished renderering, by listening to the 'postlayout' event

```javascript
function onListViewPostlayout(e) {
    // attach the parallax header
    listView.addParallaxWithImage('http://example.com/image.png', 350);
}
//must wait till ListView has sized itself
listView.addEventListener('postlayout',onListViewPostlayout);
```
## ListView functions

### addParallaxWithImage

Add an expanding parallax image for the background of the header

local file
```javascript	
var url = Titanium.Filesystem.getFile(Titanium.Filesystem.resourcesDirectory, 'ParallaxImage.jpg').nativePath;
var headerHeight = 350;
listView.addParallaxWithImage(url, headerHeight);
```

Remote file
```javascript
listView.addParallaxWithImage('http://example.com/image.png', 350);
```

### addParallaxWithView
Add a titanium View to the header, will center vertically and scroll in a parallax fashion.
The added view must specify the same height as the header i.e width=350

```javascript
var headerView = Ti.UI.createView({
    width : Ti.UI.FILL,
    height : 350,
    backgroundColor:'red'
});

//must be added to a viewable parent for sizing
win.add(headerView);

//this will reparent the headerView
listView.addParallaxWithView(headerView, 350);
```

### setSectionHeaderInset
Insetting the header into the listview, causes all sticky ListView section headers to stick below the header height.
This method allows giving an offset to the Y position of the headers.

```javascript
listView.setSectionHeaderInset(-350);
```

## Author

**James Chow**  
web: http://updatedisplaylist.com
email:  james@jc888.co.uk

## License

    Copyright (c) 2010-2014 James Chow

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
