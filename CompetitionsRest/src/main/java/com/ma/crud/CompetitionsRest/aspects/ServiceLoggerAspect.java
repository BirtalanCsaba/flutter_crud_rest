package com.ma.crud.CompetitionsRest.aspects;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.hibernate.service.spi.ServiceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class ServiceLoggerAspect {
    Logger logger = LoggerFactory.getLogger(getClass());

    @Around("execution(public * com.ma.crud.CompetitionsRest.services..*(..))")
    public Object aroundServices(ProceedingJoinPoint theProceedingJoinPoint) throws Throwable {
        MethodSignature methodSignature =
                (MethodSignature) theProceedingJoinPoint.getSignature();
        logger.trace("Entered: " + methodSignature);

        Object[] args = theProceedingJoinPoint.getArgs();

        if (args.length > 0) {
            logger.trace("Method arguments: ");
            // loop throw the arguments
            for (Object tempArg : args) {
                if (tempArg != null) {
                    logger.trace(tempArg.toString());
                }
            }
        }

        // get begin timestamp
        long begin = System.currentTimeMillis();

        // execute the method
        Object result = theProceedingJoinPoint.proceed();

        // get end timestamp
        long end = System.currentTimeMillis();

        long duration = end - begin;
        logger.info(methodSignature + " DURATION: " + duration + " ms");
        if (result == null) {
            return null;
        }
        logger.trace(methodSignature + " RESULT: " + result);
        return result;
    }
}
