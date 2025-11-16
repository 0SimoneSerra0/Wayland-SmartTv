#ifndef BACKEND_H
#define BACKEND_H

#include <vector>
#include <algorithm>

#include <QObject>
#include <QProcess>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>

#include <QLocale>
#include <QDateTime>

class BackEnd : public QObject
{
    Q_OBJECT
public:
    explicit BackEnd(QObject *parent = nullptr);

public slots:
    void launchProcess(QString wayland_socket, QString process_name);

    QString getDate();
    QString getTime();
    QString getSocketName();


private:
    struct RecentActivity{
        QString name;
        QString img;
        QString activityCommand;
    };

    std::vector<RecentActivity> recentActivities;
    std::vector<QProcess *> processes;

    static QLocale _locale;
    static const QString _socket_name;


    void saveSettings(const QString &path, const QJsonObject &data);
    QJsonObject loadSettings(const QString &path);

private slots:
    void onProcessFinished(int exit_code, QProcess::ExitStatus exit_status);

signals:
    void createBrowserSurface(QString default_url);
};

#endif // BACKEND_H
