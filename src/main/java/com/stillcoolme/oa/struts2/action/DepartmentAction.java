package com.stillcoolme.oa.struts2.action;

import java.util.Collection;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.stillcoolme.oa.service.DepartmentService;
import com.stillcoolme.oa.struts2.action.base.BaseAction;
import com.stillcoolme.oa.utils.DeleteMode;

import com.opensymphony.xwork2.ActionContext;

import com.stillcoolme.oa.domain.Department;


@Controller("departmentAction")
@Scope("prototype")
public class DepartmentAction extends BaseAction<Department>{	//妈的，把ModelDriven放到BaseAction了
	
	@Resource(name="departmentService")
	private DepartmentService departmentService;

	/*
	private Department department = new Department();
	
	public Department getModel() {
		
		return this.department;			//实现了ModelDriven接口，将Department压入栈顶。
	}
    */
	
	/**
	 * 值栈
	 *   *  值栈的生命周期
	 *        值栈的生命周期就是一次请求
	 *   *  值栈的数据结构
	 *        对象栈
	 *        map栈
	 *   *  对象栈和map栈有什么区别
	 *        对象栈是一个list
	 *        map栈是一个map
	 *   *  怎么样把一个数据放入到map栈中
	 *   *  怎么样把一个数据放入到对象栈中	
	 *   *  对象栈中的数据有什么样的特殊之处
	 */
	public String getAllDepartment(){
		Collection<Department> departmentList = this.departmentService.getAllDepartment();
		
		/*map栈说明
		 * reuqest,session,application都在map栈中按map存储。
		 * 可以把一个对象放入到map中。
		 * ognl表达式怎么访问map栈中的内容呢？
		 *   1.如果一个对象在request中：#request.对象的key值.属性
		 *   2.如果一个对象直接放入到map栈中：#对象的key值.属性
		 */
		//把一个对象存放到map栈中
		//ServletActionContext.getRequest().setAttribute("depaertmentList", departmentList);	//#request.deparmentList
		ActionContext.getContext().put("departmentList", departmentList);
	
		
		/**
		 对象栈的说明：
		 处于对象栈的对象中的属性是可以直接访问的。
		 如果在对象栈中有一样名称的属性，从栈顶开始查找，直到找到为止。
		 一般情况下，回显的数据应该放在对象栈中，这样效果比较高。
		 用ognl表达式访问对象栈，直接属性名称就可以了，不用加# ！！！！
		 */
		//departmentList放到对象栈栈顶
		//ActionContext.getContext().getValueStack().push(departmentList);
		//ActionContext.getContext().getValueStack().getRoot().add(0, departmentList);
		//把departmentList放入到了对象栈的栈底
		//ActionContext.getContext().getValueStack().getRoot().add(departmentList);
		//获取对象栈的栈顶的元素.peek();
		//移除对象栈的栈顶的元素.pop();
		//移除对象栈的栈顶的元素.getRoot().remove(0);

		//把一个map放入到对象栈的栈顶？？？？？？ActionContext.getContext().getValueStack().set(key, o);  ！
		// 这个看源码就懂的！！set()里面先把栈顶的map拿出来添加map，没有就创建map！！
		
		/*
		List<List<Department>> lists = new ArrayList<List<Department>>();
		Department department1 = new  Department();
		department1.setDname("department1_name");
		Department department2 = new  Department();
		department2.setDname("department2_name");
		List<Department> departmentList1 = new ArrayList<Department>();
		departmentList1.add(department1);
		List<Department> departmentList2 = new ArrayList<Department>();
		departmentList2.add(department2);
		lists.add(departmentList1);
		lists.add(departmentList2);
		
		List<Map<String, Department>> lists2 = new ArrayList<Map<String,Department>>();
		Map<String, Department> map1 = new HashMap<String, Department>();
		map1.put("d1", department1);
		Map<String, Department> map2 = new HashMap<String, Department>();
		map2.put("d2", department2);
		lists2.add(map1);
		lists2.add(map2);
		
		Map<String, List<Department>> maps = new HashMap<String, List<Department>>();
		maps.put("list1", departmentList1);
		maps.put("list2", departmentList2);
		
		ActionContext.getContext().put("maps", maps);
		*/

		return listAction;
	}

	public String deleteDepartment(){
		
		this.departmentService.deleteDepartmentById(this.getModel().getDid(), DeleteMode.DEL_PRE_RELEASE);
		return action2action;
		
	}

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
	
	/**
	 * 一般情况下，如果数据进行回显，则把数据放入到对象栈中，页面上可以根据name属性的值进行回显:
	 * ActionContext.getContext().getValueStack().getRoot().add(0,department);
	 * 
	 * 如果把数据放入到了map栈:ActionContext.getContext().put("department", department);
	 * 则jsp页面根据value的值进行回显，而且value="%{ognl表达式}" ：value="%{#department.dname}"
    */
	public String updateUI(){		//转到修改页面
		
		Department department = this.departmentService.getDepartmentById(this.getModel().getDid());
		
		ActionContext.getContext().getValueStack().getRoot().add(0,department);
		//或者BeanUtils.copyProperties(department, this.getModel());都是放到对象栈的
		
		return updateUI;
	}
	
	public String update(){			//修改
		
		/* 1、先根据id把该数据从数据库中提取出来(或者从session的缓存中)
		 * 2、把修改以后的数据赋值到该对象中
		 * 3、针对该对象进行update操作
		 */
		Department department = this.departmentService.getDepartmentById(this.getModel().getDid());
		BeanUtils.copyProperties(this.getModel(),department);
		this.departmentService.updateDepartment(department);
		return action2action;
	}

}
