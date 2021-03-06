package six.daoyun.service.SysparamServiceImpl;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import six.daoyun.controller.exception.HttpNotFound;
import six.daoyun.entity.SystemParameter;
import six.daoyun.repository.SysparamRepository;
import six.daoyun.service.SysparamService;

@Service
public class SysparamServiceImpl implements SysparamService {
	@Autowired
    private SysparamRepository repository;
    private Map<String, SystemParameter> cache;

    public SysparamServiceImpl() {
        this.cache = new HashMap<>();
    }

    private static String keyname(String key) {
        return "systemparam_" + key;
    }

    private void invalidateKey(String paramkey) {
        final String key = keyname(paramkey);
        if(this.cache.containsKey(key)) {
            this.cache.remove(key);
        }
    }

	@Override
	public void create(SystemParameter sysparam) {
        this.repository.save(sysparam);
	}

	@Override
	public Optional<SystemParameter> get(String paramkey) {
        final String key = keyname(paramkey);
        if(this.cache.containsKey(key)) {
            return Optional.of(this.cache.get(key));
        }

        SystemParameter param = this.repository.findByParameterName(paramkey);
        if(param != null) {
            this.cache.put(key, param);
            return Optional.of(param);
        }

        return Optional.empty();
	}

	@Override
	public void update(SystemParameter sysparam) {
        SystemParameter param = this.repository.findByParameterName(sysparam.getParameterName());
        if(param == null) {
            throw new HttpNotFound(sysparam.getParameterName() + " 不存在");
        } else {
            param.setParameterValue(sysparam.getParameterValue());
            param.setRemark(sysparam.getRemark());
            this.repository.save(param);
            this.invalidateKey(sysparam.getParameterName());
        }
	}

	@Override
	public void delete(String key) {
        this.repository.deleteByParameterName(key);
        this.invalidateKey(key);
	}

	@Override
	public Iterable<SystemParameter> getAll() {
        return this.repository.findAll();
	}

	@Override
	public Page<SystemParameter> getAll(Integer pageno, Integer size, String sortKey, boolean desc, String filter) {
        Sort sort = Sort.by(sortKey);
        if(desc) {
            sort = sort.descending();
        } else {
            sort = sort.ascending();
        }
        Pageable page = PageRequest.of(pageno, size, sort);
        if(filter == null || filter.isBlank()) {
            return this.repository.findAll(page);
        } else {
            return this.repository.findAll(filter, page);
        }
	}
}

