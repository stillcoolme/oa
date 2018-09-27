package com.stillcoolme.oa.struts2.action;

import com.stillcoolme.oa.domain.Menuitem;
import com.stillcoolme.oa.domain.User;
import com.stillcoolme.oa.service.MenuitemService;
import com.stillcoolme.oa.service.UserService;
import com.stillcoolme.oa.struts2.action.base.BaseAction;
import com.stillcoolme.oa.utils.OAUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.orm.hibernate3.support.OpenSessionInViewFilter;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import javax.management.loading.ClassLoaderRepository;
import java.util.Collection;
import java.util.Set;

/**
 * Created by zhangjaneh on 2018/9/11.
 */
@Controller("privilegeAction")
@Scope("prototype")
public class PrivilegeAction extends BaseAction<Menuitem> {

    @Resource(name="menuitemService")
    private MenuitemService menuitemService;

    @Resource(name="userService")
    private UserService userService;

    private Long uid;

    private String mids;

    private Collection<Menuitem> privilegeList;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getMids() {
        return mids;
    }

    public void setMids(String mids) {
        this.mids = mids;
    }

    public Collection<Menuitem> getPrivilegeList() {
        return privilegeList;
    }

    public String showPrivilege(){
        privilegeList = this.menuitemService.getMenuitemsByUID(uid);
        return SUCCESS;
    }

    /**
     * 保存某一个用户的权限
     * @return
     */
    public String savePrivilege(){
        Set<Menuitem> menuitems = menuitemService.getMenuitemsByIDS(OAUtils.string2Longs(mids));
        User user = userService.getUserById(uid);
        user.setMenuitems(menuitems);
        this.userService.updateUser(user);
        return SUCCESS;
    }

}
