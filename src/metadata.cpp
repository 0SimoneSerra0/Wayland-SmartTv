#include "headers/metadata.h"


QLocale MetaData::_locale = QLocale::system();
const QString MetaData::_socket_name = "wayland-smart-tv";

MetaData::MetaData()
{

}

QString MetaData::getDate()
{
    QString date = _locale.toString(QDateTime::currentDateTime().date(), QLocale::LongFormat);

    date = date.mid(0,3) + date.mid(date.indexOf(" "));
    date[0] = QString(date[0]).toUpper()[0];
    date[date.indexOf(" ", 4) + 1] = QString(date[date.indexOf(" ", 4) + 1]).toUpper()[0];

    return date;
}

QString MetaData::getTime()
{
    return _locale.toString(QDateTime::currentDateTime().time(), QLocale::ShortFormat);
}

QString MetaData::getSocketName()
{
    return _socket_name;
}


