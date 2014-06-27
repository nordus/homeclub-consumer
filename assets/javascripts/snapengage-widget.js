define([], function() {
  return function() {
    var se = document.createElement('script'); se.type = 'text/javascript'; se.async = true;
    se.src = '//commondatastorage.googleapis.com/code.snapengage.com/js/3406b373-5986-4b22-9064-320dc6c13986.js';
    var done = false;
    se.onload = se.onreadystatechange = function() {
    if (!done&&(!this.readyState||this.readyState==='loaded'||this.readyState==='complete')) {
    done = true;
    // Place your SnapEngage JS API code below
    // SnapEngage.allowChatSound(true); // Example JS API: Enable sounds for Visitors. 
    }
    };
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(se, s);
  };
})