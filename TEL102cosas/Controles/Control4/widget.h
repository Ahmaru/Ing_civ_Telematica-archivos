#ifndef WIDGET_H
#define WIDGET_H

#include <QWidget>
#include <QPieSeries>

QT_BEGIN_NAMESPACE
namespace Ui {
class Widget;
}
QT_END_NAMESPACE

// Complete el código de la clase según lo solicitado
class Widget : public QWidget
{
    Q_OBJECT

public:
    Widget(QWidget *parent = nullptr);
    ~Widget();

public slots:
    // Completar con slots solicitados
    void Update2023(int sales);
    void Update2024(int sales);

private:
    Ui::Widget *ui;

    // Completar con atributos y métodos privados solicitados

    int ventas2023;
    int ventas2024;

    QPieSeries *serie;

    void UpdatePlot();

};
#endif // WIDGET_H
