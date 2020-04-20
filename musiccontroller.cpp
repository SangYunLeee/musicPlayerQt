#include "musiccontroller.h"

#include <id3v2tag.h>
#include <frames/attachedpictureframe.h>
#include <tag.h>
#include <fileref.h>

#define IMAGE_PATH "imageForMusic"

static QString imageFilePath = "imageForMusic";
static QString pathPrefix = "file:///";

MusicController* MusicController::instance = nullptr;

MusicController::MusicController(QObject *parent) : QObject(parent)
  ,m_musicList(new MusicList())
  ,m_currentMusic(new Music(QStringLiteral("가수우"),QStringLiteral("곡 이르음"),"url"))
  ,m_url("Null")
  ,m_bSortMode(false)
  ,m_repeatType(REPEATE_ALL)
{
}

MusicController *MusicController::getInstance()
{
    if(instance == nullptr)
    {
        instance = new MusicController();
    }
    return instance;
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
        musicList()->clearList();
        QList<QObject*> emptyList;
        musicList()->setOriginalMusicList(emptyList);
        emit musicList()->inputListChanged();
        return "None Files ";
    }

    QStringList list_str_url;
    while (it.hasNext()){
        list_str_url << it.next();
    }

    musicList()->clearList();

    //insert musicList
    QList<QObject *> list;
    for(QString& url : list_str_url){
        TagLib::FileName fn(url.toStdWString().c_str());
        TagLib::FileRef ref(fn);

        QString artist = ref.tag()->artist().toCString(true);
        QString title = ref.tag()->title().toCString(true);

        if(title == "")
        {
            //get file name...
            title = fn.toString().toCString(true);
            QStringList foo = title.split("/");
            title = foo.last();
            foo = title.split(".");
            title = foo.first();
        }

        list.append(new Music(artist,title,url));

        qDebug() << "artist: " << artist;
        qDebug() << "title : " << title;
    }
    musicList()->setOriginalMusicList(list);
    emit musicList()->inputListChanged();
    emit musicList()->sizeChanged();

    return "Happy New Year";
}

QString MusicController::createImageFile(const QString &url)
{
    QString path = url;
    path.insert(url.lastIndexOf("/"),"/"+imageFilePath);
    path.append(".jpeg");

    QFile qFile(path);
    if(qFile.exists())
    {
        qDebug() << "file is exist";
        return pathPrefix + path;
    }

    //make ImageFIle
    TagLib::FileRef file (url.toLocal8Bit().data());
    TagLib::ID3v2::Tag tag(file.file(), 0);

    TagLib::ID3v2::FrameList listOfMp3Frames = tag.frameListMap()["APIC"];
    TagLib::ID3v2::AttachedPictureFrame * pictureFrame;

    pictureFrame = static_cast<TagLib::ID3v2::AttachedPictureFrame*>(listOfMp3Frames.front());

    if(!pictureFrame){
        qDebug() << Q_FUNC_INFO << "Image doesn't exist";
        return "";
    }
    TagLib::ByteVector data1 = pictureFrame->picture();
    qDebug() <<  data1.size() <<  pictureFrame->mimeType().toCString();

    QImage image;
    image = QImage::fromData( (const uchar*)data1.data(), data1.size());
    qDebug() <<  "path: " << path;
    image.save( path , "JPEG");
    return pathPrefix + path;

}

void MusicController::changeCurrentMusicIndex(const int &index)
{
    //index over check
    qDebug() << "index: " << index;
    if(index < 0 || index >= m_musicList->selectedMusicList().size())
    {
        qDebug() << Q_FUNC_INFO << "index over";
        return;
    }
    //current Music Change
    Music* currentMusic = dynamic_cast<Music*>(m_musicList->selectedMusicList().at(index));
    QString title = currentMusic->titles() != QStringLiteral("") ?
                currentMusic->titles() : QStringLiteral("곡 제목 없당");
    m_currentMusic->setTitles(title);

    QString author = currentMusic->author() != QStringLiteral("") ?
                currentMusic->author() : QStringLiteral("가수 이름 없당");
    m_currentMusic->setAuthor(author);

    QString url = createImageFile(currentMusic->url());
    m_currentMusic->setImageUrl(url);
    m_currentMusic->setUrl(currentMusic->url());
}

void MusicController::changedSearchText(const QString& searchText)
{
    m_bSortMode = searchText.isEmpty() ? false : true;

    if(m_bSortMode)
    {
        m_musicList->sortedMusicList().clear();

        for(QObject* originMusic : m_musicList->originalMusicList())
        {
            auto music =  dynamic_cast<Music*>(originMusic);
            if(music->titles().contains(searchText,Qt::CaseInsensitive))
            {
                m_musicList->sortedMusicList().push_back(originMusic);
            }
        }
    }

    emit musicList()->inputListChanged();
    emit musicList()->sizeChanged();
    qDebug() << "Text Changed : " <<searchText;
}

void MusicController::setRepeatType(MusicController::E_REPEAT_TYPE repeatType)
{
    if (m_repeatType == repeatType)
        return;

    m_repeatType = repeatType;
    emit repeatTypeChanged(m_repeatType);
}

bool MusicController::isSortMode() const
{
    return m_bSortMode;
}

MusicController::E_REPEAT_TYPE MusicController::repeatType() const
{
    return m_repeatType;
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
