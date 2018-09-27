package common;

import org.junit.Before;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

//这是之前在测试类没用 @ContextConfiguration(locations={"classpath:spring/applicationContext-db.xml"})注解时加载context的
public class BaseSpring {

    public static ApplicationContext context;

    @Before
    public void startSpring(){
        context = new ClassPathXmlApplicationContext("spring/applicationContext.xml");
    }
}
