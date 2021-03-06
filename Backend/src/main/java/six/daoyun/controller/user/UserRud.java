package six.daoyun.controller.user;

import java.util.Collection;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import six.daoyun.controller.DYUtil;
import six.daoyun.controller.exception.HttpBadRequest;
import six.daoyun.controller.exception.HttpUnauthorized;
import six.daoyun.controller.user.proto.UserUpdating;
import six.daoyun.controller.user.proto.UserUpdatingPriv;
import six.daoyun.entity.User;
import six.daoyun.exchange.UserInfo;
import six.daoyun.service.UserService;
import six.daoyun.utils.ObjUtil;


@Tag(name = "用户个人信息")
@RestController
@RequestMapping("/apis/user")
public class UserRud {
    @Autowired
    private UserService userService;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping()
    public UserInfo getUserinfo(HttpServletRequest httpreq) //{
    {
        final User user = DYUtil.getHttpRequestUser(httpreq);
        return this.userService.getUserInfo(user.getUserName()).get();
    } //}

    @PutMapping()
    public Collection<String> modifyUserInfo(HttpServletRequest httpreq, @RequestBody UserUpdating request) //{
    {
        final User user = DYUtil.getHttpRequestUser(httpreq);
        Collection<String> ans = ObjUtil.assignFields(user, request);

        if(request.getBirthday() >= 0) {
            Date birthday = new Date(request.getBirthday());
            user.setBirthday(birthday);
            ans.add("birthday");
        }

        if(request.getPhoto() != null && request.getPhoto().length() > 0) {
            byte[] photo = request.getPhoto().getBytes();
            user.setProfilePhoto(photo);
            ans.add("photo");
        }

        if(ans.isEmpty()) {
            throw new HttpBadRequest("无效的请求");
        } else {
            this.userService.updateUser(user);
        }

        return ans;
    } //}

	@PutMapping("/privileged")
    public Collection<String> modifyUserInfoPriv(HttpServletRequest httpreq, @RequestBody @Valid UserUpdatingPriv request) //{
    {
        final User user = DYUtil.getHttpRequestUser(httpreq);

        if(!this.passwordEncoder.matches(request.getRequiredPassword(), user.getPassword())) {
            throw new HttpUnauthorized("密码错误");
        }
        Collection<String> ans = ObjUtil.assignFields(user, request);

        if(request.getPassword() != null) {
            user.setPassword(this.passwordEncoder.encode(request.getPassword()));
        }

        if(ans.isEmpty()) {
            throw new HttpBadRequest("无效的请求");
        } else {
            this.userService.updateUser(user);
        }

        return ans;
    } //}

    @Operation(summary = "获取用户的API权限")
    @GetMapping("/descriptor")
    public Collection<String> getDescriptors(HttpServletRequest httpreq) {
        final User user = DYUtil.getHttpRequestUser(httpreq);
        return this.userService.getDescriptors(user);
    }
}

