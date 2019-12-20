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
    Q_PROPERTY(QList<QObject*> convertedMusicList READ convertedMusicList WRITE setConvertedMusicList NOTIFY convertedMusicListChanged)
    Q_PROPERTY(QVariant inputList READ inputList WRITE setInputList NOTIFY inputListChanged)

public:
    explicit MusicList(QObject *parent = nullptr);

    QString url() const;
    void setUrl(const QString &url);

    QList<QObject *> convertedMusicList() const;
    void setConvertedMusicList(const QList<QObject *> &convertedMusicList);

    QVariant inputList() const;
    void setInputList(const QVariant &inputList);

    QMediaPlaylist playList() const;
    void setPlayList(const QMediaPlaylist &playList);

private:
    void clearLlst();

signals:
    void urlChanged();
    void convertedMusicListChanged();
    void inputListChanged();

public slots:
    QString inputMusicList(const QUrl &ListUrl);
    QString setImageFile(QString filename);


private:
    QString m_url;
    QList<QObject*> m_convertedMusicList;
    QVariant m_inputList;
    QMediaPlayer mediaPlayer;
    QMediaPlaylist m_playList;
};

#endif // MUSICLIST_H
