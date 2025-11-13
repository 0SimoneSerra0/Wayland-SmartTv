#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <vector>
#include <QProcess>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>

class BackEnd : public QObject
{
    Q_OBJECT
public:
    explicit BackEnd(QObject *parent = nullptr);

public slots:
    void launchProcess(QString wayland_socket, QString process_name);


private:
    struct RecentActivity{
        QString name;
        QString img;
        QString activityCommand;
    };

    std::vector<RecentActivity> recentActivities;


    void saveSettings(const QString &path, const QJsonObject &data);
    QJsonObject loadSettings(const QString &path);

signals:
};

#endif // BACKEND_H
