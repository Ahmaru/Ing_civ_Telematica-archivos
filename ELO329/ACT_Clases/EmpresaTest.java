public class EmpresaTest{
    public static void main(String[] args){

        Empleado e = new Empleado("Jose",500);

        Gerente a = new Gerente("Camilo", 750, "Comunicaciones");

        e.getDetalles();

        a.getDetalles();
    }
}

class Empleado{
    
    public Empleado(String n , double s){
        Nombre = n;
        Salario = s;

    }

    public Empleado(){}

    public double getSalario(){
        return Salario;
    }

    public String getNombre(){
        return Nombre;
    }

    public void getDetalles(){
        System.out.println("Empleado: "+ Nombre + " Salario: " + Salario);
    }

    private String Nombre;
    private double Salario;
}

class Gerente extends Empleado{

    public Gerente(String n , double s , String Dpto){
        super(n, s);
        Departamento = Dpto;
    }

    public void getDetalles(){
        System.out.println("Gerente: "+ getNombre() + " Salario: " + getSalario() + " Departamento: " + Departamento);
    }



    private String Departamento;
}