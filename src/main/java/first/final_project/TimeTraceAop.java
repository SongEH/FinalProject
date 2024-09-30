package first.final_project;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

@Aspect
public class TimeTraceAop {
    
    @Around("execute(* first.final_projct..*(..)) && !target (first.final_project.config.WebsocketConfig)")
    public void execute(ProceedingJoinPoint joinPoint){

        long start = System.currentTimeMillis();

        System.out.println("START: " + joinPoint.toString());

        try {
            
        } finally {
            long finish = System.currentTimeMillis();
            long timeMs = finish - start;
            System.out.println("END: " + joinPoint + " " + timeMs + "ms");
        }
    }
}
