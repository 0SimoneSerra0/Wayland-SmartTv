#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <stdlib.h>
#include <QProcess>

class BackEnd : public QObject
{
    Q_OBJECT
public:
    explicit BackEnd(QObject *parent = nullptr);

public slots:
    void launchProcess(QString wayland_socket, QString process_name);

signals:
};

#endif // BACKEND_H
