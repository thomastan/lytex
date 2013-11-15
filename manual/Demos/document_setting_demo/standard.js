//Copyright 2006 Adobe Systems, Inc. All rights reserved.
//
//This is the base class for implementing an Active Content extension -- a piece of code that knows how to rewrite OBJECT tags so that they comply to the Eolas patent without making the browser display the "Press OK to continue loading the content of this page" message box.
//
// When the user hovers the mouse over an ActiveX control in Internet Explorer 6 updated with (April 2006) Cumulative Security Update (912812) or Internet Explorer 7, the following message is displayed:
// “Press Spacebar or Enter to activate and use this control.”
// The user can now click the mouse anywhere inside the ActiveX control area, or press the Spacebar or Enter key to activate the control.
// The standard.js file has been introduced to retain the earlier behavior where the control remains interactive from the first click to the last.

function writeDocument(s){document.write(s);}
