#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <vector>
#include <QLabel>
#include <QVBoxLayout>
#include <QString>

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

public slots:
    void updateSubscribers();
    void addSubscriber();

private slots:
    QString on_Lineaentrada_returnPressed();

private:
    Ui::MainWindow *ui;
    std::vector<QLabel *> subscribers;
    int followers;
};
#endif // MAINWINDOW_H
