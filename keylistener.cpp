#include "keylistener.h"
#include <QKeyEvent>
#include <QDebug>

KeyListener::KeyListener(){}

bool KeyListener::eventFilter(QObject *watched, QEvent *event) {
    if (event->type() == QEvent::KeyPress) {
        QKeyEvent *keyEvent = static_cast<QKeyEvent*>(event);
        qDebug() << "text" << keyEvent->text() << "key" << keyEvent->key() << "modifiers" << keyEvent->modifiers();
    }
    QObject::eventFilter(watched, event);
    return false;
}
