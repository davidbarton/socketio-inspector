// This will register the panel.
// NOTE: The second argument is required, so you need a image file to be the icon of your panel otherwise it just won't work (it did not for me at least)
chrome.devtools.panels.create("Praso rozsireni",
    "Icon.png",
    "panel.html",
    function(panel) {
    });