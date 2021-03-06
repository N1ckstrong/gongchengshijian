package six.daoyun.service;

import six.daoyun.entity.Role;
import java.util.Collection;
import java.util.Optional;

public interface RoleService {
    void createRole(String roleName);
    boolean hasRole(String roleName);
    void deleteRole(String roleName);
    Optional<Role> getRoleByRoleName(String roleName);
    Collection<Role> getAllRoles();

    void updateRoleName(String oldRoleName, String newRoleName);

    boolean hasPermission(String roleName, String descriptor);
    boolean hasPermissionInLink(String roleName, String link, String method);
    void enablePermEntry(String roleName, String descriptor);
    void disablePermEntry(String roleName, String descriptor);
    void enablePermEntryRecursively(String roleName, String descriptor);
    void disablePermEntryRecursively(String roleName, String descriptor);

    void addPermEntry(String descriptor, PermEntryItem perm);
    void removePermEntry(String descriptor);
    void removePermEntryRecursively(String descriptor);
    void updatePermEntry(String descriptor, PermEntryItem perm);

    PermEntryItem getPermEntryItemByDescriptor(String descriptor);

    public static class PermEntryItem //{
    {
        private String link;
        public String getLink() {
            return this.link;
        }
        public void setLink(String link) {
            this.link = link;
        }

        private String method;
        public String getMethod() {
            return this.method;
        }
        public void setMethod(String method) {
            this.method = method;
        }

        private String descriptor;
        public String getDescriptor() {
            return this.descriptor;
        }
        public void setDescriptor(String descriptor) {
            this.descriptor = descriptor;
        }

        private String entryType;
        public String getEntryType() {
            return this.entryType;
        }
        public void setEntryType(String entryType) {
            this.entryType = entryType;
        }

        private String permEntryName;
        public String getPermEntryName() {
            return this.permEntryName;
        }
        public void setPermEntryName(String permEntryName) {
            this.permEntryName = permEntryName;
        }

        private String remark;
        public String getRemark() {
            return this.remark;
        }
        public void setRemark(String remark) {
            this.remark = remark;
        }

        private int sortOrder;
        public int getSortOrder() {
            return this.sortOrder;
        }
        public void setSortOrder(int sortOrder) {
            this.sortOrder = sortOrder;
        }
    } //}
    public static class PermEntryTree extends PermEntryItem //{
    {
        private Collection<PermEntryTree> children;
        public Collection<PermEntryTree> getChildren() {
            return this.children;
        }
        public void setChildren(Collection<PermEntryTree> children) {
            this.children = children;
        }
    } //}
    Collection<PermEntryTree> getPermEntryTree();
    Collection<PermEntryItem> getPermEntries(String roleName);

    Collection<Role> getRolesByPermEntry(String descriptor);
}

