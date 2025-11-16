#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <iostream>
#include <QtWebView/QtWebView>

#include "headers/backend.h"
#include "headers/webview.h"

int main(int argc, char *argv[])
{

    QGuiApplication app(argc, argv);


    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("backEnd", new BackEnd(&engine));
    engine.rootContext()->setContextProperty("webUtils", new WebView(&engine));

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("wayland-based-smart-tv", "Main");

    QObject *root = engine.rootObjects().first();
    engine.rootContext()->setContextProperty("MainWindow", root);

    return app.exec();
}
