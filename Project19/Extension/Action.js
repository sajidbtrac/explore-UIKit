var Action = function() {};

Action.prototype = {
    
//first is called before your extension is run, and the other is called after.

run: function(parameters) {
    parameters.completionFunction({"URL": document.URL, "title": document.title});
},

finalize: function(parameters) {
    var customJavaScript = parameters["customJavaScript"];
    eval(customJavaScript);
}
};

var ExtensionPreprocessingJS = new Action
