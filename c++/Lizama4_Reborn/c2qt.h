#ifndef C2QT_H
#define C2QT_H

#include <QMainWindow>

QT_BEGIN_NAMESPACE
namespace Ui {
class C2QT;
}
QT_END_NAMESPACE

class C2QT : public QMainWindow
{
    Q_OBJECT

public:
    C2QT(QWidget *parent = nullptr);
    ~C2QT();

private:
    Ui::C2QT *ui;
};
#endif // C2QT_H
