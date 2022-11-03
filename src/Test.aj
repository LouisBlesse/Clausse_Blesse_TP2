import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import edu.uqac.aop.chess.*;

public aspect Test {
    pointcut printCall(): call (void edu.uqac.aop.chess.Chess.play());

    before(): printCall(){
        System.out.println("test\ntest\n");
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
