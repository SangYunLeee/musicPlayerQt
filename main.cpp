#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QStringList>
#include <QDebug>
#include "coreapplication.h"
#include "keylistener.h"
#include "music.h"
#include "musiclist.h"
#include <QUrl>
#include <musiccontroller.h>

#include <QIcon>

#include <QKeyEvent>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:/");
    engine.addImportPath("qrc:/image");

    QIcon icon(":/icon.png");
    app.setWindowIcon(icon);

    //App Setting
    app.setOrganizationName("SangYun");
    app.setOrganizationDomain("sororiri.com");
    app.setApplicationName("Sorori Music");

    qmlRegisterUncreatableType<MusicController>("CppEnums",1,0,"Enums","Enum is not a type");

    MusicController* musicController = MusicController::getInstance();
    engine.rootContext()->setContextProperty("cppMusicController", musicController);
    engine.rootContext()->setContextProperty("cppMusicList", musicController->musicList());
    engine.rootContext()->setContextProperty("cppCurrentMusic", musicController->currentMusic());

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    QObject* maybeRootQml = engine.rootObjects().first();
    musicController->loadQml(maybeRootQml);
    maybeRootQml->setProperty("title","Music Player - sangYun v0.9 sororiri@gmail.com");

#ifdef INSTALL_KEYBOARD
    KeyListener keyListener;
    engine.rootObjects().first()->installEventFilter(&keyListener);
#endif
    return app.exec();
}
