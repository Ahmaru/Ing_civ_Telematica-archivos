#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
    , followers(0)
{
    ui->setupUi(this);
    ui->Contador->setText("0");
    addSubscriber();
    connect(ui->Lineaentrada,&QLineEdit::returnPressed,this,&MainWindow::updateSubscribers);
    connect(ui->agregarSub,&QPushButton::clicked,this,&MainWindow::addSubscriber);
}

MainWindow::~MainWindow()
{
    delete ui;
}
void MainWindow::updateSubscribers(){
    for (unsigned long i=0; i< subscribers.size() ; i++){
        subscribers.at(i)->setText(MainWindow::on_Lineaentrada_returnPressed());
    }

}
void MainWindow::addSubscriber(){
    QLabel * newSubscriber = new QLabel("just came in");
    ui->SubscriberverticalLayout->addWidget(newSubscriber);
    subscribers.push_back(newSubscriber);
    this->followers++;
    ui->Contador->setText(QString::number(followers));
}

QString MainWindow::on_Lineaentrada_returnPressed()
{
    return ui->Lineaentrada->text();
}

