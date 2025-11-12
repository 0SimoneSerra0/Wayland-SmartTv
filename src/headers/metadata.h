#ifndef METADATA_H
#define METADATA_H

#include <QObject>
#include <QLocale>
#include <QDateTime>

class MetaData : public QObject
{
    Q_OBJECT
public:
    MetaData();

public slots:
    QString getDate();
    QString getTime();
    QString getSocketName();


private:
    static QLocale _locale;
    static const QString _socket_name;

};

#endif // METADATA_H
