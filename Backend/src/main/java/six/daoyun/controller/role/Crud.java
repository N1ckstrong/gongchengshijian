package six.daoyun.controller.role;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import six.daoyun.controller.exception.HttpForbidden;
import six.daoyun.controller.role.proto.GetRole;
import six.daoyun.entity.Role;
import six.daoyun.service.RoleService;

@RestController
class Crud {
    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(Crud.class);

    @Autowired
    private RoleService roleService;

    @GetMapping("/apis/role/by-name")
    private Role getRoleByName(@RequestBody GetRole req) {
        log.info("API GET /apis/role/by-name");
        return this.roleService.getRoleByRoleName(req.getRoleName());
    }

    @GetMapping("/apis/role/all")
    private Collection<Role> getAllRoles() {
        log.info("API GET /apis/role/all");
        return this.roleService.getAllRoles();
    }

    @PostMapping("/apis/role")
    private void newUsers(@RequestBody GetRole req) {
        log.info("API POST /apis/role");
        if(this.roleService.hasRole(req.getRoleName())) {
            throw new HttpForbidden();
        } else {
            this.roleService.createRole(req.getRoleName());
        }
    }
}

