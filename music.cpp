#include "music.h"
#include<QDebug>

Music::Music(QObject *parent) : QObject(parent)
  ,m_author("author"),m_titles("title")
{

}

Music::Music(QString author, QString title, QString url, QObject *parent) : QObject (parent)
  ,m_author(author),m_titles(title),m_url(url)
{

}

QString Music::author() const
{
    return m_author;
}

void Music::setAuthor(const QString &author)
{
    m_author = author;
    emit authorChanged();
}

QString Music::titles() const
{
    return m_titles;
}

void Music::setTitles(const QString &titles)
{

    m_titles = titles;
    emit titlesChanged();
}

QString Music::url() const
{
    return m_url;
}

void Music::setUrl(const QString &url)
{
    m_url = url;
}

void Music::testSetTitle()
{
    m_author = "chenged";
    emit authorChanged();
}
