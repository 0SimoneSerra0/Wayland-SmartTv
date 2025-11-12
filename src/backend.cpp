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
