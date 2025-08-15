#include "widget.h"
#include "ui_widget.h"

Widget::Widget(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::Widget)
{
    ui->setupUi(this);

    ventas2023 = ui->textEdit2023;
    ventas2024 = ui->textEdit2024;

    // Completar el código del constructor según lo solicitado
    serie = new QPieSeries();
    serie->append("Ventas 2023",Widget.ventas2023);
    serie->append("Ventas 2024",Widget.ventas2024);

    QChart *chart = new QChart();
    chart->addSeries(serie);
    chart->setTitle("Ventas 2023 y 2024");
    chart->createDefaultAxes();
    ui->graphicsViewPIE->setChart(chart);

    //conections
    connect(ui->textEdit2023 , SIGNAL(textChanged()) , this , SLOT(Update2023(int)));
    connect(ui->textEdit2024 , SIGNAL(textChanged()) , this , SLOT(Update2024(int)));

    connect(ui->pushButtonActualizar , &QPushButton.click() , this , UpdatePlot());


}

void Widget::Update2023(sales){
    ventas2023 = sales;
    //UpdatePlot();
}

void Widget::Update2024(sales){
    ventas2024 = sales;
    //UpdatePlot();
}

void Widget::UpdatePlot(){
    serie->clear();
    serie->append("Ventas 2023",Widget::ventas2023);
    serie->append("Ventas 2024",Widget::ventas2024);

}

// Complete con las implementaciones de los métodos/slots indicados

Widget::~Widget()
{
    // Recuerde liberar memoria dinámica!
    Qchart *chart = ui->graphicsViewPIE->chart();
    delete ui;
    delete chart;
    delete serie;

}
