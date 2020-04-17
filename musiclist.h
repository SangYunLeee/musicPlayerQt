#ifndef MUSICLIST_H
#define MUSICLIST_H

#include <QObject>
#include <music.h>
#include <QVariant>
#include <QUrl>
#include <QDirIterator>
#include <QMediaPlayer>
#include <QMediaPlaylist>

#include <tag.h>
#include <fileref.h>

class MusicList : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY urlChanged)
    Q_PROPERTY(QList<QObject*> originalMusicList READ originalMusicList WRITE setOriginalMusicList NOTIFY originalMusicListChanged)
    Q_PROPERTY(QVariant inputList READ inputList WRITE setInputList NOTIFY inputListChanged)
    Q_PROPERTY(int size READ size WRITE setSize NOTIFY sizeChanged)

public:
    explicit MusicList(QObject *parent = nullptr);

    QString url() const;
    void setUrl(const QString &url);

    QList<QObject *> originalMusicList() const;
    void setOriginalMusicList(const QList<QObject *> &originalMusicList);

    QVariant inputList() const;
    void setInputList(const QVariant &inputList);

    QMediaPlaylist playList() const;
    void setPlayList(const QMediaPlaylist &playList);
    void clearList();
    void signalingListChanged();

    int size() const;

    QList<QObject *> sortedMusicList() const;
    void setSortedMusicList(const QList<QObject *> &sortedMusicList);

public slots:
    void setSize(int size);

private:

signals:
    void urlChanged();
    void originalMusicListChanged();
    void inputListChanged();

    void sizeChanged();

private:
    QString m_url;
    QList<QObject*> m_originalMusicList;
    QList<QObject*> m_sortedMusicList;
    QVariant m_inputList;
    QMediaPlayer mediaPlayer;
    QMediaPlaylist m_playList;
    int m_size;
};

#endif // MUSICLIST_H
