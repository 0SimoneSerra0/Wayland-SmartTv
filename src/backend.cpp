#include "headers/backend.h"

BackEnd::BackEnd(QObject *parent)
    : QObject{parent}
{}

void BackEnd::launchProcess(QString wayland_socket, QString process_name)
{
    QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
    env.insert("QT_WAYLAND_SHELL_INTEGRATION", "ivi-shell");
    env.insert("WAYLAND_DISPLAY", wayland_socket);

    QProcess *proc = new QProcess();

    processes.push_back(proc);

    proc->setProcessEnvironment(env);
    proc->setProgram(process_name);

    QObject::connect(proc, SIGNAL( finished(int, QProcess::ExitStatus) ),
                     this, SLOT( onProcessFinished(int, QProcess::ExitStatus) )
                    );

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

void BackEnd::onProcessFinished(int exit_code, QProcess::ExitStatus exit_status)
{
    QProcess *proc = qobject_cast<QProcess*>(sender());
    if(!proc)
        return;

    processes.erase(std::find(processes.begin(), processes.end(), proc));

    proc->deleteLater();
}


QLocale BackEnd::_locale = QLocale::system();
const QString BackEnd::_socket_name = "wayland-smart-tv";

QString BackEnd::getDate()
{
    QString date = _locale.toString(QDateTime::currentDateTime().date(), QLocale::LongFormat);

    date = date.mid(0,3) + date.mid(date.indexOf(" "));
    date[0] = QString(date[0]).toUpper()[0];
    date[date.indexOf(" ", 4) + 1] = QString(date[date.indexOf(" ", 4) + 1]).toUpper()[0];

    return date;
}

QString BackEnd::getTime()
{
    return _locale.toString(QDateTime::currentDateTime().time(), QLocale::ShortFormat);
}

QString BackEnd::getSocketName()
{
    return _socket_name;
}

