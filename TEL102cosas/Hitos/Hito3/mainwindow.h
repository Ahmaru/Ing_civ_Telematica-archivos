#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

#include <QGraphicsView>
#include <QGraphicsScene>
#include "polinomio.h"

QT_BEGIN_NAMESPACE
namespace Ui {
class MainWindow;
}
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:
    //void graficarPolinomio();

    void on_btnCalcular_clicked();
    void on_btnLimite_clicked();
    void on_btnDerivada_clicked();
    void on_btnIntegral_clicked();
    void on_btnIntegralDefinida_clicked();

    void onZoomChanged(int value);
private:
    Ui::MainWindow *ui;
    QGraphicsScene *scene;

    void graficarPolinomio(Polinomio &polinomio);
    Polinomio parsearPolinomio(const QString &textoPolinomio);
};
#endif // MAINWINDOW_H
