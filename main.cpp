#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QStringList>
#include <QDebug>
#include "music.h"
#include "musiclist.h"

#include <boost/thread.hpp>



int main(int argc, char *argv[])
{

    boost::thread worker([](){
        boost::posix_time::seconds sleep(30);
        boost::this_thread::sleep(sleep);
    });
    worker.join();
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;


    engine.rootContext()->setContextProperty("CppMusicList", new MusicList());

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
