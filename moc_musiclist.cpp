/****************************************************************************
** Meta object code from reading C++ file 'musiclist.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "musiclist.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#include <QtCore/QList>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'musiclist.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_MusicList_t {
    QByteArrayData data[13];
    char stringdata0[159];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_MusicList_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_MusicList_t qt_meta_stringdata_MusicList = {
    {
QT_MOC_LITERAL(0, 0, 9), // "MusicList"
QT_MOC_LITERAL(1, 10, 10), // "urlChanged"
QT_MOC_LITERAL(2, 21, 0), // ""
QT_MOC_LITERAL(3, 22, 25), // "convertedMusicListChanged"
QT_MOC_LITERAL(4, 48, 16), // "inputListChanged"
QT_MOC_LITERAL(5, 65, 14), // "inputMusicList"
QT_MOC_LITERAL(6, 80, 7), // "ListUrl"
QT_MOC_LITERAL(7, 88, 12), // "setImageFile"
QT_MOC_LITERAL(8, 101, 8), // "filename"
QT_MOC_LITERAL(9, 110, 3), // "url"
QT_MOC_LITERAL(10, 114, 18), // "convertedMusicList"
QT_MOC_LITERAL(11, 133, 15), // "QList<QObject*>"
QT_MOC_LITERAL(12, 149, 9) // "inputList"

    },
    "MusicList\0urlChanged\0\0convertedMusicListChanged\0"
    "inputListChanged\0inputMusicList\0ListUrl\0"
    "setImageFile\0filename\0url\0convertedMusicList\0"
    "QList<QObject*>\0inputList"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_MusicList[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       3,   48, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   39,    2, 0x06 /* Public */,
       3,    0,   40,    2, 0x06 /* Public */,
       4,    0,   41,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       5,    1,   42,    2, 0x0a /* Public */,
       7,    1,   45,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::QString, QMetaType::QUrl,    6,
    QMetaType::QString, QMetaType::QString,    8,

 // properties: name, type, flags
       9, QMetaType::QString, 0x00495103,
      10, 0x80000000 | 11, 0x0049510b,
      12, QMetaType::QVariant, 0x00495103,

 // properties: notify_signal_id
       0,
       1,
       2,

       0        // eod
};

void MusicList::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        MusicList *_t = static_cast<MusicList *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->urlChanged(); break;
        case 1: _t->convertedMusicListChanged(); break;
        case 2: _t->inputListChanged(); break;
        case 3: { QString _r = _t->inputMusicList((*reinterpret_cast< const QUrl(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 4: { QString _r = _t->setImageFile((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (MusicList::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&MusicList::urlChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (MusicList::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&MusicList::convertedMusicListChanged)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (MusicList::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&MusicList::inputListChanged)) {
                *result = 2;
                return;
            }
        }
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 1:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<QObject*> >(); break;
        }
    }

#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        MusicList *_t = static_cast<MusicList *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->url(); break;
        case 1: *reinterpret_cast< QList<QObject*>*>(_v) = _t->convertedMusicList(); break;
        case 2: *reinterpret_cast< QVariant*>(_v) = _t->inputList(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        MusicList *_t = static_cast<MusicList *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setUrl(*reinterpret_cast< QString*>(_v)); break;
        case 1: _t->setConvertedMusicList(*reinterpret_cast< QList<QObject*>*>(_v)); break;
        case 2: _t->setInputList(*reinterpret_cast< QVariant*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject MusicList::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_MusicList.data,
      qt_meta_data_MusicList,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *MusicList::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *MusicList::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_MusicList.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int MusicList::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 5)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 5)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 5;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 3;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void MusicList::urlChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void MusicList::convertedMusicListChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void MusicList::inputListChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
