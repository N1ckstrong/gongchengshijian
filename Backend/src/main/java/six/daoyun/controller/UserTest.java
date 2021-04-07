package six.daoyun.controller;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import six.daoyun.entity.User;
import six.daoyun.service.UserService;

@RestController
class UserTest {
    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(UserTest.class);

    @Autowired
    private UserService UserService;

    @GetMapping("/users")
    private Collection<User> getUsers() {
        log.info("API GET /users");
        return this.UserService.getAllUsers();
    }

    @GetMapping("/user")
    private User getUserByName(@RequestBody User User) {
        log.info("API GET /user");
        return this.UserService.getUserByUserName(User.getUserName());
    }

    @PostMapping("/user")
    private void newUsers(@RequestBody User User) {
        log.info("API POST /user");
        this.UserService.createUser(User);
    }
}

