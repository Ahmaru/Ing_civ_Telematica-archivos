/********************************************************************************
** Form generated from reading UI file 'mainwindow.ui'
**
** Created by: Qt User Interface Compiler version 5.15.13
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MAINWINDOW_H
#define UI_MAINWINDOW_H

#include <QtCore/QVariant>
#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QComboBox>
#include <QtWidgets/QGridLayout>
#include <QtWidgets/QHBoxLayout>
#include <QtWidgets/QLabel>
#include <QtWidgets/QLineEdit>
#include <QtWidgets/QMainWindow>
#include <QtWidgets/QMenu>
#include <QtWidgets/QMenuBar>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QSpacerItem>
#include <QtWidgets/QStackedWidget>
#include <QtWidgets/QStatusBar>
#include <QtWidgets/QTextBrowser>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_MainWindow
{
public:
    QWidget *centralwidget;
    QGridLayout *gridLayout_7;
    QStackedWidget *stackedWidget;
    QWidget *Generador;
    QGridLayout *gridLayout_2;
    QHBoxLayout *LayoutVolverMenu;
    QPushButton *gen_pushVolver;
    QSpacerItem *horizontalSpacer;
    QHBoxLayout *LayoutPrincipal;
    QVBoxLayout *LayoutOpciones;
    QSpacerItem *verticalSpacer;
    QComboBox *gen_combEjercicios;
    QComboBox *gen_combTipo;
    QPushButton *gen_pushGenerar;
    QPushButton *gen_pushResultado;
    QGridLayout *LayoutTextos;
    QWidget *widget_grafico;
    QSpacerItem *horizontalSpacer_2;
    QSpacerItem *horizontalSpacer_3;
    QLabel *gen_labEnunciado;
    QLabel *gen_labSolucion;
    QWidget *inicioDesafio;
    QGridLayout *gridLayout_12;
    QGridLayout *gridLayout_10;
    QGridLayout *gridLayout_8;
    QSpacerItem *horizontalSpacer_4;
    QSpacerItem *horizontalSpacer_5;
    QHBoxLayout *horizontalLayout;
    QPushButton *BotonIniciar;
    QLabel *label;
    QSpacerItem *verticalSpacer_4;
    QSpacerItem *verticalSpacer_3;
    QTextBrowser *textBrowser;
    QWidget *Desafio_2;
    QGridLayout *gridLayout_14;
    QGridLayout *gridLayout_11;
    QGridLayout *gridLayout_15;
    QLineEdit *RespuestaUsuario;
    QLabel *TextoRespuesta;
    QSpacerItem *horizontalSpacer_8;
    QLabel *VerificadorVisual;
    QPushButton *BotonEnviarRespuesta;
    QSpacerItem *horizontalSpacer_15;
    QPushButton *SalirDesafio;
    QSpacerItem *verticalSpacer_7;
    QSpacerItem *verticalSpacer_8;
    QGridLayout *gridLayout_13;
    QSpacerItem *verticalSpacer_5;
    QLabel *EnunciadoDesafio;
    QSpacerItem *horizontalSpacer_7;
    QSpacerItem *verticalSpacer_6;
    QSpacerItem *horizontalSpacer_6;
    QGridLayout *gridLayout_16;
    QLabel *TiempoDesafio;
    QGridLayout *gridLayout_17;
    QLabel *PuntajeUsuario;
    QWidget *Menu;
    QGridLayout *gridLayout_3;
    QGridLayout *gridLayout_4;
    QSpacerItem *horizontalSpacer_31;
    QPushButton *BotonDesafio;
    QSpacerItem *verticalSpacer_2;
    QSpacerItem *horizontalSpacer_9;
    QPushButton *botonGenerador;
    QGridLayout *gridLayout_9;
    QGridLayout *gridLayout_5;
    QSpacerItem *horizontalSpacer_21;
    QSpacerItem *verticalSpacer1;
    QSpacerItem *horizontalSpacer1;
    QLabel *label_4;
    QMenuBar *menubar;
    QMenu *menuBeta;
    QStatusBar *statusbar;

    void setupUi(QMainWindow *MainWindow)
    {
        if (MainWindow->objectName().isEmpty())
            MainWindow->setObjectName(QString::fromUtf8("MainWindow"));
        MainWindow->resize(1070, 706);
        centralwidget = new QWidget(MainWindow);
        centralwidget->setObjectName(QString::fromUtf8("centralwidget"));
        gridLayout_7 = new QGridLayout(centralwidget);
        gridLayout_7->setObjectName(QString::fromUtf8("gridLayout_7"));
        stackedWidget = new QStackedWidget(centralwidget);
        stackedWidget->setObjectName(QString::fromUtf8("stackedWidget"));
        Generador = new QWidget();
        Generador->setObjectName(QString::fromUtf8("Generador"));
        Generador->setEnabled(true);
        gridLayout_2 = new QGridLayout(Generador);
        gridLayout_2->setObjectName(QString::fromUtf8("gridLayout_2"));
        LayoutVolverMenu = new QHBoxLayout();
        LayoutVolverMenu->setObjectName(QString::fromUtf8("LayoutVolverMenu"));
        gen_pushVolver = new QPushButton(Generador);
        gen_pushVolver->setObjectName(QString::fromUtf8("gen_pushVolver"));

        LayoutVolverMenu->addWidget(gen_pushVolver);

        horizontalSpacer = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        LayoutVolverMenu->addItem(horizontalSpacer);


        gridLayout_2->addLayout(LayoutVolverMenu, 0, 0, 1, 1);

        LayoutPrincipal = new QHBoxLayout();
        LayoutPrincipal->setObjectName(QString::fromUtf8("LayoutPrincipal"));
        LayoutOpciones = new QVBoxLayout();
        LayoutOpciones->setObjectName(QString::fromUtf8("LayoutOpciones"));
        verticalSpacer = new QSpacerItem(20, 40, QSizePolicy::Minimum, QSizePolicy::Expanding);

        LayoutOpciones->addItem(verticalSpacer);

        gen_combEjercicios = new QComboBox(Generador);
        gen_combEjercicios->setObjectName(QString::fromUtf8("gen_combEjercicios"));

        LayoutOpciones->addWidget(gen_combEjercicios);

        gen_combTipo = new QComboBox(Generador);
        gen_combTipo->setObjectName(QString::fromUtf8("gen_combTipo"));

        LayoutOpciones->addWidget(gen_combTipo);

        gen_pushGenerar = new QPushButton(Generador);
        gen_pushGenerar->setObjectName(QString::fromUtf8("gen_pushGenerar"));

        LayoutOpciones->addWidget(gen_pushGenerar);

        gen_pushResultado = new QPushButton(Generador);
        gen_pushResultado->setObjectName(QString::fromUtf8("gen_pushResultado"));

        LayoutOpciones->addWidget(gen_pushResultado);


        LayoutPrincipal->addLayout(LayoutOpciones);

        LayoutTextos = new QGridLayout();
        LayoutTextos->setObjectName(QString::fromUtf8("LayoutTextos"));
        LayoutTextos->setSizeConstraint(QLayout::SetMinAndMaxSize);
        widget_grafico = new QWidget(Generador);
        widget_grafico->setObjectName(QString::fromUtf8("widget_grafico"));
        QSizePolicy sizePolicy(QSizePolicy::Fixed, QSizePolicy::Fixed);
        sizePolicy.setHorizontalStretch(100);
        sizePolicy.setVerticalStretch(0);
        sizePolicy.setHeightForWidth(widget_grafico->sizePolicy().hasHeightForWidth());
        widget_grafico->setSizePolicy(sizePolicy);
        widget_grafico->setMinimumSize(QSize(400, 400));

        LayoutTextos->addWidget(widget_grafico, 1, 1, 1, 1);

        horizontalSpacer_2 = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        LayoutTextos->addItem(horizontalSpacer_2, 0, 0, 1, 1);

        horizontalSpacer_3 = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        LayoutTextos->addItem(horizontalSpacer_3, 0, 2, 1, 1);

        gen_labEnunciado = new QLabel(Generador);
        gen_labEnunciado->setObjectName(QString::fromUtf8("gen_labEnunciado"));
        QFont font;
        font.setPointSize(15);
        gen_labEnunciado->setFont(font);
        gen_labEnunciado->setAlignment(Qt::AlignCenter);

        LayoutTextos->addWidget(gen_labEnunciado, 0, 1, 1, 1);

        gen_labSolucion = new QLabel(Generador);
        gen_labSolucion->setObjectName(QString::fromUtf8("gen_labSolucion"));
        gen_labSolucion->setFont(font);
        gen_labSolucion->setAlignment(Qt::AlignCenter);

        LayoutTextos->addWidget(gen_labSolucion, 2, 1, 1, 1);


        LayoutPrincipal->addLayout(LayoutTextos);


        gridLayout_2->addLayout(LayoutPrincipal, 1, 0, 1, 1);

        stackedWidget->addWidget(Generador);
        inicioDesafio = new QWidget();
        inicioDesafio->setObjectName(QString::fromUtf8("inicioDesafio"));
        inicioDesafio->setEnabled(true);
        gridLayout_12 = new QGridLayout(inicioDesafio);
        gridLayout_12->setObjectName(QString::fromUtf8("gridLayout_12"));
        gridLayout_10 = new QGridLayout();
        gridLayout_10->setObjectName(QString::fromUtf8("gridLayout_10"));
        gridLayout_8 = new QGridLayout();
        gridLayout_8->setObjectName(QString::fromUtf8("gridLayout_8"));
        horizontalSpacer_4 = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        gridLayout_8->addItem(horizontalSpacer_4, 0, 0, 1, 1);

        horizontalSpacer_5 = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        gridLayout_8->addItem(horizontalSpacer_5, 0, 2, 1, 1);

        horizontalLayout = new QHBoxLayout();
        horizontalLayout->setObjectName(QString::fromUtf8("horizontalLayout"));
        BotonIniciar = new QPushButton(inicioDesafio);
        BotonIniciar->setObjectName(QString::fromUtf8("BotonIniciar"));
        QSizePolicy sizePolicy1(QSizePolicy::Fixed, QSizePolicy::Fixed);
        sizePolicy1.setHorizontalStretch(0);
        sizePolicy1.setVerticalStretch(0);
        sizePolicy1.setHeightForWidth(BotonIniciar->sizePolicy().hasHeightForWidth());
        BotonIniciar->setSizePolicy(sizePolicy1);
        QFont font1;
        font1.setFamily(QString::fromUtf8("Unispace"));
        font1.setPointSize(24);
        font1.setBold(true);
        BotonIniciar->setFont(font1);

        horizontalLayout->addWidget(BotonIniciar);


        gridLayout_8->addLayout(horizontalLayout, 5, 1, 1, 1);

        label = new QLabel(inicioDesafio);
        label->setObjectName(QString::fromUtf8("label"));
        QFont font2;
        font2.setFamily(QString::fromUtf8("Trebuchet MS"));
        font2.setPointSize(36);
        font2.setBold(true);
        label->setFont(font2);
        label->setAlignment(Qt::AlignCenter);

        gridLayout_8->addWidget(label, 0, 1, 1, 1);

        verticalSpacer_4 = new QSpacerItem(20, 40, QSizePolicy::Minimum, QSizePolicy::Expanding);

        gridLayout_8->addItem(verticalSpacer_4, 3, 1, 1, 1);

        verticalSpacer_3 = new QSpacerItem(20, 40, QSizePolicy::Minimum, QSizePolicy::Expanding);

        gridLayout_8->addItem(verticalSpacer_3, 6, 1, 1, 1);

        textBrowser = new QTextBrowser(inicioDesafio);
        textBrowser->setObjectName(QString::fromUtf8("textBrowser"));

        gridLayout_8->addWidget(textBrowser, 2, 1, 1, 1);


        gridLayout_10->addLayout(gridLayout_8, 0, 0, 1, 1);


        gridLayout_12->addLayout(gridLayout_10, 0, 0, 1, 1);

        stackedWidget->addWidget(inicioDesafio);
        Desafio_2 = new QWidget();
        Desafio_2->setObjectName(QString::fromUtf8("Desafio_2"));
        gridLayout_14 = new QGridLayout(Desafio_2);
        gridLayout_14->setObjectName(QString::fromUtf8("gridLayout_14"));
        gridLayout_11 = new QGridLayout();
        gridLayout_11->setObjectName(QString::fromUtf8("gridLayout_11"));

        gridLayout_14->addLayout(gridLayout_11, 2, 1, 1, 1);

        gridLayout_15 = new QGridLayout();
        gridLayout_15->setObjectName(QString::fromUtf8("gridLayout_15"));
        RespuestaUsuario = new QLineEdit(Desafio_2);
        RespuestaUsuario->setObjectName(QString::fromUtf8("RespuestaUsuario"));

        gridLayout_15->addWidget(RespuestaUsuario, 1, 1, 1, 1);

        TextoRespuesta = new QLabel(Desafio_2);
        TextoRespuesta->setObjectName(QString::fromUtf8("TextoRespuesta"));

        gridLayout_15->addWidget(TextoRespuesta, 1, 0, 1, 1);

        horizontalSpacer_8 = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        gridLayout_15->addItem(horizontalSpacer_8, 1, 6, 1, 1);

        VerificadorVisual = new QLabel(Desafio_2);
        VerificadorVisual->setObjectName(QString::fromUtf8("VerificadorVisual"));

        gridLayout_15->addWidget(VerificadorVisual, 1, 3, 1, 1);

        BotonEnviarRespuesta = new QPushButton(Desafio_2);
        BotonEnviarRespuesta->setObjectName(QString::fromUtf8("BotonEnviarRespuesta"));

        gridLayout_15->addWidget(BotonEnviarRespuesta, 1, 2, 1, 1);

        horizontalSpacer_15 = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        gridLayout_15->addItem(horizontalSpacer_15, 1, 4, 1, 1);

        SalirDesafio = new QPushButton(Desafio_2);
        SalirDesafio->setObjectName(QString::fromUtf8("SalirDesafio"));

        gridLayout_15->addWidget(SalirDesafio, 2, 6, 1, 1);

        verticalSpacer_7 = new QSpacerItem(20, 40, QSizePolicy::Minimum, QSizePolicy::Expanding);

        gridLayout_15->addItem(verticalSpacer_7, 2, 4, 1, 1);

        verticalSpacer_8 = new QSpacerItem(20, 40, QSizePolicy::Minimum, QSizePolicy::Expanding);

        gridLayout_15->addItem(verticalSpacer_8, 0, 4, 1, 1);


        gridLayout_14->addLayout(gridLayout_15, 2, 0, 1, 1);

        gridLayout_13 = new QGridLayout();
        gridLayout_13->setObjectName(QString::fromUtf8("gridLayout_13"));
        verticalSpacer_5 = new QSpacerItem(20, 40, QSizePolicy::Minimum, QSizePolicy::Expanding);

        gridLayout_13->addItem(verticalSpacer_5, 3, 1, 1, 1);

        EnunciadoDesafio = new QLabel(Desafio_2);
        EnunciadoDesafio->setObjectName(QString::fromUtf8("EnunciadoDesafio"));
        QFont font3;
        font3.setFamily(QString::fromUtf8("Sitka Heading"));
        font3.setPointSize(26);
        font3.setBold(false);
        font3.setItalic(false);
        font3.setStrikeOut(false);
        EnunciadoDesafio->setFont(font3);

        gridLayout_13->addWidget(EnunciadoDesafio, 2, 1, 1, 1);

        horizontalSpacer_7 = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        gridLayout_13->addItem(horizontalSpacer_7, 2, 2, 1, 1);

        verticalSpacer_6 = new QSpacerItem(20, 40, QSizePolicy::Minimum, QSizePolicy::Expanding);

        gridLayout_13->addItem(verticalSpacer_6, 1, 1, 1, 1);

        horizontalSpacer_6 = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        gridLayout_13->addItem(horizontalSpacer_6, 2, 0, 1, 1);

        gridLayout_16 = new QGridLayout();
        gridLayout_16->setObjectName(QString::fromUtf8("gridLayout_16"));
        TiempoDesafio = new QLabel(Desafio_2);
        TiempoDesafio->setObjectName(QString::fromUtf8("TiempoDesafio"));
        QFont font4;
        font4.setPointSize(12);
        TiempoDesafio->setFont(font4);

        gridLayout_16->addWidget(TiempoDesafio, 0, 0, 1, 1);


        gridLayout_13->addLayout(gridLayout_16, 0, 0, 1, 1);

        gridLayout_17 = new QGridLayout();
        gridLayout_17->setObjectName(QString::fromUtf8("gridLayout_17"));
        PuntajeUsuario = new QLabel(Desafio_2);
        PuntajeUsuario->setObjectName(QString::fromUtf8("PuntajeUsuario"));
        PuntajeUsuario->setFont(font4);

        gridLayout_17->addWidget(PuntajeUsuario, 0, 0, 1, 1);


        gridLayout_13->addLayout(gridLayout_17, 0, 2, 1, 1);


        gridLayout_14->addLayout(gridLayout_13, 0, 0, 1, 1);

        stackedWidget->addWidget(Desafio_2);
        Menu = new QWidget();
        Menu->setObjectName(QString::fromUtf8("Menu"));
        gridLayout_3 = new QGridLayout(Menu);
        gridLayout_3->setObjectName(QString::fromUtf8("gridLayout_3"));
        gridLayout_4 = new QGridLayout();
        gridLayout_4->setObjectName(QString::fromUtf8("gridLayout_4"));
        horizontalSpacer_31 = new QSpacerItem(400, 30, QSizePolicy::Fixed, QSizePolicy::Minimum);

        gridLayout_4->addItem(horizontalSpacer_31, 1, 2, 1, 1);

        BotonDesafio = new QPushButton(Menu);
        BotonDesafio->setObjectName(QString::fromUtf8("BotonDesafio"));

        gridLayout_4->addWidget(BotonDesafio, 1, 1, 1, 1);

        verticalSpacer_2 = new QSpacerItem(20, 40, QSizePolicy::Minimum, QSizePolicy::Expanding);

        gridLayout_4->addItem(verticalSpacer_2, 2, 1, 1, 1);

        horizontalSpacer_9 = new QSpacerItem(400, 20, QSizePolicy::Fixed, QSizePolicy::Minimum);

        gridLayout_4->addItem(horizontalSpacer_9, 1, 0, 1, 1);

        botonGenerador = new QPushButton(Menu);
        botonGenerador->setObjectName(QString::fromUtf8("botonGenerador"));

        gridLayout_4->addWidget(botonGenerador, 0, 1, 1, 1);


        gridLayout_3->addLayout(gridLayout_4, 1, 0, 1, 1);

        gridLayout_9 = new QGridLayout();
        gridLayout_9->setObjectName(QString::fromUtf8("gridLayout_9"));
        gridLayout_5 = new QGridLayout();
        gridLayout_5->setObjectName(QString::fromUtf8("gridLayout_5"));
        horizontalSpacer_21 = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        gridLayout_5->addItem(horizontalSpacer_21, 0, 2, 1, 1);

        verticalSpacer1 = new QSpacerItem(20, 40, QSizePolicy::Minimum, QSizePolicy::Expanding);

        gridLayout_5->addItem(verticalSpacer1, 1, 1, 1, 1);

        horizontalSpacer1 = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        gridLayout_5->addItem(horizontalSpacer1, 0, 0, 1, 1);

        label_4 = new QLabel(Menu);
        label_4->setObjectName(QString::fromUtf8("label_4"));
        label_4->setTextFormat(Qt::AutoText);

        gridLayout_5->addWidget(label_4, 0, 1, 1, 1);


        gridLayout_9->addLayout(gridLayout_5, 0, 0, 1, 1);


        gridLayout_3->addLayout(gridLayout_9, 0, 0, 1, 1);

        stackedWidget->addWidget(Menu);

        gridLayout_7->addWidget(stackedWidget, 1, 0, 1, 1);

        MainWindow->setCentralWidget(centralwidget);
        menubar = new QMenuBar(MainWindow);
        menubar->setObjectName(QString::fromUtf8("menubar"));
        menubar->setGeometry(QRect(0, 0, 1070, 23));
        menuBeta = new QMenu(menubar);
        menuBeta->setObjectName(QString::fromUtf8("menuBeta"));
        MainWindow->setMenuBar(menubar);
        statusbar = new QStatusBar(MainWindow);
        statusbar->setObjectName(QString::fromUtf8("statusbar"));
        MainWindow->setStatusBar(statusbar);

        menubar->addAction(menuBeta->menuAction());

        retranslateUi(MainWindow);

        stackedWidget->setCurrentIndex(3);
        gen_combTipo->setCurrentIndex(-1);


        QMetaObject::connectSlotsByName(MainWindow);
    } // setupUi

    void retranslateUi(QMainWindow *MainWindow)
    {
        MainWindow->setWindowTitle(QCoreApplication::translate("MainWindow", "Matreforce", nullptr));
        gen_pushVolver->setText(QCoreApplication::translate("MainWindow", "Volver al Menu", nullptr));
        gen_combEjercicios->setPlaceholderText(QCoreApplication::translate("MainWindow", "Ejercicio", nullptr));
        gen_combTipo->setPlaceholderText(QCoreApplication::translate("MainWindow", "Tipo", nullptr));
        gen_pushGenerar->setText(QCoreApplication::translate("MainWindow", "Generar Ejercicio", nullptr));
        gen_pushResultado->setText(QCoreApplication::translate("MainWindow", "Mostrar Resultado", nullptr));
        gen_labEnunciado->setText(QCoreApplication::translate("MainWindow", "Seleccione un ejercicio.", nullptr));
        gen_labSolucion->setText(QString());
        BotonIniciar->setText(QCoreApplication::translate("MainWindow", "Iniciar", nullptr));
        label->setText(QCoreApplication::translate("MainWindow", "Modo Desafio", nullptr));
        textBrowser->setHtml(QCoreApplication::translate("MainWindow", "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n"
"<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\n"
"p, li { white-space: pre-wrap; }\n"
"hr { height: 1px; border-width: 0; }\n"
"li.unchecked::marker { content: \"\\2610\"; }\n"
"li.checked::marker { content: \"\\2612\"; }\n"
"</style></head><body style=\" font-family:'Ubuntu Sans'; font-size:11pt; font-weight:400; font-style:normal;\">\n"
"<p align=\"center\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Segoe UI'; font-size:14pt;\">El Modo Desafio consiste en retar al usuario para ver cuantos ejercicios puede resolver en contrareloj. Si resuelve correctamente un ejercicio aumentara el tiempo y si llega a cero el desafio habra terminado.</span></p></body></html>", nullptr));
        TextoRespuesta->setText(QCoreApplication::translate("MainWindow", "Respuesta:", nullptr));
        VerificadorVisual->setText(QCoreApplication::translate("MainWindow", "Verificador", nullptr));
        BotonEnviarRespuesta->setText(QCoreApplication::translate("MainWindow", "Enviar", nullptr));
        SalirDesafio->setText(QCoreApplication::translate("MainWindow", "Salir", nullptr));
        EnunciadoDesafio->setText(QCoreApplication::translate("MainWindow", "Enunciado", nullptr));
        TiempoDesafio->setText(QCoreApplication::translate("MainWindow", "Timer", nullptr));
        PuntajeUsuario->setText(QCoreApplication::translate("MainWindow", "Puntaje:", nullptr));
        BotonDesafio->setText(QCoreApplication::translate("MainWindow", "Modo Desafio", nullptr));
        botonGenerador->setText(QCoreApplication::translate("MainWindow", "Generador", nullptr));
        label_4->setText(QString());
        menuBeta->setTitle(QCoreApplication::translate("MainWindow", "MatReforce Beta", nullptr));
    } // retranslateUi

};

namespace Ui {
    class MainWindow: public Ui_MainWindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MAINWINDOW_H
