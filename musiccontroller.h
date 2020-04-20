#ifndef MUSICCONTROLLER_H
#define MUSICCONTROLLER_H

#include <QObject>
#include "musiclist.h"



class MusicController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(E_REPEAT_TYPE repeatType READ repeatType WRITE setRepeatType NOTIFY repeatTypeChanged)

public:

    enum E_REPEAT_TYPE{
        REPEATE_NO = 0,
        REPEATE_ONE,
        REPEATE_ALL
    };
    Q_ENUM(E_REPEAT_TYPE)

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

    MusicController::E_REPEAT_TYPE repeatType() const;

private:
    QString loadMusicList(const QUrl &ListUrl);

    QString createImageFile(const QString& url);

signals:

    void repeatTypeChanged(E_REPEAT_TYPE repeatType);

public slots:
    // when folder Route loaded
    QString loadedFolderRoute(const QUrl &ListUrl);

    // when List Index changed
    void changeCurrentMusicIndex(const int &index);

    // when search input text changed
    void changedSearchText(const QString& searchText);

    void setRepeatType(E_REPEAT_TYPE repeatType);

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
    enum E_REPEAT_TYPE m_repeatType;
};

#endif // MUSICCONTROLLER_H
