#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QPushButton>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
    , layout(new QVBoxLayout(this))
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}
