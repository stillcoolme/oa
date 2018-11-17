# oa系统
办公自动化项目。进行到知识管理。

## 1. 框架整合

### 1.1 整合主要步骤
使用java7，建立maven项目，配置pom文件。

建三个src folder
```
         src.main.java           存放源代码的
             com.stillcoolme.oa.struts2.action
             com.stillcoolme.oa.dao
             com.stillcoolme.oa.dao.impl
             com.stillcoolme.oa.service
             com.stillcoolme.oa.service.impl
             com.stillcoolme.oa.domain
         src.main.java config        存放所有的配置文件
              struts2
              hibernate
              spring
                 applicationContext.xml
                 applicationContext-db.xml
         src.main.java test          存放测试类
              com.stillcoolme.oa.test
```
在dao和service层相应的包中写接口和类。

在applicationContext-db.xml文件中写sessionFactory。

在com.stillcoolme.oa.test包中新建一个类SessionFactoryTest，目的是为了测试SessionFactory是否配置正确。

(声明式事务在用了注解后就不要了的，这里只是介绍一下)
配置applicationContext.xml，写spring的声明式事务处理transactionManager
在spring的配置文件中写dao和service
通过savePerson方法测试声明式事务处理，dao

编写action。

编写struts2的配置文件。

编写web.xml文件。：1.以监听器的形式启动spring容器，来与tomcat整合；2.以过滤器的形式整合struts2容器

最后测试action。

这么做项目你会觉得做项目做的很踏实。

### 1.2 对web.xml里的struts整合原理解释

#### 讲解一下 web.xml里面以监听器的形式启动spring容器，来与tomcat整合。
 ```
   <listener>
        <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
   </listener>
   <context-param>
         <param-name>contextConfigLocation</param-name>
         <param-value>classpath:spring/applicationContext.xml</param-value>
   </context-param>
 ```
打开ContextLoaderListener类。
```
public void contextInitialized(ServletContextEvent event) {
		this.contextLoader = createContextLoader();
		if (this.contextLoader == null) {
			this.contextLoader = this;
		}
		this.contextLoader.initWebApplicationContext(event.getServletContext());
	}
```
contextInitialized()里面的 
  1. createContextLoader()  加载spring的web容器
  2. initWebApplicationContext()  初始化spring的web容器，加载其配置文件
当执行完这两个方法以后，就启动spring的web容器了。
在spring容器中，单例模式的bean就被实例化了，所以dao和service层的对象和代理对象就在这个时候产生了


#### 讲解一下 web.xml里面以过滤器的形式整合struts2容器
```
<filter>
    <filter-name>struts2</filter-name>
    <filter-class>org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter</filter-class>
</filter>
```
打开StrutsPrepareAndExecuteFilter类。
这个过滤器有 一个init方法和 dofiltr方法。

当tomcat启动的时候执行init方法。

```$xslt
//这个方法实际干了下面两个事。
public void init(FilterConfig filterConfig) throws ServletException {
    //获取了初始化的各种配置文件：defalut.properties、struts-default.xml、struts-plugin.xml、struts.xml
    Dispatcher dispatcher = init.initDispatcher(config);
    //静态注入，初始化配置文件中的bean
    init.initStaticContentLoader(config, dispatcher);
}
```
当外部进行请求：请求url：localhost:8080/personAction_savePerson.action

先找struts的xml配置文件，会找根据struts2的相关配置查找action的创建方式。
去struts-default.xml,struts-plugin.xml,struts.xml文件找`struts.objectFactory常量`，看是由哪个类创建了action
哪个配置文件加载在最后，哪个决定
最后在struts和spring整合的包中找到了struts-plugin.xml文件
```$xslt
<bean type="com.opensymphony.xwork2.ObjectFactory" name="spring" class="org.apache.struts2.spring.StrutsSpringObjectFactory" />
             <constant name="struts.objectFactory" value="spring" />
```
由上述的内容可以知道，action是由StrutsSpringObjectFactory创建的，而该类继承了SpringObjectFactory。
SpringObjectFactory没有重写buildAction()，而是再继承ObjectFactory，调用父类的buildAction()。
```
public Object buildAction(String actionName, String namespace, ActionConfig config, Map<String, Object> extraContext) throws Exception {
        return this.buildBean(config.getClassName(), extraContext);  //config里得到注解@Controller("userAction")配置的action名
}
```
然后buildBean()方法还是会调用到子类SpringObjectFactory的buildBean()。
```
public Object buildBean(String beanName, Map<String, Object> extraContext, boolean injectInternal) throws Exception {
    Object o = null;

    try {
        o = this.appContext.getBean(beanName);   //从spring容器中得到bean
    } catch (NoSuchBeanDefinitionException var7) {
        //没有spring容器，再根据java反射机制创建bean
        Class beanClazz = this.getClassInstance(beanName);
        o = this.buildBean(beanClazz, extraContext);
    }
    if (injectInternal) {
        this.injectInternalBeans(o);
    }
    return o;
}
```
于是就创建了action，还有执行这过滤器的dofiltr方法，然后注入servcie和dao，于是流程走通。。。

------

另外再说说StrutsPrepareAndExecuteFilter的dofilter()。

首先会调用createActionContext()
```java
public ActionContext createActionContext(HttpServletRequest request, HttpServletResponse response) {
        ActionContext oldContext = ActionContext.getContext();
        ActionContext ctx;
        if (oldContext != null) {
            ctx = new ActionContext(new HashMap(oldContext.getContextMap()));
        } else {
            ValueStack stack = ((ValueStackFactory)this.dispatcher.getContainer().getInstance(ValueStackFactory.class)).createValueStack();
            stack.getContext().putAll(this.dispatcher.createContextMap(request, response, (ActionMapping)null, this.servletContext));
            ctx = new ActionContext(stack.getContext());
        }
        ActionContext.setContext(ctx);
        return ctx;
    }
```
* 在ActionContext中存在一个 Map<String, Object> context
* PrepareOperations类中 ```ValueStack stack = dispatcher.getContainer().getInstance(ValueStackFactory.class).createValueStack();```通过静态注入创建ValueStack的实现类：OgnlValueStack，
也就意味着在创建actionContext的时候，值栈就被创建了。取值栈中的context给ctx
* ValueStack中的map栈和ActionContext中的Map是一样的
* 通过ActionContext.setContext(ctx);就把actionContext放入到ThreadLocal中，这样数据就安全了


dofilter()里面调用完createActionContext()创建ActionContext后，就到```this.execute.executeAction(request, response, mapping);```
然后```this.dispatcher.serviceAction(request, response, this.servletContext, mapping);```
就到Dispatcher类里面
```java
public void serviceAction(HttpServletRequest request, HttpServletResponse response, ServletContext context, ActionMapping mapping) throws ServletException {
    //创建各种不同的map
    Map<String, Object> extraContext = this.createContextMap(request, response, mapping, context);
    //ActionProxy的创建
    ActionProxy proxy = ((ActionProxyFactory)config.getContainer().getInstance(ActionProxyFactory.class)).createActionProxy(namespace, name, method, extraContext, true, false);
    
    proxy.execute();
}
```
然后在createActionProxy的时候，到DefaultActionProxyFactory类，创建了DefaultActionInvocation
```java
public ActionProxy createActionProxy(String namespace, String actionName, String methodName, Map<String, Object> extraContext, boolean executeResult, boolean cleanupContext) {
        ActionInvocation inv = new DefaultActionInvocation(extraContext, true);
        this.container.inject(inv);
        return this.createActionProxy((ActionInvocation)inv, namespace, actionName, (String)methodName, executeResult, cleanupContext);
 }
``` 
再到StrutsActionProxyFactory类，看到proxy.prepare();
```java
public ActionProxy createActionProxy(ActionInvocation inv, String namespace, String actionName, String methodName, boolean executeResult, boolean cleanupContext) {
        StrutsActionProxy proxy = new StrutsActionProxy(inv, namespace, actionName, methodName, executeResult, cleanupContext);
        this.container.inject(proxy);
        proxy.prepare();       //!!!!!!!!!!!!!!!!
        return proxy;
    }
```
看到prepare()里面有
```java
  this.invocation.init(this); 
```
所以，在创建ActionProxy的时候，就已经执行invocation的init方法
```java
public void init(ActionProxy proxy) {   //DefaultActionInvocation类的init（）
     this.createAction(contextMap);
     List<InterceptorMapping> interceptorList = new ArrayList(proxy.getConfig().getInterceptors());
     this.interceptors = interceptorList.iterator();
}
```
invocation的init方法做的事情，由具体实现：**action的创建和所有的拦截器的创建**

于是创建好proxy，这时回到Dispatcher类，继续执行```proxy.execute();```。
execute()里面执行invocation中的inovke方法```this.invocation.invoke();```。
由下面代码可以看到作了下面几个事情：
*  执行了所有的拦截器
*  执行了当前请求的action
*  执行了结果集
```java
public String invoke(){
    //执行所有的拦截器
    this.resultCode = interceptor.getInterceptor().intercept(this);   
    //执行当前请求的action
    this.resultCode = this.invokeActionOnly();
    //执行结果集
    this.executeResult();
}
```

综上可知，先是创建值栈，然后ActionContext，然后创建action。


#### 扩展知识

视频5-17min
当执行执行当前请求的action：```invokeActionOnly()```
我可以获取action的实例，我是不是可以获取action的方法名称，然后调用。
但这样方法就没有统一的入口。假设你实现action必须实现Execute接口，
那个Execute接口就会有统一的方法入口，不能统一调用service，也不可以统一处理异常。
struts2里是这样处理异常的：

在StrutsPrepareAndExecuteFilter的```doFilter()```就 try 了。
因为页面发个请求都要经过过滤器，现在在过滤器里就整个都 try 了
进到```serviceAction()``里面也是整个都 try 了。
然后 最后通过调用```sendError()```方法返回一个模板文件。



### spring管理事务
ssh整合以后，用spring容器来管理事务（以前是hibernate来做，还得管启动关闭回滚。）
现在就只要关注事务的范围。注意：
* 如果当前执行的方法没有事务环境，当this.getHibernateTemplate这个方法执行完以后session立即关闭
* 如果当前执行的方法有事务环境，当事务环境的方法被调用完毕以后，session关闭
下面测试一下：
```java
public class TransactionTest extends BaseSpring{
	/**
	 *  直接运行dao层，没有事务环境
	 * 当应用程序调用完personDao里面getPersonById()的
	 * Person person = (Person)this.getHibernateTemplate().load(Person.class, 1L);
	 *   session直接关闭了,那么执行personDao里下一句System.out.println(person.getPname());就报错了。
	 */
	@Test
	public void testHibernateTemplate(){
		PersonDao personDao = (PersonDao)context.getBean("personDao");
		personDao.getPersonById(1L);   //里面System.out.println(person.getPname());报错
	}
	/**
	 * 当整个方法有事务环境，当方法调用完以后，session关闭
	 * 
	 */
	@Test
	public void testService(){
		PersonService personService = (PersonService)context.getBean("personService");
		Person person = personService.getPersonById(1L);
		System.out.println(person.getPname());		////上句执行完关闭session，这句报错
	}
}

```

所以上面情况二不就是在action里面调用service的情况？怎么解决这懒加载引起的异常？

**解决方法**
在web.xml文件中：添加opensessioninview的配置。
```xml
 <filter>
    <filter-name>OpenSessionInViewFilter</filter-name>
    <filter-class>org.springframework.orm.hibernate3.support.OpenSessionInViewFilter</filter-class>
  </filter>
```
从OpenSessionInViewFilter代码可以看出来：
```java
protected void doFilterInternal() {
   SessionFactory sessionFactory = this.lookupSessionFactory(request);
   Session session = this.getSession(sessionFactory);
   finally {
       this.closeSession(sessionHolder.getSession(), sessionFactory);
   }
}
```
         
当提交一个请求时，在请求action之前，OpenSessionInView中已经把session开启了，在response以后才要关闭session
也就意味着有了opensessioninview模式以后，session的打开被提前了，session的关闭被延后了，这样就解决了懒加载引起的异常

这样也有缺点：因为session的关闭被延后了，而hibenate的一级缓存在session中，
所以会导致大量的缓存中的数据被长时间停留在内存中。



post处在sessioon环境中，是持久化对象
事务在service层，所以执行增删改要在事务环境。
```
public String update(){
    Post post = this.postService.getPostById(this.getModel().getPid());
    BeanUtils.copyProperties(this.getModel(), post);
    this.postService.updatePost(post);
    return action2action;
}
```


## 2. 用户模块

### 2.1 模块的做法
*  模块的需求分析
*  设计表结构，建持久化类和映射文件(搞清楚一对多多对一)，根据映射文件生成表。
*  dao层和service层
*  service层的测试
*  action层
*  struts2的配置文件
*  jsp页面
*  测试


设计表结构关系不要设计成环状饼状了，应该是星状。
作为一个有经验老到的需求人员。对于User、Post、Depart三个表。
以User表为中心，建立User和Post、User和Depart的关系。
有静态页面可以看出：
![](https://images2018.cnblogs.com/blog/659358/201808/659358-20180811154238704-1137251913.png)
是以用户为驱动，去维护User和Post、User和Depart的关系。


### 2.2 Action和jsp迭代数据相关（struts、值栈知识）

值栈
* 值栈的生命周期：值栈的生命周期就是一次请求
* 值栈的数据结构：对象栈、map栈（reuqest,session,application都在map栈中按map存储）
* 对象栈和map栈有什么区别：对象栈是一个list、map栈是一个map
* 怎么样把一个数据放入到map栈中：```ActionContext.getContext().put("departmentList", departmentList);```
* 怎么样把一个数据放入到对象栈中：```ActionContext.getContext().getValueStack().push(departmentList);```
* 对象栈中的数据有什么样的特殊之处
	 
没有主动将对象放在栈顶，默认是当前请求的action在栈顶。
不然的话则是当前正在迭代的元素会在栈顶。

编写到DepartmentAction的时候，getAllDepartment()将查询到的list返回给前端，遇到下面的问题：
迭代器到企业里一定会常用，不要到时又不会！！！

ognl表达式怎么访问map栈中的内容？
1.如果一个对象在request中：#request.对象的key值.属性
2.如果一个对象直接放入到map栈中：#对象的key值.属性

ognl表达式怎么访问对象栈？
直接属性名称就可以了，不用加# ！！！！
处于对象栈的对象中的属性是可以直接访问的。
如果在对象栈中有一样名称的属性，从栈顶开始查找，直到找到为止。
一般情况下，回显的数据应该放在对象栈中，这样效果比较高。

前端jsp里面iterator说明
*  当前正在迭代的元素会被放在栈顶！！！  在iterator标签下添加一个<s:debug></s:debug>标签就可以在页面显示栈的情况了。
*  如果下面iterator标签的value属性不写，则默认迭代栈顶的元素
这时由于department的元素在栈顶，所以dname、description可以直接访问，而不用加#号。
```html
<s:iterator value="#departmentList">
    <s:debug></s:debug>
    <tr class="TableDetail1 template">
        <td><s:property value="dname"/></td>
        <td><s:property value="description" escape="false"/></td>
        <td>
```

### 2.3 模型驱动 
视频9-22
模型驱动：
   *  StudentAction implements ModelDriver<Student>
   *  在action中需要有一个私有的对象，并要getModel()方法
         private Student model = new Student();
   *  原理
        *  先经过ModelDriverInterceptor, 作用是把model放入到栈顶
        *  再经过ParametersInterrceptor, 把栈顶的属性赋值

属性驱动：
   *  在action中，有属性，属性的名称和页面上form表单中的name的值对应
   *  属性必须有set和get方法
   *  原理
         在提交一个请求以后，action中的属性在栈顶。然后ParametersInterceptor拦截器
         会把页面上的form表单的值获取，然后调出ValueStack，给栈顶的属性赋值。


这两个拦截器不能颠倒执行

    
看模型驱动的源代码就先看ModelDriverInterceptor类
```java
    //获取当前请求的action
    Object action = invocation.getAction();
    //然后将model对象放到栈顶，也就是Student对象
    Object model = modelDriven.getModel();
    stack.push(model);

```


### 2.4 页面之间的跳转

//转到添加页面， 就是前端的页面到add页面之间的跳转
	public String addUI(){
		return addUI;
	}
	
	public String add(){
		
		/*一般不要把ModelDriven的对象传到Dao，session中，不要this.departmentService.saveDepartment(this.getModel());
		 Action层的东西不要弄到后面的层，而且和session无关。
		 应该：1、新建一个department
		    2、把模型驱动中的值赋值到department中
		    3、执行save方法保存
		*/
		Department department = new Department();
		BeanUtils.copyProperties(this.getModel(), department); //!!对象的属性的赋值的过程copyProperties(Object source, Object target)
		this.departmentService.saveDepartment(department);
		return action2action;
		
	}
	

### 2.5 struts中chain和redirectAction的区别
在struts的配置文件中，可以配置result的类型为 chain 或者 redirectAction：
```xml
<result name="action2action" type="redirectAction">departmentAction_getAllDepartment.action</result>
或
<result name="action2action" type="chain">departmentAction_getAllDepartment.action</result>
```

使用 redirectAction 重定向 的话， 
因为重定向是浏览器重新发新的请求过来了。而valueStack是和request请求同一生命周期的。则原来的valueStack就没了。
第一个action的数据传不到后面的这个action(departmentAction_getAllDepartment.action)。
测试的时候在jps中添加<s:debug>标签可以看到valueStack里面只有一个Action。

使用 chain 的话。
通过源码ActionChainResult
```java
ValueStack stack = ActionContext.getContext().getValueStack();

private void addToHistory(String namespace, String actionName, String methodName) {
        List<String> chainHistory = getChainHistory();
        chainHistory.add(this.makeKey(namespace, actionName, methodName));
    }
```
先将action放进list里面
中间没有经历过重新请求，而是直接顺序执行多个action，于是就能获取上个action的数据。
这种一般用于像 注册功能，有页面且需要记住前面的数据 那种需求。



### 2.6 泛型知识进行重构

泛型是java中的类型
*  java.lang.Type可以代表java中的所有的类型，是所有类型的祖宗。其中有个实现 ParameterType就是 泛型。
*  泛型是被参数化的类型
        *  类型   --->Class 或 Inerface
        *  被参数化-->Class类型可以传递参数
*  泛型的存在的意义
        *  多态的缺点：实际的类型和需要的类型有可能不匹配，如果不匹配，则会报ClassCastException错误。
        *  而泛型可以在编译的时候告诉Class类型，传递的参数是什么类型，如果类型错误，则在编译的时候就会报错。
*  泛型所表现的形式
```java
//ArrayList是Class类型，ArrayList带一个参数为T，T是一个形参
ArrayList<T>
//在创建ArrayList对象的时候，就可以决定实参，这样实参为Person,这就意味着a集合中只能存放person
ArrayList<Person> a = new ArrayList<Person>();

//还有 下面可以看出 java的集合完全就是泛型的传递
public interface Collection<T> extends Interator<T> {

}
```



```java
public interface PersonDao<T>{

}
public class BaseDaoImpl<T>{

}

//谁的T，谁来传真的参数。上面PersonDao定义了T，所以是PersonDao来传入Person
public class PersonDaoImpl extends BaseDaoImpl<Person> implements PersonDao<Person>{

}
```

```
//传递的参数只能是集合的子类
public class Person<? extends Collection>
```

*  泛型的用法
public class Person<T>{

}
该参数T可以用在属性和方法(可以用在方法的参数和返回值)上
       

**重构**
通过ParameterizedType源码
```
public interface ParameterizedType extends Type {
    
    Type[] getActualTypeArguments();         //代表的是 <T>

    Type getRawType();                  //代表的是 BaseDaoImpl
    
    Type getOwnerType();
}
```

所以下面获取到 classt 来给 getEntryById方法使用，！！！！！！！！！！！！！！！！
```
public class BaseDaoImpl<T> implements BaseDao<T>{
	private Class classt;
	
	/**
	 * 1、在父类中要执行一段代码，这个代码的执行时间为子类创建对象的时候，这段代码已经执行完了，根据这个需求，有两种方案供选择
	   *  利用static语句块
	   *  利用父类的构造函数
	 * 2、分析：
	 因为得到ParameterizedType泛型 需要用到this关键字，而this关键字不能出现在static语句块中
	 所以只能选择父类的构造器
	 */
	public BaseDaoImpl(){
		/**
		 * ParameterizedType就是泛型
		 * 这里获取到 classt 来给下面的 getEntryById方法使用，！！！！！！！！！！！！！！！！
		 */
		ParameterizedType type = (ParameterizedType)this.getClass().getGenericSuperclass();     //this指的是子类，因为在BaseDaoImpl不new对象
		this.classt = (Class)type.getActualTypeArguments()[0];   //getActualTypeArguments()就是得到<T>
		System.out.println(type.getRawType()+" :"+this.classt);
		
		/*
		BaseDaoImpl不new对象， BaseDaoImpl泛型类也不能被实例化。
		如果泛型类被实例化，this.getClass().getGenericSuperclass()返回将是class,
		该this就是当前类的对象，所以一个被泛型化的类是不能被实例化的，只有不被实例化，返回的类型才是ParameterizedType
		不然就会报 Class cannot be cast to java.lang.reflect.ParameterizedType
         */
	}

	@Resource(name="hibernateTemplate")
	public HibernateTemplate hibernateTemplate;          //public的话子类可以用

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	public Collection<T> getAllEntry() {
		return (Collection<T>) this.hibernateTemplate.find("from "+this.classt.getName());
	}

	public T getEntryById(  Serializable id) {
		return (T)this.hibernateTemplate.get(this.classt, id);
	}

	public void deleteEntry(Serializable id) {
		T t = this.getEntryById(id);
		this.hibernateTemplate.delete(t);
	}

}
```

原来是写成这样的，就要在继承的子类里调用aa方法，太麻烦了吧
```
public class BaseDaoImpl<T> implements BaseDao<T>{
	public void aa(){
		ParameterizedType type = (ParameterizedType)this.getClass().getGenericSuperclass();     //this指的是子类，因为在BaseDaoImpl不new对象
	}
}
```


同样也可以将Action进行提取到BaseAction中！！！！！！！！！
```
public class BaseAction<T> extends ActionSupport implements ModelDriven<T>{
	
	private T t;
	private Class classt;

	public BaseAction(){
		try{
			ParameterizedType type =  (ParameterizedType) this.getClass().getGenericSuperclass();
			this.classt = (Class) type.getActualTypeArguments()[0];

			//本来这行代码写在下面的getModel()方法里，但是无法正确执行到
			this.t = (T)this.classt.newInstance();
		}catch(Exception e){
			e.printStackTrace();
		}

	}
	
    public T getModel() {
        return this.t;
    }

}
```




### 2.7 删除一行数据触发确认事件 (js知识，js插件)
在userlist.jsp的table删除一行数据，点击删除。
应该要有个click事件。但是你直接写在 a 标签那里就太low了吧。
另外写个common.js，这样有其他post、department的list页面也可以重用了，而且和页面又不藕合。

```js
//当页面加载时，给名称为  删除  的链接添加一个事件。注意没说哪个页面，和页面无关。牛

//json
var common = {
	myconfig:function(message){
		return window.confirm(message);
	}
};

//当页面加载时，给名称为  删除  的链接添加一个事件。
$().ready(function(){
	//所有的超级链接标签
	$("a").each(function(){
		if($(this).text()=="删除"){
			$(this).unbind("click");
			$(this).bind("click",function(){
				return common.myconfig("确认删除吗？");
			});
		}
	});	
});
```

将common.js添加到common.jsp即可。

测试遇到个问题：不会弹出确认框。
检查代码无误后打开chrome的检查看了一下，'删除'那些中文都是乱码来的了，原来是js文件用了ISO编码。
将js文件convert成utf8后居然还是不行。最后检查居然还要删除浏览器缓存才行。fuck。



将上面的做成JQuery的插件来使用。
JQuery插件分为： JQuery对象插件、全局插件
第一步 ```()();```
第二步
```js
(function(jQuery){    //这个JQuery是形参
})(jQuery);            //这个JQuery是实参
```

----------------------

下面来写对象插件 jQuery-confirm.js

先通过common.js获取到a标签对象，来得到一个jQuery对象才能调用对象插件jQuery-confirm.js的comfirm方法。
于是common.js变成
```js
$().ready(function() {
    $('a').each(function() {
      if($(this).text()=="删除"){
          $(this).unbind("click");
          $(this).bind("click", function(){
              //调用插件方法confirm()
              return $(this).confirm("确认删除吗？");
          });
      }
    });
});
```
所有的jQuery对象都有下面这confirm方法了!!!只要你取到jQuery对象就能调!!!!
jQuery-confirm.js：
```js
//针对某个对象的插件		
(function(jQujsy){
	$.fn.confirm = function(message){
		return window.confirm(message);
	}
})(jQuery);	
```
测试：在common.jsp导入插件，在common.js 调用$(this).confirm("确认删除？");

---------------

下面来写全局插件 jQuery-confirm.js

不用绑定某个元素的全局插件。
比较一下与上面的对象插件方法有什么不同。
插件这里把元素拿到了，上面的是common.js来拿元素。
```js
(function(jQuery){
    $.confirm = function(message){   //全局方法confirm
        $('a').each(function() {
          if($(this).text()=="删除"){
              $(this).unbind("click");
              $(this).bind("click", function() {
                return window.confirm(message);
              });
          }
        });
    }
})(jQuery);
```

common.js就变成：
//调用全局方法confirm会在加载页面的时候执行一次，以后每次点击并不会走这代码。
```js
$().ready(function() {
    //调用全局方法confirm。
   $.confirm("确定删除吗？");
});
```

------------------------

不用绑定某个元素的全局插件。
这次弄个回调，在confirm方法的参数中传一个回调方法。

效果：点击弹出自己的页面，能做自己的事，然后再弹出提示框？
```js
(function(jQuery) {
  $.confirm = function(message, callback) {
    $("a").each(function(){
        if($(this).text() == '删除'){
            $(this).unbind('click');
            $(this).bind('click', function() {
              callback();
              return window.confirm(message);
            })
        }
    });
  }
})(jQuery);
```
common.js：
```js
$().ready(function() {
  $.confirm("确定删除吗？", function() {
     alert("就是这么牛！！ 简单callback");
  })
});
```

-----------------

这次弄个难点的回调。
整合一下 数据 和 回调函数 成 json。 
```js
(function(jQuery) {
  $.confirm = function(confirmJson) {
    $("a").each(function() {
      if($(this).text() == "删除"){
          $(this).unbind("click");
          $(tshis).bind("click", function() {
            confirmJson.callback();
            return window.confirm(confirmJson.message);
          });
      }
    });
  }
})(jQuery);
```
common.js就变成这样：
```js
$().ready(function() {
  $.confirm({
    message : "确定删除吗？",
    callback : function() {
      alert("就是这么牛，厉害点的回调");
    }
  });
});
```

### 2.8 在线编辑器

将fckeditor文件夹放到webapp包下

然后写js代码。
创建jquery-fckeditor.js，创建jquery全局插件来初始化fckeditor，里面的都是拷贝例子代码：
```js
(function(jQuery) {
  $.fckeditor = function(name) {
    var oFCKeditor = new FCKeditor(name);
    oFCKeditor.BasePath	= "fckeditor/" ;
    //本来是很多编辑的工具的，通过查看fckeditor的配置文件可以知道设置simple就可以简化
    oFCKeditor.ToolbarSet = "simple";
    oFCKeditor.ReplaceTextarea() ;
  }
})(jQuery);
```

创建department_add.js来使用插件：
```js
$().ready(function () {
    $.fckeditor("descriptiion");
})
```

在department.jsp前面添加下面的引用
```xml
<script language="javascript" src="${pageContext.request.contextPath}/fckeditor/fckeditor.js"></script>
<script language="javascript" src="${pageContext.request.contextPath}/js/jquery-fckeditor.js"></script>
<script language="javascript" src="${pageContext.request.contextPath}/js/department_add.js"></script>
```


没法保存表情，而是保存成了表情的路径？
解决： 将list.jsp的里property的 escape设为false就可以得到fckeditor的表情
```xml
<td><s:property value="description" escape="false"/></td>  
```


学一个框架，最快的方法就是用它的例子程序写个helloworld。
实际上，学的好的同学，现在应该有这样的能力了啊。
你比如说自学spring的mvc，实际上mvc的知识比如控制器，获得表单数据。


### 2.9 用户查询
公司里面无非是单表查询，多表查询。
*  单表的查询
       *  页面上要显示的字段和数据库比，太少
           select new Person(pid,pname) from Person;
       *  页面上要显示的字段和数据库的字段差不多
           from Person
*  多表的查询 （根据页面的需求不同来具体做）（比如客户和订单表）
       *  在一个页面中显示客户信息，在客户信息中有一个超级连接，点击超级连接
           在另外一个页面中显示该客户的订单的信息
           *  后台:"from Customer"
              因为一对多集合默认的加载模式是懒加载，所以在执行上述hql语句时
              并没有加载客户的订单，这样在第一个页面只能加载客户信息
           *  当点击超级连接的时候，后台"from Order o where o.customer.cid=?"
              利用这样的hql语句就能够加载订单信息
       *  在一个页面中显示客户信息也显示客户的订单信息
           采用迫切左外连接，只发出一条SQL语句
       *  三张表(一对多、多对多)可以采用三张表迫切左外连接的方式来做
       *  如果是多张表，而且页面上的字段和数据库的字段相差太多，那就要新建一个javabean了


比较特殊，用户需要关联部门、岗位两张表。用户表是中间表。

```
    //原来直接调dao的 getAllEntry() 也是可以的
	return this.userDao.getAllEntry();
```

然后页面
```
<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer" datakey="userList">
        	<s:iterator>
	            <tr class="TableDetail1 template">
	            	<td><input type="checkbox" name="userCheckBox"/></td>
	                <td><s:property value="username"/></td>
	                <td><s:property value="department.dname"/></td>
	                <td>
						<s:iterator value="posts">
							<s:property value="pname"/>
						</s:iterator>
					</td>
	                <td>
	                	<s:a action="userAction_delete?uid=%{uid}">删除</s:a>
	                    <s:a action="userAction_updateUI?uid=%{uid}">修改</s:a>
						<s:a>设置权限</s:a>
	                </td>
	            </tr>
            </s:iterator>
        </tbody>
```

上面那个 dname,pname 什么时候加载的？ 迭代的时候才加载吧。
如果把opensessioninview关掉的话，全都不行了。


优化：

```java
    //这里另外弄了这个getUsers(),使用迫切左外连接，这样能减少sql语句！！！没有用BaseDao的getEntry方法。。
    //返回值用Collection的话，又能用 List，又能用 Set
	public Collection<User> getUsers() {
		//放到list能够去重！！！！！！！！！！
		List<User> useList = (List<User>) this.hibernateTemplate.find("from User u left join fetch u.department d left join fetch u.posts p");
		return new HashSet<User>(useList);
	}
```



### 2.10 用户添加


提交确认，写js都是一步一步来写的，看选择某个元素选不选的到
```
$().ready(function(){
	$("input[type='image']").unbind("click");
	$("input[type='image']").bind("click",function(){

		if($("select[name='did'] option:selected").attr("value")==""){
			alert("请选择部门");
			return false;
		}
		else {
			if(!$("select[name='pids'] option:selected").attr("value")==""){
				alert("请选择岗位");
				return false;
			}
			return true;
		}
	});
});
```

```
//用属性驱动取得 user用户页面的部门和岗位数据。
private Long did;
private Long[] pids;

public String addUI(){
    /**
     * 1、把部门表的所有的数据查询出来
     * 2、把岗位表的数据查询出来
     * 3、跳转到增加页面
     */
    Collection<Department> departmentList = departmentService.getAllDepartment();
    ActionContext.getContext().put("departmentList", departmentList);
    Collection<Post> postList = postService.getAllPost();
    ActionContext.getContext().put("postList", postList);
    return addUI;
}

//add.jsp提交用js实现选择的确认，提交到这里add().    
public String add(){
    /**
     * 如何获取页面中的数据
     *  如果页面中的数据来源于一张表，直接用模型驱动获取就可以了
     *  如果页面中的数据来源于多张表，则可以采用模型驱动结合属性驱动的方式
           * 或者可以弄个VO（包含did pids），但是VO无法满足service层的需求，要转成BO (business Object)
     */
    /**
     * 1、创建一个user对象
     * 2、把模型驱动的值赋值给user对象
     * 3、根据did提取出该部门
     * 4、根据pids提取出岗位,,在PostDaoImpl要建个getposts取得多个岗位的方法。
     * 5、建立user对象和部门和岗位之间的关系，user来维护关系
     * 6、执行save操作
     */
    User user = new User();
    //一般属性的赋值
    BeanUtils.copyProperties(this.getModel(), user);
    //建立user与department之间的关系
    Department department = this.departmentService.getDepartmentById(this.did);
    user.setDepartment(department);
    //建立user与posts之间的关系
    Set<Post> posts = this.postService.getPostsByIds(this.pids);
    user.setPosts(posts);
    this.userService.saveUser(user);
    return action2action;
}
```

怎么页面传的 did 和 pids 是String的，这用Long就接受了？
查看MultiSelectIntercepter
发现对于多选的参数名，有先添加了 __multiselect_ 前缀，有个前缀的就转换。



## 3. js相关

### 3.1 全选插件
非全局插件
```
(function(jQuery){
	$.fn.controlCheckBox = (function(checkname){		
		if($(this).attr("checked")){
		    //name='"+checkname+"' 中 checkname 不是具体的，通过调用时传进来，这样才能实现重用
			$("input[name='"+checkname+"']").attr("checked",true);
		}else{
			$("input[name='"+checkname+"']").attr("checked",false);
		}
	})
})(jQuery);
```

name='"+checkname+"' 中 checkname 不是具体的，这样才能实现重用
而是在调用的时候传递 要选择的checkbox过去

```
//调用jquery-checkbox.js
$().ready(function(){
	
	$("input[name='allCheck']").unbind("click");
	$("input[name='allCheck']").bind("click",function(){
		$(this).controlCheckBox("userCheckBox");
	});

});
```

### 3.2 点击事件加载树
这两天要多熟悉这些js的写法，一遍不会两遍，两遍不会三边。

加载树：
   *  一次性全部加载
       *  和数据库只交互一次
       *  会把大量的数据加载到内存中
   *  点击事件加载
       *  和数据库交互很多次
       *  按照需求加载数据

#### 一次性加载树
*  页面上导入三个文件
   *  zTreeStyle.css
   *  jQuery-1.4.2.js
   *  jquery-ztree.2.5.js
*  在页面上准备树的容器
```
       <ul id="tree" class="tree" style="width:230px; overflow:auto;"></ul>
```
*  写js代码
```
        $("#tree").zTree(setting,nodes);  选择树的容器创建树
```

```js
loadTree: function(){				//这个是一次加载加载树
        $.post("menuitemAction_getAllMenuitem.action", 
        		null, 
        		function(data){
        			$("#tree").zTree(tree.setting, data.menuitemList);
                }
              );
    }
````

#### 点击事件加载树
*  导入三个文件
*  在jsp页面上准备树的容器
*  加载树的根节点，写loadRootNode方法
说明
   *  因为后面要加载其节点的子节点，要用到tree.zTree属性，所以只要在tree对象中设置一个属性
      那么只要在该json对象中，tree.zTree都能访问
   *  在其他地方使用tree.zTree时，一定要确保tree.zTree有值了才能使用，因为上面执行的是异步加载
*  点击根节点，触发该节点的+号 expand 事件，在setting里面写
*  加载根节点的子节点，写loadNodeByPNODE方法

```js
/**
 * 点击事件加载
 *   * 第一步： 加载根节点
 *   * 第二步： 点击该节点的+号，触发事件，加载该节点的子节点
 */
var tree = {
	zTree:'',	//tips: js就不要var 那么多全局变量来传参数了，不然会很慢的。像这样弄个json里的参数就能给json里面的函数用了
	pNode:'',	
    setting:{
        isSimpleData: true,
        treeNodeKey: "mid",
        treeNodeParentKey: "pid",
        showLine: true,
        root: {
            isRoot: true,
            nodes: []
        },
        callback:{	//怎么知道人家这么写呢，find jquery-ztree-2.5.js源码啊,,  点击加号触发expand事件
        	 /**
             * @param {Object} event    鼠标事件
             * @param {Object} treeId   树的容器ID
             * @param {Object} treeNode 当前点击的节点
             */
        	 //根据父节点加载子节点，查出子节点追加到父节点上
        	expand:function(event,treeId,treeNode){    //treeNode就是当前点击的节点，debug就知道了
        		//alert("aa");
        		tree.pNode = treeNode;			//定义一个pNode 来传递参数，，可不要tree.loadNodeByPNODE(treeNODE);这样愚蠢的传
                tree.loadNodeByPNODE();			//加载子节点
        	}
        }
    },
    loadTree: function(){				//这个是一次加载加载树
        $.post("menuitemAction_getAllMenuitem.action", 
        		null, 
        		function(data){
        			$("#tree").zTree(tree.setting, data.menuitemList);
                }
              );
    },
    loadRootNode: function(){
        var parameter = {
            pid: 0
        };
        $.post("menuitemAction_showMenuitemsByPid.action", parameter, function(data){	//这function事件(回调函数)由服务器触发，，回调函数异步执行
       
        	tree.zTree = $("#tree").zTree(tree.setting, data.menuitemList);
        });
    },
    loadNodeByPNODE: function(){    //根据父节点加载子节点
        var parameter = {
            pid: tree.pNode.mid
        };
        if (!tree.zTree.getNodeByParam("pid", tree.pNode.mid)) {  //判断当前点击的节点是否有子节点，没就加载
        	
            $.post("menuitemAction_showMenuitemsByPid.action", parameter, function(data){
              //把查询出来的子节点追加到父节点上,为什么会知道用下面这个方法？去查api啊你妹的。
              tree.zTree.addNodes(tree.pNode, data.menuitemList, true);
            });
            /* tips:这个变量tree.zTree用的时候，你他妈怎么知道它已经被赋值了呢?
             * loadNodeByPNode该方法是在点击父节点的+号的时候执行的，这就意味着在执行该方法的时候，
             * 树早已经生成了,tree.zTree = $("#tree").zTree(tree.setting, data.menuitemList);所以才能用tree.zTree;
            */
        //}
    }
};

/**
 * 1、回调函数是由服务器端触发的，什么时候执行由服务器决定
 * 2、回调函数是由jQuery内核调用的
 * 3、客户端存在两个线程
 * 4、如果在js代码中，有一些代码要用到回调函数中的数据，那么这些代码必须放在回调函数中
 */
$().ready(function(){
    //一次加载树
	//tree.loadTree();

    //点击事件加载树
	tree.loadRootNode();
	//tree.loadNodeByPNODE();   
});
```

* 关于expand事件的思考：

ztree这个插件在开发的时候，它是不知道你点击的时候要干嘛的，
谁用ztree开发谁才清楚，
我现在要写 点击父节点然后加载父节点的子节点 的功能函数，
我写完这个功能函数后 ztree内核来调用，所以这个函数应该是回调函数。
凡是jquery插件，它自定义的事件都是回调函数。回调函数又涉及到自定义事件（先声明事件）和什么时候触发。
那这回调函数，我写在哪里呢？实际上你写熟了，肯定在一个json格式的对象上，以参数的形式传递进去。
看zTree的API，传递参数无非就是settings和zTreeNodes，而zTreeNodes代表的是数据，所以要去setting里找。

![](https://images2018.cnblogs.com/blog/659358/201809/659358-20180909095452808-596521372.png)

然后到setting里面找callback。不就有expand函数了吗。

![](https://images2018.cnblogs.com/blog/659358/201809/659358-20180909095647199-1134013482.png)

如果API给的不全，不知道expand函数里面怎么写的话，你就到内核里面jquery-ztree.js去找，写了内部肯定要调用，
所以搜一下callback就行啦，照着来写就行啦。所以一定要有招啊，你可别没招啊。
还有上面的往父节点追加子节点也去API查方法啊。

![](https://images2018.cnblogs.com/blog/659358/201809/659358-20180909100242153-903206779.png)


* 关于怎么传参的思考：

js定的全局变量越多，效率越低。全局变量是在浏览器关闭才消失的。
所以上面在json中定义 zTree，pNode 参数就能给json里面的函数用了。

获得的树赋给zTree
```
tree.zTree = $("#tree").zTree(tree.setting, data.menuitemList);
```

定义一个 pNode 来传递参数，json里面的函数都可以用，可不要tree.loadNodeByPNODE(treeNODE);这样愚蠢的传
```
expand:function(event,treeId,treeNode){    //treeNode就是当前点击的节点，debug就知道了
    tree.pNode = treeNode;			
    tree.loadNodeByPNODE();			//加载子节点
}
```
       	
* 关于回调函数中 变量的赋值的思考

两年经验认识到可能造成的错误：
一般情况下，如果一段代码中要用到某个变量，
而这个变量是在回调函数里赋值的，一定要确保执行你的代码时，回调函数已经执行了。
（比如tree.zTree，下面的loadNodeByPNODE里的addNodes要tree.zTree来调，不能保证执行addNodes时，tree.zTree有值了），
因为后面要加载其节点的子节点，要用到tree.zTree属性，所以只要在tree对象中设置一个属性
那么只要在该json对象中，tree.zTree都能访问

我们上面那样写没有问题的，因为
expand方法是在点击父节点的+号的时候执行的，这就意味着在执行该方法的时候，树早已经生成了。
所以loadNodeByPNODE才能用tree.zTree

如果这样写
```
loadRootNode();
alert(tree.zTree);
```
那么alert应该拿不到tree.zTree，人家loadRootNode里面建树的回调应该还没好。

```js
var a = 5;
$.post(url, para, function(){    
});
$.post(url, para, function(){    
});
$.post(url, para, function(){    
});
//会开三个线程来执行的。传变量的时候就才特别小心。
```

### 3.3 设置权限的需求分析：
功能是由事件带出来的，所以写js的时候别盲目！

从功能上分析
*  显示隐藏的div
*  动态的显示用户名称
*  全选复选框的功能
*  保存功能（建立用户和菜单之间的关系）
*  权限的回显
*  权限树的复选框的规则

从事件上进行分析
*  设置权限的超级连接的点击事件
*  全选复选框的点击事件
*  保存事件

从传递数据角度进行分析
*  根据需求分析，需要传递的数据有uid,username,mids

js的写法
*  在init方法中要初始化事件和数据，因为事件和数据是两个因素，所以可以把init当成一个json格式的对象
```js
init:{      //该json格式的对象写初始化的操作
initEvent:function(){

},
initData:function(){

}
}
```

*  根据功能规定区域，将操作归类
```js
privilegeTree:{       //在这里包含了整个树的所有的操作
    //写各个函数
    checkAll:function(){
    
    },
    controlCheckBox:function(){
    
    },
    savePrivilege:function(){
    
    }
},
userOption:{        //用户显示的操作
    //写各个函数
    showUsername:function(){
    
    },
    showDiv:function(){
    
    }
}
```

*  数据的面向对象的封装
```js
  user:{
      uid:'',
      username:''
  }
```


privilege.js构造：

```js
var privilege = {
	/**
	 * 所有的初始化的操作
	 */
	init:{
		/**
		 * 所有的初始化的事件
		 */
		initEvent:function(){
			
		},
		/**
		 * 初始化数据
		 */
		initData:function(){
			
		}	
	},
	/**
	 * 按照功能划分区域
	 */
	pFunction:{
		privilegeTree:{//所有的权限树的操作
			
		},
		userOption:{//存放用户的操作
			
		},
		divOption:{//显示div的操作
			
		}
	},
	/*
	 * json对象对数据的封装
	 */
	data:{//所有的数据的封装
		user:{//存放用户的数据
			uid:'',
			username:''
		}
	}
};

$().ready(function(){
    privilege.init.initEvent();
});
```

privilege.js：
```js
var privilege = {
	/**
	 * 所有的初始化的操作
	 */
	init:{
		/**
		 * 所有的初始化的事件
		 */
		initEvent:function(){
			/**
			 * 设置权限的click事件
			 */
			$("a").each(function(){
				if($(this).text()=="设置权限"){
					$(this).unbind("click");
					$(this).bind("click",function(){
						/**
						 * 1、显示所有的div
						 * 2、动态的显示用户名
						 * 3、加载权限树
						 */
						privilege.pFunction.divOption.showDiv();//显示所有的div
						privilege.pFunction.userOption.showUsername();//动态的显示用户名
						privilege.pFunction.privilegeTree.loadPrivilegeTree();//加载权限树
					});
				}
			});
			/**
			 * 全选按钮的事件
			 */
			$("#allchecked").unbind("click");
			$("#allchecked").bind("click",function(){
				privilege.pFunction.privilegeTree.checkAll();
			});
			/**
			 * 保存权限的事件
			 */
			$("#savePrivilege").unbind("click");
			$("#savePrivilege").bind("click",function(){
				privilege.pFunction.privilegeTree.savePrivilege();
			});
		},
		/**
		 * 初始化数据
		 */
		initData:function(){
			
		}	
	},
	/**
	 * 按照功能划分区域
	 */
	pFunction:{
		privilegeTree:{//所有的权限树的操作
			/**
			 * 显示权限树
			 */
			loadPrivilegeTree:function(){
				
			},
			/**
			 * 对权限树的复选框的控制
			 */
			controlCheckBox:function(){
				
			},
			/**
			 * 针对某一用户保存权限
			 */
			savePrivilege:function(){
				
			},
			/**
			 * 全选复选框的实现
			 */
			checkAll:function(){
				
			}
		},
		userOption:{//存放用户的操作
			showUsername:function(){//把用户名动态的显示到相应的div中
				
			}
		},
		divOption:{//显示div的操作
			showDiv:function(){
				
			}
		}
	},
	/*
	 * json对象对数据的封装
	 */
	data:{//所有的数据的封装
		user:{//存放用户的数据
			uid:'',
			username:''
		}
	}
};

$().ready(function(){
    privilege.init.initEvent();
});
```
以上结构可是模仿优秀框架来弄的！！！！！！！！！学会了这个ext那些就so easy了，无非就先来个构造器函数，然后handler就事件

*  初始化数据
根据点击的this这个“设置权限”标签，传过来 initData()，可以得到其上级的兄弟标签有 username uid（设置隐藏域）。
this这个“设置权限”标签，怎么传给 initData()呢？？

方案一：通过给 initData()加一个参数， 调用
```
var hobj = this;
initData(obj);
```
然后initData里面就可以直接用obj了。
```
var username = $(hobj).parent().siblings("td:first").text();
var uid = $(hobj).parent().siblings("input[type='hidden']:first").val();
```

方案二：
不要加参数了，那样多low啊，前面做树的时候已经说过了。
太牛了！！！通过call来改变了initData的调用对象。
initData的调用者就是当前的对象，调用：
```
privilege.init.initData.call(this);
```                  
然后initData里面就可以直接用this了。
```
initData: function(){
   var username = $(this).parent().siblings("td:first").text();
   var uid = $(this).parent().siblings("input[type='hidden']:first").val();
   privilege.data.user.username = username;
   privilege.data.user.uid = uid;
}
```

* 显示所有的div
```js
divOption : {
    showDiv : function () {
        $("#userTitle").show();
        $("#privilegeTitle").show();
        $("#privilegeContent").show();

    }
}
```

* 动态显示用户名
用前面得到的username来
```js
userOption : {
    showUsername : function () {
        $("#userImage").text(privilege.data.user.username);
    }
}
```

* 加载权限树

权限树需要权限目录数据，通过PrivilegeAction获取数据getMenuItemByUid();
然后就是加载一棵树了
```js
loadPrivilegeTree : function(){
    var parameter =  {
        "uid" : privilege.data.user.uid
    };
    $.post("privilegeAction_showPrivilege.action", parameter, function (data) {
        privilege.pFunction.privilegeTree.zTree = $("#privilegeTree").zTree(privilege.pFunction.privilegeTree.setting, data.privilegeList);
        /**
         * 这里是设置全选按钮默认状态的最佳位置
         *  默认值必须在点击设置权限的超级链接中设置
         *  确保zTree必须有值
         */
    });
}
```
* 全选复选的事件
先在initEvent里面添加监听
```js
/**
 * 全选按钮的事件
 */
$("#allchecked").unbind("click");
$("#allchecked").bind("click", function(){
    privilege.pFunction.privilegeTree.checkAll.call(this);  //就变成现在点击的#allchecked来调用checkAll方法。
});
```
然后写checkAll方法。
```js
chckeAll : function () {
    /**
     * 改变树上的复选框的选中规则
     在执行该函数的时候，zTree已经存在了
     */
    /**
     * 改变zTree中复选框的规则
     */
    privilege.pFunction.privilegeTree.controlCheckBox({
        "Y":"ps",
        "N":"ps"
    });
    if ($(this).attr("checked")) {//全选
        privilege.pFunction.privilegeTree.zTree.checkAllNodes(true);
    }
    else {//全不选
        privilege.pFunction.privilegeTree.zTree.checkAllNodes(false);
    }
}
```


*  保存权限
```js
savePrivilege : function () {
    var checkedNodes = privilege.pFunction.privilegeTree.zTree.getCheckedNodes(true);
    var mids = "";
    for(var i=0;i<checkedNodes.length;i++){
        if(i<checkedNodes.length-1){
            mids = mids+checkedNodes[i].mid+",";
        }else{
            mids = mids+checkedNodes[i].mid;
        }
    }
    var parameter = {
        uid:privilege.data.user.uid,
        mids:mids
    };
    $.post("privilegeAction_savePrivilege.action", parameter, function () {
        alert("保存成功");
    });
}
```
因为是有User来维护的，
所以后台是先得到了要保存权限菜单，然后让User更新，
将User和权限菜单的关系保存到user_menuitem表。
```java
/**
 * 保存某一个用户的权限
 * @returnjava
 */
public String savePrivilege(){
    Set<Menuitem> menuitems = menuitemService.getMenuitemsByIDS(OAUtils.string2Longs(mids));
    User user = userService.getUserById(uid);
    user.setMenuitems(menuitems);
    this.userService.updateUser(user);
    return SUCCESS;
}
```

这个点击保存权限报JSONException！！！


### 3.4 struts2与ajax的整合

struts2与ajax的整合中
前台页面上向后台传递数据有两种形式：
* form表单通过 $("form").serialize();用这种方法可以将form表单中的数据提交，后台可以直接获取。可以获取数组。

```js
$().ready(function(){
    var parameter =  $("form").serialize();
    $.ajax({
        type : "POST",
        data : parameter,
        url : "Aaction.action",
        success : function() {
          
        }
    });
    
});
```

*  在js代码中，形成一个js格式的对象，该对象要传递到后台
这种有数组的给ajax传是不行的：
var parameter = {
    mids : mids,
    aa : [5,6,7]
}
可以自己写个解析的将上面的弄成标准json自符串。
var parameter = "{
    'mids' : mids,
    'aa' : [5,6,7]
}";
有了下面这个，就可以 var para = $.toJSON(parameter);

```js
jQuery.extend({  
   toJSON: function(object) {             //这程序有个问题啊，传过来的object是null就报错了
     var type = typeof object; 
     if ('object' == type) { 
	   if(object){
	   		if (Array == object.constructor) type = 'array'; 
       			else if (RegExp == object.constructor) type = 'regexp'; 
       			else type = 'object';
	   		} 
     	} 
     switch (type) { 
     case 'undefined': 
     case 'unknown': 
       return; 
       break; 
     case 'function': 
     case 'boolean': 
     case 'regexp': 
       return object.toString(); 
       break; 
     case 'number': 
       return isFinite(object) ? object.toString() : 'null'; 
       break; 
     case 'string': 
       return '\'' + object.replace(/(\\|\")/g, "\\$1").replace(/\n|\r|\t/g, function() { 
         var a = arguments[0]; 
         return (a == '\n') ? '\\n': (a == '\r') ? '\\r': (a == '\t') ? '\\t': "" 
       }) + '\''; 
       break; 
     case 'object': 
       if (object === null) return 'null'; 
       var results = []; 
       for (var property in object) { 
         var value = jQuery.toJSON(object[property]); 
         if (value !== undefined) results.push(jQuery.toJSON(property) + ':' + value); 
       } 
       return '{' + results.join(',') + '}'; 
       break; 
     case 'array': 
       var results = []; 
       for (var i = 0; i < object.length; i++) { 
         var value = jQuery.toJSON(object[i]); 
         if (value !== undefined) results.push(value); 
       } 
       return '[' + results.join(',') + ']'; 
       break; 
     } 
   } 
});
```

   
后台往前台回调数据
   在关联对象的查询中，一般情况下不加载关联对象，在该对象的get方法上写@JSON(serialize=false)

另外ajax遵循的不是http协议，通过ajax发出的url，拿到浏览器上面请求是不行的。

### 3.5 zTree的内核
   *  结构
(function($){        //()(); 匿名函数
   //常量部分
   //申明常量是因为这些数据是不能改变的（保证唯一性），如果成了对象的属性，很容易就改变了
   var ZTREE_NODECREATED = "ZTREE_NODECREATED";
   var ZTREE_CLICK = "ZTREE_CLICK";
   var ZTREE_RIGHTCLICK = "ZTREE_RIGHTCLICK";
   //插件方法。  提供给外部访问的方法，我只要$("#tree").zTree(setting,data);就建好一个树了。
   $.fn.zTree = function(zTreeSetting, zTreeNodes) {
        //声明一个setting
        var setting = {
            showLine: true,
            checkType: {
                 "Y": "ps",
                 "N": "ps"
            }
            .......
        };
       //判断是否传递了第一个参数
       if(zTreeSetting){
           //把用户的setting替换掉原来的setting的值！！！
           $.extend(setting, zTreeSetting);
       }
       //获取树的容器ID
       setting.treeObjId = this.attr("id");
       //树的容器
       setting.treeObj = this;
       //绑定自定义事件
       bindTreeNodes(setting, this);
       // ())();  匿名函数内的方法是私有的，就想了下面这办法来公开API。
       //通过在zTreePlugin函数中返回一个json格式的对象，而这个对象中封装被公开的方法(API)
       //因为是在zTree方法中返回的时候new了zTreePlugin()，所以在客户端不需要知道zTreePlugin的细节
       //相当于java中的工厂模式吧
       return new zTreePlugin().init(this);
   }
   //私有方法
   function bindTreeNodes(setting, treeObj) {
       //事件的声明，看到这些事件都绑定在树的容器中treeObj。他都把所有事件集中在一个方法里了，都没json格式，差评。
       treeObj.unbind(ZTREE_CLICK);  
       treeObj.bind(ZTREE_CLICK, function (event, treeId, treeNode) {
            if ((typeof setting.callback.click) == "function") setting.callback.click(event, treeId, treeNode);   //这里调callback.click(event, treeId, treeNode)就是回调函数，插件内部调的
            //后面会这样通过trigger 触发click事件 setting.treeObj.trigger(ZTREE_CLICK, [setting.treeObjId, treeNode]);
       });
   }
   function zTreePlugin(){
        return {
             init: function(obj) {
                this.container = obj;
                this.setting = settings[obj.attr("id")];
                return this;
             },
             getSelectedNode : function() {
                return this.setting.curTreeNode;
             }
             ......
        };
   }
   //私有方法和公开方法的界限：只要在zTreePlugin返回值的json格式中写的方法就是API，没有写就是私有的方法
})(jQuery);

*  结构总结：
*  常量部分
*  插件方法
   初始化数据
   绑定事件
   调用其他的方法
   公开API
*  公开API的方法
*  私有的方法
什么是学程序的状态啊？，是听到这些应该感到兴奋。。
一个哥门人家在那个电力行业10年了，一套东西全会，特抢手。

## 4. 知识管理
特色：利用ajax技术实现无刷新实现树的管理
需求分析：
*  对知识管理树进行维护
 *  右键菜单的显示
     *  如果点击的是文件节点
          右键菜单应该显示：删除和修改
     *  如果点击的是文件夹节点
          右键菜单应该显示：增加、删除、修改
 *  增
     *  向kynamic表中添加一行数据
     *  在kynamic树的相应的父节点上增加一个子节点
 *  删
     *  如果删除是文件节点，则直接删除
     *  如果删除的是文件夹节点，则先查看一下该文件夹下是否存在子节点
         *  如果存在，则提示不能删除
         *  如果不存在，则删除
 *  修改
*  版本的维护
 每一个知识管理树的节点会产生很多版本，要对版本进行维护
               
根据以上需求先得到 domain对象 Kynamic.javah和Version.java，然后写Dao到Action。

点击知识管理要先跳转到forward.action，然后转到kynamic.jsp。
通过jsp加载js，js里面的ajax才能加载树。

然后我构造树的时候还出错：
后台传回来一个kynamicList，我居然直接写zTree(kynamic.kynamicTree.setting, data)。
```
loadKynamicTree : function () {
    $.post("kynamicAction_showKynamicTree.action", null, function (data) {
        kynamic.ztree = $("#kynamicTree").zTree(kynamic.kynamicTree.setting, data.kynamicList);
    });

}
```

### 右键菜单的实现
js中触发事件两种方式：
1. 通过浏览器内置的事件来触发自己的事件；我的自定义事件触发(trigger)就写在浏览器内置的事件里面。
2. 在程序的任何地方都能触发。

右击事件contextmenu是浏览器内置的事件，看ztree的源码发现，它是通过第一种方式来触发自己的rightClick事件。
```js
//ztree绑定了右击事件contextmenu，然后执行ztree自定义的右击事件。
setting.treeObj.bind('contextmenu',
			function(event) {
	//触发rightClick事件
    if (doRight && (typeof setting.callback.rightClick) == "function") {
        setting.callback.rightClick(event, setting.treeObjId, treeNode);
        return false;
    }
```
 
 
直接撸了下简单的绑定右击事件，直接在项目里加一个test.html，然后就可以访问了http://localhost:8080/test.html。
```html
<html>
<TITLE>知识管理</TITLE>
<head></head>
<script language="JavaScript">
    window.onload = function() {
      document.getElementById("mydiv").oncontextmenu = function() {
        alert("右击了")
      }
    }
</script>
<body>
    <div id="mydiv">菜单</div>
</body>
</html>

```

右击显示出菜单项，然后菜单要显示在对应的位置。
不知道怎么写？
可以去ztree的demo html里面找前端怎么写，js怎么写！！。
demo里说明了html的菜单样式要设成 style="position:absolute; 让位置绝对。不然我怎么知道。

callback里面写右击事件：
```
rightClick : function(event, treeId, treeNode){
    //判断点击的是文件夹节点还是文件节点
    if(treeNode.isParent){
        kynamic.kynamicTree.controlRMenu({
            //把业务需求的变化用json数据封装起来了，页面不管是什么button的右击事件都这样传。
            x : event.clientX,  
            y : event.clientY,
            addFloder : true,
            addNode : true,
            updateNode : true,
            deleteNode : true
        });
    }else{
        kynamic.kynamicTree.controlRMenu({
            x:event.clientX,
            y:event.clientY,
            addNode:true,
            addFloder:false,
            deleteNode:true,
            updateNode:true
        });
    }
}
```
然后具体实现对菜单项的显示逻辑：
```js
/**
 * 控制右键菜单的显示
   div的位置
   右键菜单的菜单项
 */
controlRMenu : function (menuJson) {
    //菜单项的显示逻辑
    $("#showRMenu").show();
    $("#rMenu").css({"top": menuJson.y+"px", "left": menuJson.x+"px", "display":"block"});
    if(menuJson.addFloder){
        $("#addFloder").show();
    }else{
        $("#addFloder").hide();
    }
    if(rMenuJson.addNode){
        $("#addNode").show();
    }else{
        $("#addNode").hide();
    }
    if(rMenuJson.deleteNode){
        $("#deleteNode").show();
    }else{
        $("#deleteNode").hide();
    }

    if(rMenuJson.updateNode){
        $("#updateNode").show();
    }else{
        $("#updateNode").hide();
    }
}
```

但是右击后 菜单不会消失啊，一直在那里！场面很尴尬啊！！
这个就要通过 hover 来解决了！！！！！
通过 hover 来实现 当鼠标移动到一个匹配的元素上面时，会触发指定的第一个函数。当鼠标移出这个元素时，会触发指定的第二个函数。

想想这个hover要加在哪里？？？？

居然写到了初始化加载的时候：
```js
$().ready(function () {
	kynamic.kynamicTree.loadKynamicTree();
	////hover在这里仅仅是用于声明事件，事件函数中的内容到底是否执行，根据触发的时候判断
    $("#rMenu").hover(function({
    
    }), function() {
      
    });
});
```

我想：但是这个hover方法在不能确保树已经出来了啊，那后面的就没法玩了吧？
没问题的，因为：
一个方法需要声明需要调用。
一个事件函数，则是什么时候触发，什么时候执行。
这就是一个方法和一个事件函数的本质区别。

触发的时候能保证右键菜单出来了就行了。而且这是移出的时候触发的，这时树早就已经加载出来了。
hover在这里仅仅是用于声明事件，事件函数中的内容到底是否执行，是根据触发的时候判断。


### 实现右键菜单里的增删改查

实现之前要想这些右键菜单事件要在哪里声明，触发？？

没错，触发就写在上面的hover的第一个函数里面。
```js
$().ready(function(){
    kynamic.kynamicTree.loadKynamicTree();
    //鼠标移出右键菜单，菜单消失
    $("#rMenu").hover(function(){			//hover在这里仅仅是用于声明事件，事件函数中的内容到底是否执行，根据触发的时候判断
        //声明右键菜单functiono，增删改查
        $("#addFile").unbind("click");
        $("#addFile").bind("click",function(){
            //alert("addNode")
            kynamic.kynamicTree.addFile();
        });

        $("#addFloder").unbind("click");
        $("#addFloder").bind("click",function(){
            //alert("addFloder")
            kynamic.kynamicTree.addFloder();
        });

        $("#updateNode").unbind("click");
        $("#updateNode").bind("click",function(){
            //alert("updateNode")
            kynamic.kynamicTree.updateNode();
        });

        $("#deleteNode").unbind("click");
        $("#deleteNode").bind("click",function(){
            //alert("deleteNode")
            kynamic.kynamicTree.deleteNode();
        });

    },function(){
        //当该方法被触发的时候，树早已经存在了，右键菜单已经显示了！！！
        $("#rMenu").hide();
    });

});
```


还要注意的几个点是
1. 重名的判断
2. 由于删除了没有兄弟节点的节点后，其父节点会变成文件节点，所以要先判断是否有兄弟节点。这整个保持父节点的功能其实可以通过ztree的keepParent来弄，但那样太简单了吧，锻炼不了人。
3. 定义个 pNode:'' 全局变量！！来保存当前选中的ztree节点。在右击回调的时候传入值。
4. addNoode(addJson)的参数用json格式传入
```
addFile : function () {
    kynamic.kynamicTree.addNode({
        fileMessage: '请输入文件的名称',
        errorMessage: '文件的名称不能为空',
        isParent: false
    });
}
```


没有弄好的地方：
1. 添加版本Kynamic.action的saveVersionBykid()，如果并发的话肯定不行的。要用redis吗?


如果这个项目你觉得很easy，那说明你的水平是这样吧。。没什么长进啊。


### 版本列表显示，异步回调函数的形参作用域问题

callback添加click事件啊!!!!
```js
click : function (event, treeId, treeNode) {
kynamic.kynamicTree.pNode = treeNode;
    var parameter = {
        kid : kynamic.kynamicTree.pNode.kid
    }
    $.post("kynamicAction_showVersionsByKid.action", parameter, function(data) {
    
        if (data.versionList.length == 0) {//没有版本
            alert("没有版本");
        }else {
            //控制div和checkin和checkout按钮的显示，所以又是传json来做控制  !!!
            kynamic.version.controlShowVersion({        //太强了
                addVersion: false,
                versionList: true,
                checkin: false,
                checkout: false
            });
            kynamic.version.showVersionsByKid(data.versionList);
        }
    });
}
```

显示出版本的列表来，通过 showVersionsByKid 方法，下面看看其实现：
显示version列表，列表要自己拼接。

```js
showVersionsByKid:function(versionList){	
    /**拼接出以下  一行三列
     <tr>
     <td height="26" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:1px solid #f3f8fd;"><a>1</a></td>
     <td align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:1px solid #f3f8fd;">2010-5-24 09:56:33</td>
     <td align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:1px solid #f3f8fd;"><a>删除</a></td>
     </tr>
     */

    $("#showVersion").empty();   //把上次加载的版本列表清空
    for(var i=0; i<versionList.length; i++){
        
        var version = versionList[i].version;
        var updatetime = versionList[i].updatetime;
        var $versionA = $("<a/>");
        $versionA.text(version);
        $versionA.css("cursor", "pointer");

        $versionA.unbind("click");
        $versionA.bind("click", function(){
            alert(versionList[i].version);
            alert(version);
            //alert($(this).attr("version"));
        });

        var $versionTD = $("<td/>");
        $versionTD.attr("height", "26");
        $versionTD.attr("align", "center");
        $versionTD.attr("valign", "middle");
        $versionTD.attr("bgcolor", "#FFFFFF");
        $versionTD.attr("style", "border-bottom:1px solid #f3f8fd;");
        $versionTD.append($versionA);

        var $updatetimeTD = $("<td/>");
        $updatetimeTD.attr("align", "center");
        $updatetimeTD.attr("valign", "middle");
        $updatetimeTD.attr("bgcolor", "#FFFFFF");
        $updatetimeTD.attr("style", "border-bottom:1px solid #f3f8fd;");
        $updatetimeTD.text(updatetime);

        var $A = $("<a/>");
        $A.text("删除");
        var $delTD = $("<td/>");
        $delTD.attr("align", "center");
        $delTD.attr("valign", "middle");
        $delTD.attr("bgcolor", "#FFFFFF");
        $delTD.attr("style", "border-bottom:1px solid #f3f8fd;");
        $delTD.append($A);

        var $TR = $("<tr/>");
        $TR.append($versionTD);
        $TR.append($updatetimeTD);
        $TR.append($delTD);
        $("#showVersion").append($TR);

    }

}
```

有个不行的现象：
上面的showVersionsByKid方法给每行版本号添加的click事件，
alert(versionList[i].version); 会报错说undefine。
alert(version); 则点每一个版本号都是同一个数字，因为都是第一次存进来的。
为什么呢？？

首先我们看前面 showVersionsByKid方法在ajax的回调函数中被调用：
$.post("kynamicAction_showVersionsByKid.action", parameter, function(data) {
                       
    kynamic.version.showVersionsByKid(data.versionList);
   
});
然后再在showVersionsByKid方法中定义了 click事件，并且要使用了 回调函数 传过来的参数versionList。

但是回调函数是有周期的。当回调函数的声明周期结束后，其形参也就没有了。
然后你单击的时候，触发click事件，上面的ajax回调早结束了。于是
alert(versionList[i].version);  会报错说undefine，因为此时versionList早被回收了。
alert(version);  则点每一个版本号都是同一个数字。

永远记住：一个函数执行有两种情况：
1. 被声明时调用；
2. 事件触发时调用，那这函数中的变量的作用域范围就要考虑了。


解决方法：
1. 方法一：将for循环里面的东西，用匿名函数(function{}).(); 包起来。闭包？
2. 方法二：将versionlist设置进a标签的属性里面。

方法一：
```js
$("#showVersion").empty();   //把上次加载的版本列表清空
for(var i=0; i<versionList.length; i++){

    (function(){
        var version = versionList[i].version;
        var updateTime = versionList[i].updatetime;
        //先拼接<a>
        var $versionA = $("<a/>");
        $versionA.text(version);
        $versionA.css("cursor","pointer");

        $versionA.unbind("click");                      //原来这样啊，给某个按钮加个点击事件
        $versionA.bind("click",function(){
            alert(version);
        });
        //下面三列数据 三个td
        var $versionTD = $("<td/>");
        $versionTD.attr("height","26");
        $versionTD.attr("align","center");
        $versionTD.attr("valign","middle");
        $versionTD.attr("bgcolor","#FFFFFF");
        $versionTD.attr("style","border-bottom:1px solid #f3f8fd;");
        $versionTD.append($versionA);

        var $updateTimeTD = $("<td/>");
        $updateTimeTD.attr("height","26");
        $updateTimeTD.attr("align","center");
        $updateTimeTD.attr("valign","middle");
        $updateTimeTD.attr("bgcolor","#FFFFFF");
        $updateTimeTD.attr("style","border-bottom:1px solid #f3f8fd;");
        $updateTimeTD.append(updateTime);

        var $deleteA = $("<a/>");
        $deleteA.append("删除");
        var $deleteTD = $("<td/>");
        $deleteTD.attr("height","26");
        $deleteTD.attr("align","center");
        $deleteTD.attr("valign","middle");
        $deleteTD.attr("bgcolor","#FFFFFF");
        $deleteTD.attr("style","border-bottom:1px solid #f3f8fd;");
        $deleteTD.append($deleteA);

        var $TR = $("<tr/>");
        $TR.append($versionTD);
        $TR.append($updateTimeTD);
        $TR.append($deleteTD);

        $("#showVersion").append($TR);

    })();
}
```            

方法二：
```js
var version = versionList[i].version;
var updatetime = versionList[i].updatetime;
var $versionA = $("<a/>");
$versionA.text(version);
$versionA.css("cursor", "pointer");
$versionA.attr("version",versionList[i].version);   //!!!!!!!!!!!将versionlist设置进a标签的属性里面。
$versionA.attr("updatetime",updatetime);            //!!!!!!!!!!!

$versionA.unbind("click");
$versionA.bind("click", function(){
    //alert(versionList[i].version);
    //alert(version);
    alert($(this).attr("version"));
});
```                


然后删除版本，点击版本显示具体版本内容就我自己实现了。
用到了前端的之前的知识：
1. 使用call(this)来调用方法，改变了调用方法的主题对象；
2. 使用json格式数据来传递参数；
3. 删除操作就是找 删除标签 的父节点的父节点就是tr标签了，就是那一行数据了，然后remove：$(this).parent().parent().children("td").remove();
4. jquery相关的知识
获取input的值 ：$("input[name='title']").val(); 或者 $("input[name='title']").attr("value");

后端知识：
1. 删除操作在service层要加@Transactional(readonly=false)注解，事务操作。



## 5. jbpm审批流转模块

研究jpbm的表结构才是重点。


流程定义管理
 流程定义：把流程定义文档部署到jbpm中
 查询
    *  查询流程部署
       * 查询所有的流程部署
       * 根据部署ID查询流程部署
    *  查询流程定义
       *  查询所有的流程定义
       *  根据deploymentID查询流程定义
       *  根据pdid查询流程定义
       *  根据pdkey查询流程定义
 删除
 查看流程图


 * 涉及到的表
  *  JBPM4_DEPLOYMENT
     *  部署表，用来描述一次部署
     *  字段说明
        DBID_： 主键、部署ID
        STATE: 状态   active
  *  JBPM4_LOB
     *  仓库表   存放了流程定义文档(xml,png)
     *  字段说明
        DEPLOYMENT_:部署ID  外键
        NAME_:  xml或者png的文件路径
  *  JBPM4_DEPLOYPROP
     *  部署属性表
     *  字段
         DBID_:主键
         OBJNAME_:流程定义名称
         KEY_:
           *  每部署一次，生成4行记录  ！！！！！！！！！
             langid  语言版本  jpdl-4.4
             pdid    {pdkey-version}
             pdkey   流程定义名称
                一般情况下,pdkey和objname_的值是一样的
             pdversion  版本号
                如果pdkey没有发生改变，每部署一次，版本号加1
                如果pdkey发生改变，则是一个全新的名称，所以版本号应该从1开始计算
            


要有热爱这行的心，才走的远。我就是有个好奇心，想研究明白这东西。


## 一些经验

### 1. 一个参数需要在连续的几个页面中用到 或者 要传给后台 ，怎么样传值
*  在页面中设置隐藏域!!!!!!!!!!!!!!
*  利用cookie传值，安全性差

### 2. 返回值用Collection的话，又能用 List，又能用 Set


### 3. 直接写例子
然后直接撸了下绑定右击事件，直接在项目里加一个test.html，然后就可以访问了http://localhost:8080/test.html。
```html
<html>
<TITLE>知识管理</TITLE>
<head></head>
<script language="JavaScript">
    window.onload = function() {
      document.getElementById("mydiv").oncontextmenu = function() {
        alert("右击了")
      }
    }
</script>
<body>
    <div id="mydiv">菜单</div>
</body>
</html>

```

JavaScript 三种绑定事件方式之间的区别 https://www.cnblogs.com/mylove103104/p/4667211.html
1. 像上面那样js动态添加事件。
2. 可以直接在html里面在DOM里绑定事件
```html
<div id="btn" onclick="clickone()"></div> //直接在DOM里绑定事件
　<script>
    　function clickone(){ alert("hello"); }
  </script>
`
```

### 前端经验

整个页面要做无刷新，不能用frameset嵌套（一个大的包含上中下三个，上面一个超级连接，得到的数据放到中间，很难实现）
而是要div嵌套（一个大的包含上中下三个，）


## 因为框架所以不用我们做了的事

### 1.注入简便了
往service里面添加dao时如果没有注解，需要给dao加getset方法的！

## 遇到的问题

### 启动报错Context namespace element 'component-scan'
Context namespace element 'component-scan' and its parser class are only available on ....
因为Spring 2.5不会在比1.7版本更高的Java JDK上运行.对于Java 8及以上的版本，代码会默认在JDK 1.4 的版本上运行，所以会注解会抱怨？

解决方法： 
1. 升级Spring 版本，说是Spring 大于等于3.2.3的版本才可以支持Java 8 
2. 用JDK 1.7

### 启动报错maven项目中 org.hibernate.MappingNotFoundException: resource:**.hbm.xml not found问题的解决方案

原因： hibernate的映射文件*.hbm.xml那些放在了domain包里面。
对于Maven工程，编译的工作是由Maven程序来完成的，
而Maven默认只会把src/main/resources文件夹下的配置文件拷贝到target/classes文件夹下，
所以domain包里的.hbm.xml都不会被复制到/target/calsses文件夹下，
所以Hibernate框架在运行的时候，就会报找不到*.hbm.xml的错误。

解决：将*.hbm.xml移到resource下。

https://blog.csdn.net/kuaisuzhuceh/article/details/44728629

### 启动不了项目，然后晚上就好了
我只记得我下午装了腾讯视频客户端，然后wifi图标那里有感叹号。。

一直报下面的错误，但是我的配置文件都是好的啊。
```
九月 09, 2018 4:46:00 下午 org.apache.catalina.core.ApplicationContext log
信息: No Spring WebApplicationInitializer types detected on classpath
九月 09, 2018 4:46:00 下午 org.apache.catalina.core.ApplicationContext log
信息: Initializing Spring root WebApplicationContext
九月 09, 2018 4:46:01 下午 org.apache.catalina.core.StandardContext listenerStart
严重: Exception sending context initialized event to listener instance of class org.springframework.web.context.ContextLoaderListener
org.springframework.beans.factory.parsing.BeanDefinitionParsingException: Configuration problem: Failed to import bean definitions from relative location [applicationContext-db.xml]
	at org.springframework.beans.factory.parsing.FailFastProblemReporter.error(FailFastProblemReporter.java:68)
	at org.springframework.beans.factory.parsing.ReaderContext.error(ReaderContext.java:85)
	at org.springframework.beans.factory.parsing.ReaderContext.error(ReaderContext.java:76)
	at org.springframework.beans.factory.xml.DefaultBeanDefinitionDocumentReader.importBeanDefinitionResource(DefaultBeanDefinitionDocumentReader.java:282)
九月 09, 2018 4:46:01 下午 org.apache.catalina.core.ApplicationContext log
信息: Closing Spring root WebApplicationContext
九月 09, 2018 4:46:02 下午 org.apache.catalina.core.StandardContext listenerStop
严重: Exception sending context destroyed event to listener instance of class org.springframework.web.context.ContextLoaderListener
java.lang.IllegalStateException: BeanFactory not initialized or already closed - call 'refresh' before accessing beans via the ApplicationContext
	at org.springframework.context.support.AbstractRefreshableApplicationContext.getBeanFactory(AbstractRefreshableApplicationContext.java:171)
	at org.springframework.context.support.AbstractApplicationContext.destroyBeans(AbstractApplicationContext.java:1090)
	at org.springframework.context.support.AbstractApplicationContext.doClose(AbstractApplicationContext.java:1064)
```

### 保存权限报JSONException
点击保存时，这个会报一个异常！！！！！！
异常的产生原因：
当加载一个对象时，struts2内部的处理方案是：除了加载该对象以外，还要加载关联的对象。
Menuitem类里面有User的set 需要关联。   
而加载关联的对象是懒加载，
struts2与ajax结合时，请求时请求页面，但是返回是只返回数据的，
所以opensessioninview模式不起作用了，所以获取不到懒加载的对象。
验证：可以在OpenSessionInViewFilter的doFilterInternal方法打个断点，发现请求的时候会经过，但是response的时候不经过。

解决方案：
```java
  public class Menuitem{
      private Set<User> users;
      @JSON(serialize=false)  //忽略该属性
      public Set<User> getUsers(){
           return users;
      }
  }
```

对于多表的查询，
以前将User放到栈顶，利用struts2的标签就可以关联，你用department.dname时，
人家struts2有自动解析user.getDepartment().getDname()，就得到departmentName了。
还是懒加载的问题。
但是对于的ajax请求需要多表的数据，返回User数据到ajax的回调函数里面，解析过程完全没了。
就拿不到其他关联数据了。
所以对于ajax请求需要多表的数据，最好在Dao层就把多表的数据放到OV里面，返回一起返回。




## 访问地址
admin/admin登录  http://localhost:8080/login.jsp
查看用户   http://localhost:8080/oa/userAction_getAllUser.action
 http://localhost:8080/userAction_getAllUser.action
查看岗位   http://localhost:8080/oa/departmentAction_getAllDepartment.action
http://localhost:8080/departmentAction_getAllDepartment.action
查看岗位   http://localhost:8080/oa/postAction_getAllPost.action
http://localhost:8080/postAction_getAllPost.action

访问树   http://localhost:8080/tree.html

整合的是struts2、spring2.5.5、hibernate3.5.6

部署：
建立oa数据库，然后执行oa.sql；
在项目中填入相关mysql信息；
用jdk7或者jdk8，加tomcat7.0来部署；用tomcat8来部署无法访问页面。


spring3+hibernate4+Activiti6整合
https://blog.csdn.net/luyangbin01/article/details/77414566
