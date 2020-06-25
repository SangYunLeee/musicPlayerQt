#ifndef KEYLISTENER_H
#define KEYLISTENER_H

#include <QObject>



class KeyListener : public QObject
{
    Q_OBJECT
public:
    KeyListener();
    bool eventFilter(QObject *watched, QEvent *event);
};
#endif // KEYLISTENER_H
