//debugger configuration
let WebDebugger = null;


function WebDebuggerMain(){
    let self = {};

    self.show = function(){
        self.window.show();
    };

    self.hide = function() {
        self.window.hide();
    };

    //interface
    self.showElements = function() {
        self.elements.show();
        self.style.show();
        self.console.hide();
        buttonElements.addClass('active');
        buttonConsole.removeClass('active');
        let body = $('body').parent();
        let elements = self.getElements(body[0].outerHTML);
        self.elements.html($('<ul style="list-style: none;">'+self.jsonToPreview([elements])+'</ul>'));
    };

    self.showConsole = function() {
        self.elements.hide();
        self.style.hide();
        self.console.show();
        buttonConsole.addClass('active');
        buttonElements.removeClass('active');
    };

    self.filterConsole = function() {
        let search = $(this).val().toLowerCase();

        let children = WebDebugger.console.children();
        for(let i = 0; i < children.length; i++) {
            let line = $(children[i]);
            if(line.text().toLowerCase().indexOf(search) >= 0) {
                line.show();
            } else {
                line.hide();
            }
        }
    };




    self.window = $('<div class="web-debugger"></div>');

    self.toolbar = $('<div class="web-debugger-toolbar"></div>');
    self.window.append(self.toolbar);

    let button = $('<div class="web-debugger-button">&#11216;</div>');
    self.toolbar.append(button);

    let buttonElements = $('<div class="web-debugger-button">Elements</div>');
    buttonElements.click(self.showElements);
    self.toolbar.append(buttonElements);

    let buttonConsole = $('<div class="web-debugger-button">Console</div>');
    buttonConsole.click(self.showConsole);
    self.toolbar.append(buttonConsole);

    let inputFilter = $('<input type="text" placeholder="filter..."  class="web-debugger-input" style="float: right; " />');
    inputFilter.keyup(self.filterConsole);
    self.toolbar.append(inputFilter);

    self.console = $('<div class="web-debugger-console"></div>');
    self.window.append(self.console);


    self.elements = $('<div class="web-debugger-elements"></div>');
    self.window.append(self.elements);
    self.elements.hide();

    self.style = $('<div class="web-debugger-style"></div>');
    self.window.append(self.style);
    self.style.hide();



    //append debugger to webpage
    let body = $('body');
    body.append(self.window);



    //simple html syntax highlighter
    self.htmlSyntaxHighlighter = function(code) {
        return code.replace(/\</g,"&lt;")
            .replace(/\>/g,"&gt;")
            .replace(/\t+/gm, ' ').replace(/\s+/gm, ' ')
            .replace(/(\S+)="([^"]*)"/g, function(found, key, value){
                return found.replace(key, '<span class="debugger-hightlight-key">'+key+'</span>')
                    .replace(value, '<span class="debugger-hightlight-value">'+value+'</span>');
            }).replace(/(&lt;\/*\w+)/g, function(found, tag){
                return found.replace(tag, '<span class="debugger-hightlight-tag">'+tag+'</span>');
            }).replace(/(\/*&gt;)/g, function(found, tag){
                return found.replace(tag, '<span class="debugger-hightlight-tag">'+tag+'</span>');
            });
    };

    //converts the json structure to a html tree
    self.jsonToPreview = function(json) {
        let result = "";
        try {
            for(let i=0; i < json.length; i++) {
                let element = json[i];
                if(typeof element == "object") {
                    result += '<li>';
                    result += typeof element.tagBegin != "undefined" ? self.htmlSyntaxHighlighter(element.tagBegin) : "";
                    if(typeof element.children != "undefined" && element.children.length > 0) {
                        result +='<ul style="list-style: none;">' + self.jsonToPreview(element.children) + '</ul>';
                    }
                    result += typeof element.tagEnd != "undefined" ? self.htmlSyntaxHighlighter(element.tagEnd): "";
                    result += '</li>';
                } else {
                    result += '<li>'+element+'</li>';
                }
            }
        }catch(e) {
            return result;
        }
        return result;
    };

    //get html structure as json
    self.getElements = function(element) {
        var result = {};
        if (typeof element === "string") {
            if (window.DOMParser){
                parser = new DOMParser();
                docNode = parser.parseFromString(element,"text/html");
            }
            element = docNode.firstChild;
        }
        self.parseRecursive(element, result);
        return result;
    };

    self.parseTag = function(code) {

        let re = /(<[^>]+>)[\s\S]+(<\/[^>]+>)/gm;
        let found = re.exec(code);
        let element = { tagBegin: "", tagEnd: "" };

        if(found != null) {
            element = { tagBegin: found[1], tagEnd: found[2] };
        } else {
            let re = /(<[^>]+>)/gm;
            let found = re.exec(code);
            if(found != null) {
                element = { tagBegin: found[1], tagEnd: "" };
            }
        }
        return element;
    };

    self.parseRecursive = function (element, object) {
        if($(element).hasClass('web-debugger')) {
            return;
        }

        let tag = self.parseTag($(element)[0].outerHTML);
        object["tagBegin"] = tag.tagBegin;
        object["tagEnd"] = tag.tagEnd;
        let nodeList = element.childNodes;
        if (nodeList != null) {
            if (nodeList.length) {
                object["children"] = [];
                for (let i = 0; i < nodeList.length; i++) {
                    if (nodeList[i].nodeType === 3) {
                        let value = nodeList[i].nodeValue;
                        value = value.replace(/&/g, "&amp;")
                            .replace(/</g, "&lt;")
                            .replace(/>/g, "&gt;")
                            .replace(/"/g, "&quot;")
                            .replace(/'/g, "&#039;");
                        object["children"].push(value);
                    } else {
                        object["children"].push({});
                        self.parseRecursive(nodeList[i], object["children"][object["children"].length -1]);
                    }
                }
            }
        }

        if (element.attributes !== null && typeof element.attributes !== "undefined") {
            if (element.attributes.length) {
                object["attributes"] = {};
                for (var i = 0; i < element.attributes.length; i++) {
                    object["attributes"][element.attributes[i].nodeName] = element.attributes[i].nodeValue;
                }
            }
        }
    };

    setInterval(function(){
        while(console.items.length) {
            let item = console.items.shift();
            let content = item.content.replace(/\</g,"&lt;").replace(/\>/g,"&gt;").replace(/\t+/gm, ' ').replace(/\s+/gm, ' ');
            let line = $('<div class="web-debugger-'+item.type+'"><pre style="margin: 0px; padding: 0px;">'+content+'</pre></div>');
            WebDebugger.console.append(line);
        }
    },500);


    return self;
}

//Init WebDebugger
$(function(){
    WebDebugger = WebDebuggerMain();
});

//define console
var console = {
    items: [],
    log: function(text){
        console.items.push({
            type: "log",
            content: text
        });
    },
    info: function (text) {
        console.items.push({
            type: "info",
            content: text
        });
    },
    warn: function (text) {
        console.items.push({
            type: "warn",
            content: text
        });
    },
    error: function (text) {
        console.items.push({
            type: "error",
            content: text
        });
    }
};
window.console = console;


