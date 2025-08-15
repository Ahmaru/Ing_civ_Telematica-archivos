/********************************************************************************
** Form generated from reading UI file 'widget.ui'
**
** Created by: Qt User Interface Compiler version 6.8.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_WIDGET_H
#define UI_WIDGET_H

#include <QtCharts/QChartView>
#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QHBoxLayout>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QTextEdit>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_Widget
{
public:
    QVBoxLayout *verticalLayout;
    QPushButton *pushButtonActualizar;
    QTextEdit *textEdit2023;
    QTextEdit *textEdit2024;
    QChartView *graphicsViewPIE;
    QHBoxLayout *horizontalLayout;

    void setupUi(QWidget *Widget)
    {
        if (Widget->objectName().isEmpty())
            Widget->setObjectName("Widget");
        Widget->resize(800, 600);
        verticalLayout = new QVBoxLayout(Widget);
        verticalLayout->setObjectName("verticalLayout");
        pushButtonActualizar = new QPushButton(Widget);
        pushButtonActualizar->setObjectName("pushButtonActualizar");

        verticalLayout->addWidget(pushButtonActualizar);

        textEdit2023 = new QTextEdit(Widget);
        textEdit2023->setObjectName("textEdit2023");

        verticalLayout->addWidget(textEdit2023);

        textEdit2024 = new QTextEdit(Widget);
        textEdit2024->setObjectName("textEdit2024");

        verticalLayout->addWidget(textEdit2024);

        graphicsViewPIE = new QChartView(Widget);
        graphicsViewPIE->setObjectName("graphicsViewPIE");

        verticalLayout->addWidget(graphicsViewPIE);

        horizontalLayout = new QHBoxLayout();
        horizontalLayout->setObjectName("horizontalLayout");

        verticalLayout->addLayout(horizontalLayout);


        retranslateUi(Widget);

        QMetaObject::connectSlotsByName(Widget);
    } // setupUi

    void retranslateUi(QWidget *Widget)
    {
        Widget->setWindowTitle(QCoreApplication::translate("Widget", "Widget", nullptr));
        pushButtonActualizar->setText(QCoreApplication::translate("Widget", "Actualizar Grafico", nullptr));
    } // retranslateUi

};

namespace Ui {
    class Widget: public Ui_Widget {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_WIDGET_H
