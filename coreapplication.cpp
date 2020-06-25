#include "coreapplication.h"
#include <QtDebug>

bool CoreApplication::event(QEvent *event)
{
    qDebug() << Q_FUNC_INFO << "Hi";
    return QGuiApplication::event(event);
}

void CoreApplication::customEvent(QEvent *event)
{
    qDebug() << Q_FUNC_INFO << "Hii";
    QGuiApplication::customEvent(event);
}
