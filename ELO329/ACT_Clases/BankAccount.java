import java.util.Scanner;

public class BankAccount {
    public static void main(String[] args){

        System.out.println("Cuenta creada para: ");Scanner sc = new Scanner(System.in);
        String name = sc.nextLine();

        System.out.println("Deposito: ");
        double deposit = sc.nextDouble();

        CuentaBancaria persona = new CuentaBancaria(name, deposit);

        persona.mostrarInfo();
        System.out.println("Ingrese deposito: "); double ola = sc.nextDouble();

        persona.depositar(ola);

        System.out.println("Saldo actualizado. ꌛꌛꌛꌛꌛ");
        persona.mostrarInfo();

        sc.close();

    }
}

class CuentaBancaria {
    
    public CuentaBancaria(String n , double s){
        Titular = n;
        Saldo = s;
    }

    public String getName(){
        return Titular;
    }

    public double getSaldo(){
        return Saldo;
    }

    public void depositar(double monto){
        Saldo += monto;
    }

    public void mostrarInfo(){
        System.out.println("Nombre del titular: " + Titular + "\nSaldo: " + Saldo);
    }
    
    private String Titular;
    private double Saldo;
}
