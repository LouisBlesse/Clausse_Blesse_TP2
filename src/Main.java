import edu.uqac.aop.chess.*;
import java.util.Scanner;


public class Main {
    public static void main(String[] args) {
        Scanner myObj = new Scanner(System.in);
        System.out.println("Quel programme voulez vous lancer ? \n 1 : Nourrir les Pigeons \n 2 : Jeu d'échec");
        int choix = myObj.nextInt();

        if (choix == 1){
            System.out.println("WIP");
        }
        else if (choix == 2){
            System.out.println("WIP");
            Chess chess = new Chess();
            chess.main(null);
        }
    }
}