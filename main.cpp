#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QStringList>
#include <QDebug>
#include "music.h"
#include "musiclist.h"
#include <musiccontroller.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    MusicController* musicController = new MusicController();
    engine.rootContext()->setContextProperty("cppMusicController", musicController);
    engine.rootContext()->setContextProperty("cppMusicList", musicController->musicList());


    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    QObject* maybeRootQml = engine.rootObjects().first();

    return app.exec();
}
