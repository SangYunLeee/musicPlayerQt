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

private:
    void initialize();


signals:

public slots:
    QString loadMusicList(const QUrl &ListUrl);


private:
    MusicList* m_musicList;
    Music* m_currentMusic;
    QString m_url;
    QImage m_image_main;
    QObject* m_qml;
};

#endif // MUSICCONTROLLER_H
