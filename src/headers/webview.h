#ifndef WEBVIEW_H
#define WEBVIEW_H

#include <QObject>
#include <QtCore/QUrl>

class WebView : public QObject
{
    Q_OBJECT
public:
    explicit WebView(QObject *parent = nullptr);

public slots:


signals:
    void viewDestroyed();
};

#endif // WEBVIEW_H
