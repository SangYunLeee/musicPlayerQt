#include "musiclist.h"
#include <qmediaplayer.h>
#include <QtMultimedia>
#include <QMediaMetaData>
#include <QMediaContent>
#include <id3v2tag.h>
#include <frames/attachedpictureframe.h>


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

QVariant MusicList::inputList() const
{
    return QVariant::fromValue(m_convertedMusicList);
}

void MusicList::setInputList(const QVariant &inputList)
{
    m_inputList = inputList;
}

void MusicList::clearList()
{
    //make list empty
    for(auto* music : m_convertedMusicList){
        delete music;
    }
    m_convertedMusicList.clear();
}

void MusicList::signalingListChanged()
{
    emit inputListChanged();
}

int MusicList::size() const
{
    return m_convertedMusicList.size();
}

void MusicList::setSize(int size)
{
    if (m_size == size)
        return;

    m_size = size;
    emit sizeChanged();
}

