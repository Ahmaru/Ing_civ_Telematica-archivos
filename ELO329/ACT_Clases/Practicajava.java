import java.util.Scanner;

public class Practicajava {
    public static void main(String[] args){
        int a, x;
        double b;
        char cl = 'p';
        boolean flag;
        flag = false;
        String palabra = "Chao ";

        System.out.println("Ingrese el primer numero: ");Scanner sc = new Scanner(System.in);
        a = sc.nextInt(); 

        System.out.println("Ingrese el segundo numero: ");
        x = sc.nextInt();

        //System.out.println(a);
        //System.out.println(x);

        int sum = x+a;
        System.out.println("SUMA: "+ sum);
        if(sum==11){System.out.println("Chupaloentonce");};

        flag = a>x;

        System.out.println("El primer numero es mayor? " + flag);

        b = Integer.valueOf(a);

        System.out.println("Division: "+ b/x);

        System.out.println(palabra + cl + "inis");

        sc.close();

    }
}
