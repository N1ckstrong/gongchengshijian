package six.daoyun.service.UserServiceImpl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.NoSuchElementException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;

import six.daoyun.entity.Role;
import six.daoyun.entity.User;
import six.daoyun.exception.Forbidden;
import six.daoyun.exchange.UserInfo;
import six.daoyun.repository.UserRepository;
import six.daoyun.service.RoleService;
import six.daoyun.service.UserService;
import six.daoyun.utils.ObjUtil;

@Service
public class UserServiceImpl implements UserService {
    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(UserServiceImpl.class);
    @Autowired
    private RoleService roleService;

    @Autowired
    private RedisTemplate<String, UserInfo> userinfoCache;
    private static String userinfoKey(String username) {
        return "userinfo_" + username;
    }

    @Autowired
    private UserRepository userRepository;

	@Override
	public void createUser(final User user) {
        log.info("create new user: {}", user.getUserName());
        this.userRepository.save(user);
	}

	@Override
	public Optional<User> getUser(final String userName) {
        final User user = this.userRepository.getUserByUserName(userName);
        return Optional.ofNullable(user);
	}

    private void clearKey(String username) //{
    {
        final String key = userinfoKey(username);
        if(this.userinfoCache.hasKey(key)) {
            this.userinfoCache.delete(key);
        }
    } //}

	@Override
	public void updateUser(User user) {
        this.clearKey(user.getUserName());
        this.userRepository.save(user);
	}

	@Override
	public void deleteUser(final String username) {
        this.clearKey(username);
        this.userRepository.deleteByUserName(username);
	}

	@Override
	public Collection<User> getAllUsers() {
        final ArrayList<User> ans = new ArrayList<User>();
        this.userRepository.findAll().forEach(ans::add);
        return ans;
	}

	@Override
	public Optional<UserInfo> getUserInfo(String username) //{
    {
        final String key = userinfoKey(username);
        ValueOperations<String, UserInfo> operation = this.userinfoCache.opsForValue();

        if(this.userinfoCache.hasKey(key)) {
            return Optional.of(operation.get(key));
        } else {
            final UserInfo userinfo = new UserInfo();
            try {
                final User user = this.getUser(username).get();
                ObjUtil.assignFields(userinfo, user);

                if(user.getBirthday() != null) {
                    userinfo.setBirthday(user.getBirthday().getTime());
                }
                if(user.getProfilePhoto() != null && user.getProfilePhoto().length > 0) {
                    userinfo.setPhoto(new String(user.getProfilePhoto()));
                }

                Collection<String> roles = new ArrayList<>();
                user.getRoles().forEach(role -> roles.add(role.getRoleName()));
                userinfo.setRoles(roles);

                operation.set(key, userinfo);
                return Optional.of(userinfo);
            } catch (NoSuchElementException ex){}
        }

		return Optional.empty();
    } //}

	@Override
	public Optional<User> getUserByPhone(String phone) {
        return Optional.ofNullable(this.userRepository.getUserByPhone(phone));
	}

	@Override
	public Page<User> getUserPage(int pageno, int size, String sortKey, boolean desc, String filter) {
        Sort sort = Sort.by(sortKey);
        if(desc) {
            sort = sort.descending();
        } else {
            sort = sort.ascending();
        }
        Pageable page = PageRequest.of(pageno, size, sort);
        if(filter == null || filter.isBlank()) {
            return this.userRepository.findAll(page);
        } else {
            return this.userRepository.findAll(filter, page);
        }
	}

	@Override
	public void addRole(User user, Role role) {
        if(user.getRoles().contains(role)) {
            throw new Forbidden("用户已拥有角色");
        }

        user.getRoles().add(role);
        this.userRepository.save(user);
	}

	@Override
    public void removeRole(User user, Role role) {
        if(!user.getRoles().contains(role)) {
            throw new Forbidden("用户未拥有角色");
        }

        user.getRoles().remove(role);
        this.userRepository.save(user);
	}

	@Override
	public boolean hasPermission(User user, String link) //{
    {
        for(final Role role: user.getRoles()) {
            if(this.roleService.hasPermissionInLink(role.getRoleName(), link)) {
                return true;
            }
        }
        return false;
	} //}
}

