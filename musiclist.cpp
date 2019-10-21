#include "musiclist.h"
#include <qmediaplayer.h>
#include <QtMultimedia>
#include <QMediaMetaData>
#include <QMediaContent>
#include <id3v2tag.h>
#include <attachedpictureframe.h>


static QString imageFilePath = "imageForMusic";

MusicList::MusicList(QObject *parent) : QObject(parent)

{

}

QString MusicList::url() const
{
    return m_url;
}

void MusicList::setUrl(const QString &url)
{
    m_url = url;
}

QList<QObject *> MusicList::convertedMusicList() const
{
    return m_convertedMusicList;
}

void MusicList::setConvertedMusicList(const QList<QObject *> &convertedMusicList)
{
    m_convertedMusicList = convertedMusicList;
}

QString MusicList::inputMusicList(const QUrl &ListUrl)
{

    m_url = ListUrl.path();
    m_url = m_url.remove(0,1);

    //make list empty
    for(auto* music : m_convertedMusicList){
        delete music;
    }
    m_convertedMusicList.clear();

    qDebug() << m_url;

    //add MusicList
    //filtering Mp3
    QStringList filter;
    filter << "*.mp3";
    QDirIterator it(m_url, filter, QDir::AllEntries | QDir::NoSymLinks | QDir::Files);

    //if mp3 exists, make dir
    if(it.hasNext()) {
        QDir dir(m_url+"/imageForMusic");
        if(false == dir.exists()){
            dir.mkdir("../imageForMusic");
        }
    }

    //input string to files
    QStringList files;
    while (it.hasNext()){
//        qDebug() <<  it.filePath();
        files << it.next();
    }

    std::string str = "D:/정정.mp3";


    QUrl qqurl = QUrl("D:/정정.mp3");

    mediaPlayer.setMedia(qqurl);
    mediaPlayer.play();

    for(QString url : files){
        qDebug() << "auto url:" << url;

//        //insert!!
        TagLib::FileName fn(url.toStdWString().c_str());
        TagLib::FileRef ref(fn);

        QString artist = ref.tag()->artist().toCString(true);
        QString title = ref.tag()->title().toCString(true);
        m_convertedMusicList.append(new Music(artist,title,url));
        qDebug() << "artist: " << artist;
        qDebug() << "title : " << title;
    }
    emit inputListChanged();

    return m_url;
}

QString MusicList::setImageFile(QString url)  // url : "/home/sori/Desktop/qtProject/musicPlayer/image/054 마크툽 (MAKTUB), 구윤회 - Marry Me.mp3"
{
    //make ImageFIle

    QString filepath = url;
    TagLib::FileRef file (filepath.toLocal8Bit().data());
    TagLib::ID3v2::Tag tag(file.file(), 0);

    TagLib::ID3v2::FrameList listOfMp3Frames = tag.frameListMap()["APIC"];
    TagLib::ID3v2::AttachedPictureFrame * pictureFrame;

    pictureFrame = static_cast<TagLib::ID3v2::AttachedPictureFrame*>(listOfMp3Frames.front());

    TagLib::ByteVector data1 = pictureFrame->picture();
    qDebug() <<  data1.size() <<  pictureFrame->mimeType().toCString();

    QImage image;
    image = QImage::fromData((const uchar*)data1.data(), data1.size());
    QString path = url.insert(url.lastIndexOf("/"),"/"+imageFilePath)+".jpeg" ;
    qDebug() <<  "path: " <<
    image.save( path , "JPEG");
    return "file://"+path;

}

QVariant MusicList::inputList() const
{
    return QVariant::fromValue(m_convertedMusicList);
}

void MusicList::setInputList(const QVariant &inputList)
{
    m_inputList = inputList;
}

