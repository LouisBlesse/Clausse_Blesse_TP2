import edu.uqac.aop.chess.agent.HumanPlayer;
import edu.uqac.aop.chess.agent.Move;
import edu.uqac.aop.chess.piece.Piece;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import edu.uqac.aop.chess.*;

public aspect Test {

    //vérif 6
    Object around (Board plateau, Move move):
            call (void edu.uqac.aop.chess.Board.movePiece(Move)) && target( plateau ) && args( move ) && !within(edu.uqac.aop.chess.agent.AiPlayer){

        if (plateau.getGrid()[move.xI][move.yI].getPiece() != null) {
            if (plateau.getGrid()[move.xI][move.yI].getPiece().toString() == "C"){
                System.out.println("Cas 1");
                return proceed(plateau, move);
            }
            else{
                if (move.xF<move.xI){
                    for (int i = move.xF+1; i < move.xI; i++ ){
                        //System.out.println("enter 2" + i);
                        if (plateau.getGrid()[i][move.yI].getPiece() != null){
                            System.out.println("Vous ne pouvez pas passer au dessus d'une autre pièce, vous perdez votre tour");
                            return null;
                        }
                    }
                }else{
                    for (int i = move.xI+1; i < move.xF; i++ ){
                        //System.out.println("enter 3" + i);
                        if (plateau.getGrid()[i][move.yI].getPiece() != null){
                            System.out.println("Vous ne pouvez pas passer au dessus d'une autre pièce, vous perdez votre tour");
                            return null;
                        }
                    }
                }

                if (move.yF<move.yI){
                    for (int i = move.yF+1; i < move.yI; i++ ){
                        //System.out.println("enter 4" + i);
                        if (plateau.getGrid()[move.xI][i].getPiece() != null){
                            System.out.println("Vous ne pouvez pas passer au dessus d'une autre pièce, vous perdez votre tour");
                            return null;
                        }
                    }
                }else{
                    for (int i = move.yI+1; i < move.yF; i++ ){
                        //System.out.println("enter 5" + i);
                        if (plateau.getGrid()[move.xI][i].getPiece() != null){
                            System.out.println("Vous ne pouvez pas passer au dessus d'une autre pièce, vous perdez votre tour");
                            return null;
                        }
                    }
                }
            }
        }
        return proceed(plateau, move);
    }


    //vérif 1
    pointcut testOccupied(): call (boolean edu.uqac.aop.chess.Spot.isOccupied()) && !within(edu.uqac.aop.chess.Board) && !within(edu.uqac.aop.chess.agent.AiPlayer);
    after() returning (boolean oc): testOccupied(){
        if (oc == false ){
            System.out.println("Cette case est innocupée");
        }
        else {
            System.out.println("Cette case est bien occupée");
        }
    }

    //vérif 2
    pointcut testGoodColor(): call (int edu.uqac.aop.chess.piece.Piece.getPlayer()) && !within(edu.uqac.aop.chess.agent.AiPlayer);
    after() returning (int player): testGoodColor(){
        if (player == 0 ){
            System.out.println("Cette pièce n'est pas à vous");
        }
        else {
            System.out.println("Cette pièce est bien à vous");
        }
    }

    //vérif 3
    pointcut testMove(): call (boolean edu.uqac.aop.chess.piece.Piece.isMoveLegal(..)) && !within(edu.uqac.aop.chess.agent.AiPlayer);
    after() returning (boolean legal): testMove(){
        if (legal == false ){
            System.out.println("Cette pièce ne peut pas faire ce mouvement");
        }
        else {
            System.out.println("Cette pièce peut faire ce mouvement");
        }
    }

    //vérif 4
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

    //vérif 5
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
    }

}

