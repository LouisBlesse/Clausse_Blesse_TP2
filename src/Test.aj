import edu.uqac.aop.chess.agent.HumanPlayer;
import edu.uqac.aop.chess.agent.Move;
import edu.uqac.aop.chess.piece.Piece;
import org.aspectj.lang.ProceedingJoinPoint;
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

    pointcut testMove(): call (boolean edu.uqac.aop.chess.piece.Piece.isMoveLegal(..)) && !within(edu.uqac.aop.chess.agent.AiPlayer);
    after() returning (boolean legal): testMove(){
        if (legal == false ){
            System.out.println("Cette pièce ne peut pas faire ce mouvement");
        }
        else {
            System.out.println("Cette pièce peut faire ce mouvement");
        }
    }

    Object around (Board plateau, Move move):
    call (void edu.uqac.aop.chess.Board.movePiece(Move)) && target( plateau ) && args( move ) && !within(edu.uqac.aop.chess.agent.AiPlayer){
        if ( move.xF > 7 || move.yF > 7){
            System.out.println("La pièce ne peut pas bouger car elle sortirait du cadre, vous perdez votre tour");
            return null;
        }
        else {
            System.out.println("La pièce reste dans le cadre");
            return proceed(plateau,move);
        }
    }

    Object around (Board plateau, Move move):
    call (void edu.uqac.aop.chess.Board.movePiece(Move)) && target( plateau ) && args( move ) && !within(edu.uqac.aop.chess.agent.AiPlayer){

        if (plateau.getGrid()[move.xF][move.yF].getPiece() != null){
            if(plateau.getGrid()[move.xF][move.yF].getPiece().getPlayer() != 0){
                System.out.println("Vous ne pouvez pas manger votre propore pièce, vous perdez votre tour");
                return null;
            }
            else{
                System.out.println("Vous mangez une pièce ennemie");
                return proceed(plateau,move);
            }
        }
        return proceed(plateau,move);
        /*if ( plateau.getGrid()[move.xF][move.yF].getPiece().getPlayer()==1){
            System.out.println("La pièce ne peut pas bouger car elle sortirait du cadre, vous perdez votre tour");
            return null;
        }
        else {
            System.out.println("La pièce reste dans le cadre");
            return proceed(plateau,move);
        }*/
    }
    //trow exeption/string
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
