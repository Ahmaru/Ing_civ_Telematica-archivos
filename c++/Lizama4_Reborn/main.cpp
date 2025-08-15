#include "c2qt.h"

#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    C2QT w;
    w.show();
    return a.exec();
}
