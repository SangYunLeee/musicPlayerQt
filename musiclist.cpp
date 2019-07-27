#include "musiclist.h"
#include <qmediaplayer.h>

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
    m_url = ListUrl.toString();

    //make list empty
    for(auto* music : m_convertedMusicList){
        delete music;
        m_convertedMusicList.pop_back();
    }

    //add MusicList
    //filtering Mp3
    QStringList filter;
    filter << "*.mp3";
    QDirIterator it(m_url.replace(0,7,""), filter, QDir::AllEntries | QDir::NoSymLinks | QDir::NoDotAndDotDot);


        //if mp3 exists, make dir
        if(it.hasNext()) {
            QDir dir(m_url.remove("file://") +"/");
            dir.mkdir("imageForMusic");
        }
    //input string to files
    QStringList files;
    while (it.hasNext())
        files << it.next();

    for(auto url : files){   // url : "/home/sori/Desktop/qtProject/musicPlayer/image/054 마크툽 (MAKTUB), 구윤회 - Marry Me.mp3"
        //insert!!
//        TagLib::FileRef ref(url.toStdString().c_str());
//        QString artist = ref.tag()->artist().toCString(true);
//        QString title = ref.tag()->title().toCString(true);
//        m_convertedMusicList.append(new Music(artist,title,url));
//        qDebug() <<  "arty: " << url;
    }
    emit inputListChanged();

    return m_url;
}

QString MusicList::setImageFile(QString url)  // url : "/home/sori/Desktop/qtProject/musicPlayer/image/054 마크툽 (MAKTUB), 구윤회 - Marry Me.mp3"
{
    //make ImageFIle
/*
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
    */
    return "aa";
}

QVariant MusicList::inputList() const
{
    return QVariant::fromValue(m_convertedMusicList);
}

void MusicList::setInputList(const QVariant &inputList)
{
    m_inputList = inputList;
}

