#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QGraphicsScene>
#include <QMessageBox>
#include <QRegularExpression>
#include <cmath>

#include <QPainter>
#include <QPen>
#include <QBrush>
#include <QGraphicsTextItem>


MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    // Crear la escena para el gráfico
    scene = new QGraphicsScene(this);
    ui->graphicsView->setScene(scene);

    // Conectar botones
    connect(ui->btnCalcular, &QPushButton::clicked, this, &MainWindow::on_btnCalcular_clicked);
    connect(ui->btnLimite, &QPushButton::clicked, this, &MainWindow::on_btnLimite_clicked);
    connect(ui->btnDerivada, &QPushButton::clicked, this, &MainWindow::on_btnDerivada_clicked);
    connect(ui->btnIntegral, &QPushButton::clicked, this, &MainWindow::on_btnIntegral_clicked);
    connect(ui->btnIntegralDefinida, &QPushButton::clicked, this, &MainWindow::on_btnIntegralDefinida_clicked);

    ui->verticalSlider->setRange(10, 100);
    ui->verticalSlider->setValue(20);
    connect(ui->verticalSlider, &QSlider::valueChanged, this, &MainWindow::onZoomChanged);
}

MainWindow::~MainWindow()
{
    delete ui;
}

Polinomio MainWindow::parsearPolinomio(const QString &textoPolinomio){
    std::vector<Termino> terminos;
    QRegularExpression regex(R"(([+-]?\d*\.?\d*)x\^?(-?\d*)|([+-]?\d+))");
    QRegularExpressionMatchIterator it = regex.globalMatch(textoPolinomio);

    while(it.hasNext()){
        QRegularExpressionMatch match = it.next();

        if(match.captured(3).isEmpty()){
            // Capturar terminos con variable x
            QString coefStr = match.captured(1);
            QString expStr = match.captured(2);

            float coef = coefStr.isEmpty() || coefStr == "+" || coefStr == "-"
                             ? (coefStr == "-" ? -1 : 1)
                             : coefStr.toFloat();
            int exp = expStr.isEmpty() ? 1 : expStr.toInt();

            terminos.push_back({coef, exp});
        }
        else{
            // Capturar terminos constantes
            float coef = match.captured(3).toFloat();
            terminos.push_back({coef, 0}); // Exponente 0 para constantes
        }
    }

    if(terminos.empty()){
        throw std::invalid_argument("El polinomio no tiene términos válidos.");
    }

    return Polinomio(terminos);
}

void MainWindow::graficarPolinomio(Polinomio &polinomio){
    const double xMin = -50, xMax = 50, step = 0.1;
    double scale = ui->verticalSlider->value();  // Obtener valor de zoom desde el slider

    scene->clear();

    // Dibujar los ejes
    QPen ejePen(Qt::black, 1);
    scene->addLine(xMin * scale, 0, xMax * scale, 0, ejePen); // Eje X
    scene->addLine(0, -xMax * scale, 0, xMax * scale, ejePen); // Eje Y

    // Agregar valores a los ejes
    QFont font("Arial", 6); // Fuente para los valores
    for(int i = static_cast<int>(xMin); i <= static_cast<int>(xMax); ++i){
        if (i != 0) { // Evitar superposición en el origen
            // Valores en el eje X
            scene->addText(QString::number(i), font)->setPos(i * scale - 10, 5);
            // Líneas auxiliares (opcional)
            scene->addLine(i * scale, -3, i * scale, 3, QPen(Qt::gray));
        }
    }

    for(int i = static_cast<int>(-xMax); i <= static_cast<int>(xMax); ++i){
        if(i != 0){ // Evitar superposición en el origen
            // Valores en el eje Y
            scene->addText(QString::number(-i), font)->setPos(-15, i * scale - 10);
            // Líneas auxiliares (opcional)
            scene->addLine(-3, i * scale, 3, i * scale, QPen(Qt::gray));
        }
    }

    // Dibujar el polinomio
    QPen pen(Qt::red, 2);
    double prevX = xMin;
    double prevY = polinomio.evaluar(prevX);

    for (double x = xMin + step; x <= xMax; x += step) {
        double y = polinomio.evaluar(x);

        double x1 = prevX * scale;
        double y1 = -prevY * scale;
        double x2 = x * scale;
        double y2 = -y * scale;

        scene->addLine(x1, y1, x2, y2, pen);

        prevX = x;
        prevY = y;
    }

    //
    // Sombreado para el área bajo la curva
    if(ui->lineEditPolinomio->text().startsWith("∫")){
        QRegularExpression regex("∫ (-?\\d+)→(-?\\d+) ");
        QRegularExpressionMatch match = regex.match(ui->lineEditPolinomio->text());
        if(match.hasMatch()){
            double a = match.captured(1).toDouble();
            double b = match.captured(2).toDouble();

            QBrush brush(QColor(255, 0, 0, 128), Qt::SolidPattern);
            QPolygonF polygon;

            for(double x = a; x <= b; x += step){
                double y = polinomio.evaluar(x);
                polygon << QPointF(x * scale, -y * scale);
            }

            polygon << QPointF(b * scale, 0);
            polygon << QPointF(a * scale, 0);

            scene->addPolygon(polygon, QPen(Qt::transparent), brush);
        }
    }

    // Agregar punto para el límite si existe
    if(ui->lineEditPolinomio->text().startsWith("lim")){
        QRegularExpression regex("lim x→(-?\\d+)");
        QRegularExpressionMatch match = regex.match(ui->lineEditPolinomio->text());

        if(match.hasMatch()){
            double limitePunto = match.captured(1).toDouble();
            double valorLimite = polinomio.evaluar(limitePunto);

            QPen puntoPen(Qt::black, 2);
            scene->addEllipse(limitePunto * scale - 2.5, -valorLimite * scale - 2.5, 5, 5, puntoPen);
        }
    }
}



void MainWindow::on_btnCalcular_clicked(){
    QString textoPolinomio = ui->lineEditPolinomio->text();

    try{
        double valorPunto = 0.0;
        QString funcion = textoPolinomio;

        // Para el límite: extraemos el valor despues de "x→"
        if(textoPolinomio.startsWith("lim")){
            QRegularExpression regex("lim x→(-?\\d+)");
            QRegularExpressionMatch match = regex.match(textoPolinomio);

            if(match.hasMatch()){
                valorPunto = match.captured(1).toDouble();
                funcion = textoPolinomio.split('(').last().split(')').first();
            }
        }

        else if(textoPolinomio.startsWith("∫")){
            // Modificamos la expresión regular para manejar limites negativos
            QRegularExpression regex("∫ (-?\\d+)→(-?\\d+) ");
            QRegularExpressionMatch match = regex.match(textoPolinomio);
            if(match.hasMatch()){
                double a = match.captured(1).toDouble();  // Limite inferior
                double b = match.captured(2).toDouble();  // Limite superior
                funcion = textoPolinomio.split('(').last().split(')').first();

                // Crear una instancia de Polinomio
                Polinomio polinomio = parsearPolinomio(funcion);

                // Llamar a la integral definida
                double integralDef = polinomio.integral_def(a, b);
                ui->labelResultado->setText("Integral definida: " + QString::number(integralDef));
                graficarPolinomio(polinomio);  // Graficar la función original
                return; // Finalizar la función para evitar otros cálculos
            }
            else if(textoPolinomio.endsWith(" dx")){
                funcion = textoPolinomio.mid(0, textoPolinomio.length() - 3); // Eliminar " dx"
            }
        }

        // Filtrar el "d/dx" en caso de que exista
        if(textoPolinomio.startsWith("d/dx")){
            // Eliminar "d/dx" de la entrada
            funcion = textoPolinomio.mid(5);

            if(funcion.endsWith(")")){
                funcion = funcion.mid(0, funcion.length() - 1); // Eliminar ')'
            }
        }

        Polinomio polinomio = parsearPolinomio(funcion);

        // Procesar según el tipo de operación
        if(textoPolinomio.startsWith("lim")){
            double limite = polinomio.limite(valorPunto);
            ui->labelResultado->setText("Límite en x→" + QString::number(valorPunto) + ": " + QString::number(limite));
            graficarPolinomio(polinomio);
        }

        else if(textoPolinomio.startsWith("d/dx")){
            Polinomio derivada = polinomio.derivada();
            QString derivadaTexto = derivada.toString();  // Convertir la derivada a texto
            ui->labelResultado->setText("Derivada: " + derivadaTexto);
            graficarPolinomio(derivada);  // Graficar la derivada
        }

        else if(textoPolinomio.startsWith("∫")){
            if (textoPolinomio.contains("→")){}
            else{
                Polinomio integral = polinomio.integral();
                QString integralTexto = integral.toString();  // Convertir la integral a texto
                integralTexto += " + C";  // Agregar +C a la integral indefinida
                ui->labelResultado->setText("Integral indefinida: " + integralTexto);
                graficarPolinomio(integral);  // Graficar la integral
            }
        }

        else{
            graficarPolinomio(polinomio);
            ui->labelResultado->setText("Función graficada.");
        }


    } catch(std::exception &e){
        QMessageBox::warning(this, "Error", "No se pudo procesar el polinomio ingresado.");
    }
}

void MainWindow::on_btnLimite_clicked(){
    ui->lineEditPolinomio->setText("lim x→ ()");
}

void MainWindow::on_btnDerivada_clicked(){
    ui->lineEditPolinomio->setText("d/dx ()");
}

void MainWindow::on_btnIntegral_clicked(){
    ui->lineEditPolinomio->setText("∫ () dx");
}

void MainWindow::on_btnIntegralDefinida_clicked(){
    ui->lineEditPolinomio->setText("∫ a→b () dx");
}

void MainWindow::onZoomChanged(int value){
    // Vuelve a graficar el polinomio con la nueva escala
    QString textoPolinomio = ui->lineEditPolinomio->text();

    try{
        on_btnCalcular_clicked();
    } catch(std::exception &e){
        QMessageBox::warning(this, "Error", "No se pudo procesar el polinomio ingresado.");
    }
}
