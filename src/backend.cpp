#include "headers/backend.h"

BackEnd::BackEnd(QObject *parent)
    : QObject{parent}
{}

void BackEnd::launchProcess(QString wayland_socket, QString process_name)
{
    QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
    env.insert("WAYLAND_DISPLAY", wayland_socket);
    env.insert("QT_WAYLAND_SHELL_INTEGRATION", "ivi-shell");

    QProcess *proc = new QProcess();
    proc->setProcessEnvironment(env);
    proc->setProgram(process_name);
    proc->start();
}


void BackEnd::saveSettings(const QString &path, const QJsonObject &data) {
    QFile file(path);
    if (file.open(QIODevice::WriteOnly)) {
        QJsonDocument doc(data);
        file.write(doc.toJson(QJsonDocument::Compact));
        file.close();
    }
}

QJsonObject BackEnd::loadSettings(const QString &path) {
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly))
        return {};

    QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
    file.close();
    return doc.object();
}
