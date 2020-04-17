#ifndef MUSICCONTROLLER_H
#define MUSICCONTROLLER_H

#include <QObject>
#include "musiclist.h"



class MusicController final : public QObject
{
    Q_OBJECT

private:
    explicit MusicController(QObject *parent = nullptr);

public:
    static MusicController* getInstance();

public:
    ~MusicController();
    void loadQml(QObject* qml);

    MusicList *musicList() const;

    Music *currentMusic() const;

    void setCurrentMusic(Music *currentMusic);

    bool isSortMode() const;

private:
    QString loadMusicList(const QUrl &ListUrl);

    QString createImageFile(const QString& url);

signals:

public slots:
    // when folder Route loaded
    QString loadedFolderRoute(const QUrl &ListUrl);

    // when List Index changed
    void changedListIndex(const int &index);

    // when search input text changed
    void changedSearchText(const QString& searchText);

private:
    MusicList* m_musicList;
    Music* m_currentMusic;

    // folder route
    QString m_url;

    // image for current Music
    QImage m_image_main;

    //qml object
    QObject* m_qml;

    //sort Mode
    bool m_bSortMode;

    static MusicController* instance;
};

#endif // MUSICCONTROLLER_H
