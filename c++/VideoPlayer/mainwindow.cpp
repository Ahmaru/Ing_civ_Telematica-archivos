#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QMessageBox>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
    , reproductor(new QMediaPlayer(this))
{
    ui->setupUi(this);
    reproductor->setVideoOutput(ui->Videoplay);
    //connect(ui->SelectBoton,&QPushButton::clicked,this,&MainWindow::on_SelectBoton_clicked);
    connect(ui->PlayBoton,&QPushButton::clicked,reproductor,&QMediaPlayer::play);
    connect(ui->PauseBoton,&QPushButton::clicked,reproductor,&QMediaPlayer::pause);
    connect(ui->StopBoton,&QPushButton::clicked,reproductor,&QMediaPlayer::stop);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_SelectBoton_clicked(){
    QString filename = QFileDialog::getOpenFileName(this,"Open video","","Videos (*.mp4)");
    if(!filename.isEmpty()){
        reproductor->setMedia(QUrl::fromLocalFile(filename));
    }else{
        QMessageBox::warning(this,"Error","seleccion incorrecta de archivo");
    }
}
