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

#include <QDir>
#include <QStandardPaths>

#include <QTimer>

#define CLOCK_UPDATE_INTERVALL 10000

class BackEnd : public QObject
{
    Q_OBJECT
public:
    explicit BackEnd(QObject *parent = nullptr);

    Q_INVOKABLE QVariantMap palette();

public slots:
    void launchProcess(QString wayland_socket, QString process_name);
    QString getWebDataPath();

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

    QString _date;
    QString _time;

    QTimer* _date_time_timer;

    static QString web_data_path;
    QJsonObject _palette;

    void saveSettings(const QString &path, const QJsonObject &data);
    QJsonObject loadSettings(const QString &path);

private slots:
    void onProcessFinished(int exit_code, QProcess::ExitStatus exit_status);
    void onClockTimeout();

signals:
    void createBrowserSurface(QString default_url);
    void updateTime(QString new_time);
    void updateDate(QString new_date);
};

#endif // BACKEND_H
