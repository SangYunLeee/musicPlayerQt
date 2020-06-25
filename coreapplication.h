#ifndef COREAPPLICATION_H
#define COREAPPLICATION_H

#include <QGuiApplication>

#include <QKeyEvent>
#include <QDebug>
class CoreApplication : public QGuiApplication
{
public:
    using QGuiApplication::QGuiApplication;
    // QObject interface
public:
    virtual bool event(QEvent *event) override;

    // QObject interface
protected:
    virtual void customEvent(QEvent *event) override;
};



#endif // COREAPPLICATION_H
