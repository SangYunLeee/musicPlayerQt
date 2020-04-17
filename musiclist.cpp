#include "musiclist.h"
#include <qmediaplayer.h>
#include <QtMultimedia>
#include <QMediaMetaData>
#include <QMediaContent>
#include <id3v2tag.h>
#include <frames/attachedpictureframe.h>
#include "musiccontroller.h"


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

QList<QObject *> MusicList::originalMusicList() const
{
    return m_originalMusicList;
}

void MusicList::setOriginalMusicList(const QList<QObject *> &originalMusicList)
{
    m_originalMusicList = originalMusicList;
}

QVariant MusicList::inputList() const
{
    if(MusicController::getInstance()->isSortMode() && m_sortedMusicList.size() >=1)
        return QVariant::fromValue(m_sortedMusicList);
    else
        return QVariant::fromValue(m_originalMusicList);
}

void MusicList::setInputList(const QVariant &inputList)
{
    m_inputList = inputList;
}

void MusicList::clearList()
{
    //make list empty
    for(auto* music : m_originalMusicList){
        delete music;
    }
    m_originalMusicList.clear();
}

void MusicList::signalingListChanged()
{
    emit inputListChanged();
}

int MusicList::size() const
{
    return m_originalMusicList.size();
}

void MusicList::setSize(int size)
{
    if (m_size == size)
        return;

    m_size = size;
    emit sizeChanged();
}

QList<QObject *> MusicList::sortedMusicList() const
{
    return m_sortedMusicList;
}

void MusicList::setSortedMusicList(const QList<QObject *> &sortedMusicList)
{
    m_sortedMusicList = sortedMusicList;
}

