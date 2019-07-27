#ifndef MUSIC_H
#define MUSIC_H

#include <QObject>


class Music : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString author READ author WRITE setAuthor NOTIFY authorChanged)
    Q_PROPERTY(QString titles READ titles WRITE setTitles NOTIFY titlesChanged)
    Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY urlChanged)

public:
    explicit Music(QObject *parent = nullptr);
    explicit Music(QString author, QString title, QString url, QObject *parent = nullptr);

    QString author() const;
    void setAuthor(const QString &author);

    QString titles() const;
    void setTitles(const QString &titles);

    QString url() const;
    void setUrl(const QString &url);

private:
    QString m_author;
    QString m_titles;
    QString m_url;


signals:
    void urlChanged();
    void titlesChanged();
    void authorChanged();


public slots:
    void testSetTitle();
};

#endif // MUSIC_H
