package com.vydya.theschool.web.security;


import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;


@Component
@Aspect
public class VydyaMethodLogger
{

     
  @Around("execution(* com.vydya.theschool..*.*(..)) && !execution(* com.vydya.theschool.web.security..*(..))")
  	public Object logMethodDetails(ProceedingJoinPoint joinPoint) throws Throwable
    {
        
        StringBuffer logMessageStringBuffer = new StringBuffer();
        logMessageStringBuffer.append(joinPoint.getTarget().getClass().getName());
        logMessageStringBuffer.append(".");
        logMessageStringBuffer.append(joinPoint.getSignature().getName());
        
        StopWatch stopWatch = new StopWatch();
        Logger.getLogger(this.getClass()).info("ENTER:: " +logMessageStringBuffer);
        stopWatch.start();
        
        Object retVal = joinPoint.proceed();

        stopWatch.stop();
        Logger.getLogger(this.getClass()).info("EXIT:: " +logMessageStringBuffer);
      
        logMessageStringBuffer.append(" Execution time: ");
        logMessageStringBuffer.append(stopWatch.getTotalTimeMillis());
        logMessageStringBuffer.append(" ms");

        Logger.getLogger(this.getClass()).info(logMessageStringBuffer.toString());
        System.out.println(" vydya "+logMessageStringBuffer);
        return retVal;
    }

}



