/********************************************************************************
** Form generated from reading UI file 'mainwindow.ui'
**
** Created by: Qt User Interface Compiler version 6.8.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MAINWINDOW_H
#define UI_MAINWINDOW_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QGraphicsView>
#include <QtWidgets/QLabel>
#include <QtWidgets/QLineEdit>
#include <QtWidgets/QMainWindow>
#include <QtWidgets/QMenuBar>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QSlider>
#include <QtWidgets/QStatusBar>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_MainWindow
{
public:
    QWidget *centralwidget;
    QLineEdit *lineEditPolinomio;
    QGraphicsView *graphicsView;
    QPushButton *btnCalcular;
    QPushButton *btnIntegral;
    QPushButton *btnDerivada;
    QPushButton *btnLimite;
    QPushButton *btnIntegralDefinida;
    QLabel *label_2;
    QLabel *labelResultado;
    QLabel *label_3;
    QSlider *verticalSlider;
    QMenuBar *menubar;
    QStatusBar *statusbar;

    void setupUi(QMainWindow *MainWindow)
    {
        if (MainWindow->objectName().isEmpty())
            MainWindow->setObjectName("MainWindow");
        MainWindow->resize(594, 702);
        centralwidget = new QWidget(MainWindow);
        centralwidget->setObjectName("centralwidget");
        lineEditPolinomio = new QLineEdit(centralwidget);
        lineEditPolinomio->setObjectName("lineEditPolinomio");
        lineEditPolinomio->setGeometry(QRect(50, 100, 421, 41));
        graphicsView = new QGraphicsView(centralwidget);
        graphicsView->setObjectName("graphicsView");
        graphicsView->setGeometry(QRect(50, 290, 491, 341));
        btnCalcular = new QPushButton(centralwidget);
        btnCalcular->setObjectName("btnCalcular");
        btnCalcular->setGeometry(QRect(470, 100, 101, 41));
        btnIntegral = new QPushButton(centralwidget);
        btnIntegral->setObjectName("btnIntegral");
        btnIntegral->setGeometry(QRect(320, 20, 121, 51));
        btnDerivada = new QPushButton(centralwidget);
        btnDerivada->setObjectName("btnDerivada");
        btnDerivada->setGeometry(QRect(180, 20, 121, 51));
        btnLimite = new QPushButton(centralwidget);
        btnLimite->setObjectName("btnLimite");
        btnLimite->setGeometry(QRect(50, 20, 121, 51));
        btnIntegralDefinida = new QPushButton(centralwidget);
        btnIntegralDefinida->setObjectName("btnIntegralDefinida");
        btnIntegralDefinida->setGeometry(QRect(450, 20, 121, 51));
        label_2 = new QLabel(centralwidget);
        label_2->setObjectName("label_2");
        label_2->setGeometry(QRect(50, 160, 91, 41));
        QFont font;
        font.setFamilies({QString::fromUtf8("Microsoft Himalaya")});
        font.setPointSize(17);
        font.setBold(false);
        font.setItalic(false);
        label_2->setFont(font);
        label_2->setStyleSheet(QString::fromUtf8("color: #595959; "));
        labelResultado = new QLabel(centralwidget);
        labelResultado->setObjectName("labelResultado");
        labelResultado->setGeometry(QRect(50, 200, 511, 41));
        labelResultado->setFont(font);
        label_3 = new QLabel(centralwidget);
        label_3->setObjectName("label_3");
        label_3->setGeometry(QRect(50, 240, 91, 41));
        label_3->setFont(font);
        label_3->setStyleSheet(QString::fromUtf8("color: #595959; "));
        verticalSlider = new QSlider(centralwidget);
        verticalSlider->setObjectName("verticalSlider");
        verticalSlider->setGeometry(QRect(550, 290, 18, 341));
        verticalSlider->setMinimumSize(QSize(18, 0));
        verticalSlider->setMaximumSize(QSize(16777215, 341));
        verticalSlider->setOrientation(Qt::Orientation::Vertical);
        MainWindow->setCentralWidget(centralwidget);
        menubar = new QMenuBar(MainWindow);
        menubar->setObjectName("menubar");
        menubar->setGeometry(QRect(0, 0, 594, 25));
        MainWindow->setMenuBar(menubar);
        statusbar = new QStatusBar(MainWindow);
        statusbar->setObjectName("statusbar");
        MainWindow->setStatusBar(statusbar);

        retranslateUi(MainWindow);

        QMetaObject::connectSlotsByName(MainWindow);
    } // setupUi

    void retranslateUi(QMainWindow *MainWindow)
    {
        MainWindow->setWindowTitle(QCoreApplication::translate("MainWindow", "MainWindow", nullptr));
        btnCalcular->setText(QCoreApplication::translate("MainWindow", "Calcular", nullptr));
        btnIntegral->setText(QCoreApplication::translate("MainWindow", "\342\210\253", nullptr));
        btnDerivada->setText(QCoreApplication::translate("MainWindow", "d/dx", nullptr));
        btnLimite->setText(QCoreApplication::translate("MainWindow", "lim x\342\206\222", nullptr));
        btnIntegralDefinida->setText(QCoreApplication::translate("MainWindow", "\342\210\253 a\342\206\222b", nullptr));
        label_2->setText(QCoreApplication::translate("MainWindow", "Soluci\303\263n", nullptr));
        labelResultado->setText(QString());
        label_3->setText(QCoreApplication::translate("MainWindow", "Gr\303\241fica", nullptr));
    } // retranslateUi

};

namespace Ui {
    class MainWindow: public Ui_MainWindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MAINWINDOW_H
