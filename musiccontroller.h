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

    MusicList *musicList() const;

signals:

public slots:
    QString loadMusicList(const QUrl &ListUrl);


private:
    MusicList* m_musicList;
    QString m_url;
    QImage m_image_main;
};

#endif // MUSICCONTROLLER_H
