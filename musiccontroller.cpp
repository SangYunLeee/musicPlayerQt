#include "musiccontroller.h"

#define IMAGE_PATH "imageForMusic"

MusicController::MusicController(QObject *parent) : QObject(parent)
  ,m_musicList(new MusicList())
  ,m_url("Null")
{
}

MusicController::~MusicController()
{
    m_musicList->deleteLater();
}

MusicList *MusicController::musicList() const
{
    return m_musicList;
}

QString MusicController::loadMusicList(const QUrl &url_musicList)
{
#if 1
    m_url = url_musicList.toLocalFile();
    qDebug() << Q_FUNC_INFO;
    qDebug() << "m_url: " << m_url;

    QStringList filter;
    filter << "*.mp3";
    QDirIterator it(m_url, filter, QDir::AllEntries | QDir::NoSymLinks | QDir::Files);

    //if mp3 exists, make dir
    if(it.hasNext()) {
        QDir dir(m_url+"/" + IMAGE_PATH);
        if (false == dir.exists())
        {
            qDebug() <<  it.filePath() << it.fileName();
            QDir directory(m_url);
            directory.mkdir(IMAGE_PATH);
        }
    }
    else{
        qDebug() << Q_FUNC_INFO << "there is no mp3 files";
        return "None Files ";
    }

    QStringList files;
    while (it.hasNext()){
        files << it.next();
    }
    for(QString file: files)
    {
        qDebug() << Q_FUNC_INFO << file;
    }

    return "Happy New Year";


#endif
}
