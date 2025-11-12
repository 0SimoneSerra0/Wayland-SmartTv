#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "headers/metadata.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    MetaData metadata;

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("wayland-based-smart-tv", "Main");

    QObject *root = engine.rootObjects().first();
    engine.rootContext()->setContextProperty("MainWindow", root);
    engine.rootContext()->setContextProperty("metaData", &metadata);

    return app.exec();
}
