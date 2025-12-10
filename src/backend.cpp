#include "headers/backend.h"

QString BackEnd::web_data_path = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + "/webengine/";

BackEnd::BackEnd(QObject *parent)
    : QObject{parent}
{
    QDir().mkpath(web_data_path);


    // In order to let the QML components get the initial date and time before the timer send the first timeout
    onClockTimeout();

    _date_time_timer = new QTimer(this);
    connect(_date_time_timer, &QTimer::timeout,
            this, &BackEnd::onClockTimeout);
    _date_time_timer->start(CLOCK_UPDATE_INTERVALL);


    _palette = {
                { "mainColor", "#0c1114"},
                { "secondaryColor", "#11171b"},
                { "textColor", "#ffffff"},
                { "highlightColor", "#888888"},
                };

    settings = loadSettings(_settings_path);
}


BackEnd::~BackEnd(){
    saveSettings(_settings_path, settings);
}


QVariantMap BackEnd::palette()
{
    return _palette.toVariantMap();
}

void BackEnd::launchApp(QString wayland_socket, QString process_command)
{
    if(process_command.indexOf("browser") == 0){

        emit createBrowserSurface(process_command.mid(7));

    }else{

        QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
        env.insert("QT_WAYLAND_SHELL_INTEGRATION", "ivi-shell");
        env.insert("WAYLAND_DISPLAY", wayland_socket);

        QProcess *proc = new QProcess();

        processes.push_back(proc);

        proc->setProcessEnvironment(env);
        proc->setProgram(process_command);

        QObject::connect(proc, SIGNAL( finished(int, QProcess::ExitStatus) ),
                         this, SLOT( onProcessFinished(int, QProcess::ExitStatus) )
                         );

        proc->start();

    }

    if(settings.find("recent") == settings.end()){
        settings.insert("recent", QJsonArray());
    }
    QJsonArray recent = settings["recent"].toArray();

    recent.append(QJsonArray({process_command, "", process_command}));

    settings["recent"] = recent;
}

QString BackEnd::getWebDataPath()
{
    return web_data_path;
}


void BackEnd::saveSettings(const QString &path, const QJsonObject &data) {
    QFile file(path);

    if(!file.exists())
        file.open(QIODevice::NewOnly | QIODevice::WriteOnly);
    else
        file.open(QIODevice::WriteOnly);

    if (file.isOpen()) {
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

void BackEnd::onClockTimeout()
{
    QString date = _locale.toString(QDateTime::currentDateTime().date(), QLocale::LongFormat);

    date = date.mid(0,3) + date.mid(date.indexOf(" "));
    date[0] = QString(date[0]).toUpper()[0];
    date[date.indexOf(" ", 4) + 1] = QString(date[date.indexOf(" ", 4) + 1]).toUpper()[0];

    if(_date != date){
        _date = date;
        emit updateDate(_date);
    }

    _time = _locale.toString(QDateTime::currentDateTime().time(), QLocale::ShortFormat);
    emit updateTime(_time);
}


QLocale BackEnd::_locale = QLocale::system();
const QString BackEnd::_socket_name = "wayland-smart-tv";

QString BackEnd::getDate()
{
    return _date;
}

QString BackEnd::getTime()
{
    return _time;
}

QString BackEnd::getSocketName()
{
    return _socket_name;
}

