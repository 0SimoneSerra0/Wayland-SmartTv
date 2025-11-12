#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <iostream>

#include "headers/metadata.h"
#include "headers/backend.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    MetaData metadata;
    BackEnd backend;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("metaData", &metadata);
    engine.rootContext()->setContextProperty("backEnd", &backend);

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
