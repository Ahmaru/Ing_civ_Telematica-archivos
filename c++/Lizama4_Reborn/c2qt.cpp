#include "c2qt.h"
#include "ui_c2qt.h"

C2QT::C2QT(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::C2QT)
{
    ui->setupUi(this);
}

C2QT::~C2QT()
{
    delete ui;
}
