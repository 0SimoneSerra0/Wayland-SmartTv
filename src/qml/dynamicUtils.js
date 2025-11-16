var component;
var obj;
var parent;
var _url

function renderBrowser(default_url, window)
{
    _url = default_url;
    createObject("BrowserWindow.qml", window);
}

function createObject(url, componentParent) {

    parent = componentParent
    component = Qt.createComponent(url, parent);

    if (component.status === Component.Ready)
        finishCreation();
    else
        component.statusChanged.connect(finishCreation);
}

function finishCreation() {
    if (component.status === Component.Ready) {

        const properties = {};

        if(_url)
            properties["url"] = _url;

        obj = component.createObject(parent, properties);

        if (obj === null) {
            console.log("Error creating object");
        }
    } else if (component.status === Component.Error) {
        console.log("Error loading component:", component.errorString());
    }
}
