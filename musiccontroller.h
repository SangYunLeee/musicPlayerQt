#ifndef MUSICCONTROLLER_H
#define MUSICCONTROLLER_H

#include <QObject>
#include "musiclist.h"



class MusicController : public QObject
{
    Q_OBJECT
public:
    explicit MusicController(QObject *parent = nullptr);
    ~MusicController();
    void loadQml(QObject* qml);

    MusicList *musicList() const;

    Music *currentMusic() const;

    void setCurrentMusic(Music *currentMusic);

private:
    QString loadMusicList(const QUrl &ListUrl);

    QString createImageFile(const QString& url);

signals:

public slots:
    // when folder Route loaded
    QString loadedFolderRoute(const QUrl &ListUrl);

    // when List Index changed
    void changedListIndex(const int &index);

private:
    MusicList* m_musicList;
    Music* m_currentMusic;

    // folder route
    QString m_url;
    // image for current Music
    QImage m_image_main;
    //qml object
    QObject* m_qml;
};

#endif // MUSICCONTROLLER_H
