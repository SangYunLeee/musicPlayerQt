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
    void initialize();

    QString loadMusicList(const QUrl &ListUrl);

signals:

public slots:
    // when loaded folder Route
    QString loadedFolderRoute(const QUrl &ListUrl);

    // when changed List Index
    void changedListIndex(const int &index);


private:
    MusicList* m_musicList;
    Music* m_currentMusic;
    QString m_url;
    QImage m_image_main;
    QObject* m_qml;
};

#endif // MUSICCONTROLLER_H
