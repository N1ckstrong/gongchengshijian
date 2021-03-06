import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PermissionManagementRoutingModule } from './permission-management-routing.module';
import { MenuManagementComponent } from './menu-management/menu-management.component';
import { RoleListComponent } from './role-list/role-list.component';
import { SharedModule } from 'src/app/shared/shared.module';
import { ButtonsCellComponent } from './role-list/buttons-cell.component';
import { MenuTreeComponent } from './menu-management/menu-tree/menu-tree.component';
import { MenuRoleListComponent } from './menu-management/menu-tree/menu-role-list.component';
import { MenuEditorComponent } from './menu-management/menu-tree/menu-editor.component';


@NgModule({
    declarations: [
        MenuManagementComponent, RoleListComponent,
        ButtonsCellComponent, MenuTreeComponent, MenuRoleListComponent,
        MenuEditorComponent,
    ],
    imports: [
        CommonModule,
        SharedModule,
        PermissionManagementRoutingModule
    ]
})
export class PermissionManagementModule { }
