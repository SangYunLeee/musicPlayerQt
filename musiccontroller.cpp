#include "musiccontroller.h"

#define IMAGE_PATH "imageForMusic"

MusicController::MusicController(QObject *parent) : QObject(parent)
  ,m_musicList(new MusicList())
  ,m_currentMusic(new Music("author22","title22","url"))
  ,m_url("Null")
{
}

MusicController::~MusicController()
{
    m_musicList->deleteLater();
    m_currentMusic->deleteLater();
}

void MusicController::loadQml(QObject *qml)
{
    m_qml = qml;
}

MusicList *MusicController::musicList() const
{
    return m_musicList;
}

QString MusicController::loadMusicList(const QUrl &url_musicList)
{
    m_url = url_musicList.toLocalFile();
    qDebug() << Q_FUNC_INFO;
    qDebug() << "m_url: " << m_url;

    //Filter For MP3
    QStringList filter;
    filter << "*.mp3";
    QDirIterator it(m_url, filter, QDir::AllEntries | QDir::NoSymLinks | QDir::Files);

    bool b_listExist = it.hasNext();

    //make Image Folder
    if(b_listExist) {
        QDir directory(m_url);
        directory.mkdir(IMAGE_PATH);
    }
    else{
        qDebug() << Q_FUNC_INFO << "there is no mp3 files";
        return "None Files ";
    }

    QStringList list_str_url;
    while (it.hasNext()){
        list_str_url << it.next();
    }

    musicList()->clearList();

    //insert musicList
    QList<QObject *> list;
    for(QString url : list_str_url){

        TagLib::FileName fn(url.toStdWString().c_str());
        TagLib::FileRef ref(fn);

        QString artist = ref.tag()->artist().toCString(true);
        QString title = ref.tag()->title().toCString(true);

        list.append(new Music(artist,title,url));

        qDebug() << "artist: " << artist;
        qDebug() << "title : " << title;
    }
    musicList()->setConvertedMusicList(list);
    emit musicList()->inputListChanged();

    return "Happy New Year";
}

void MusicController::changedListIndex(const int &index)
{
    qDebug() << "index: " << index;
    Music* currentMusic = dynamic_cast<Music*>(m_musicList->convertedMusicList().at(index));
    m_currentMusic->setTitles(currentMusic->titles());
    m_currentMusic->setAuthor(currentMusic->author());
}

void MusicController::setCurrentMusic(Music *currentMusic)
{
    m_currentMusic = currentMusic;
}

QString MusicController::loadedFolderRoute(const QUrl &ListUrl)
{
    return loadMusicList(ListUrl);
}

Music *MusicController::currentMusic() const
{
    return m_currentMusic;
}
