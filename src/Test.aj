import edu.uqac.aop.chess.piece.Piece;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import edu.uqac.aop.chess.*;

public aspect Test {
    pointcut printCall(): call (void edu.uqac.aop.chess.Chess.play());

    before(): printCall(){
        System.out.println("test\ntest\n");
    }

    pointcut testOccupied(): call (boolean edu.uqac.aop.chess.Spot.isOccupied()) && !within(edu.uqac.aop.chess.Board) && !within(edu.uqac.aop.chess.agent.AiPlayer);
    after() returning (boolean oc): testOccupied(){
        if (oc == false ){
            System.out.println("Cette case est innocupée");
        }
        else {
            System.out.println("Cette case est bien occupée");
        }
    }

    pointcut testGoodColor(): call (int edu.uqac.aop.chess.piece.Piece.getPlayer()) && !within(edu.uqac.aop.chess.agent.AiPlayer);
    after() returning (int player): testGoodColor(){
        if (player == 0 ){
            System.out.println("Cette pièce n'est pas à vous");
        }
        else {
            System.out.println("Cette pièce est bien à vous");
        }
    }
    /*
        @Pointcut("execution(void Chess.main(null)")
    public void selectAll()
    {

    }
    @Before("selectAll()")
    public void beforeAdvice()
    {
        System.out.println("Before Advice called");
    }*/
}
