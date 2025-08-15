public class TestFiguras {

    public static void main(String[] args){

        Figura lcd = new Circulo(15);
        Figura clona = new Rectangulo(8, 10);

        System.out.println("Figura: " + lcd.getTipo() + ", Area: " + lcd.getArea() + "\n");
        System.out.println("Figura: " + clona.getTipo() + ", Area: " + clona.getArea() + "\n");

    }
}

abstract class Figura{
    abstract double getArea();

    String getTipo(){
        return "Figura";
    }

}

class Rectangulo extends Figura{
    private double base;
    private double altura;

    public Rectangulo(double b , double a ){
        base = b;
        altura = a;
    }

    double getArea(){
        return(base*altura);
    }

    String getTipo(){
        return "Rectangulo";
    }

}

class Circulo extends Figura{
    private double radio;

    public Circulo(double r){
        radio = r;
    }

    double getArea(){
        return(radio*radio*3);
    }

    String getTipo(){
        return "Circulo";
    }

}