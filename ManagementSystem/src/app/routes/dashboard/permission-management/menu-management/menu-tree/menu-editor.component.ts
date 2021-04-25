import { Component, Input, OnInit } from '@angular/core';
import { NbToastrService, NbWindowRef } from '@nebular/theme';
import { PermMenu } from 'src/app/entity';
import { PermMenuService } from 'src/app/service/role/perm-menu.service';
import { Pattern } from 'src/app/shared/utils';

@Component({
    template: `
    <form (ngSubmit)="confirm()" #form="ngForm" aria-labelledby="title">
        <div class="kv">
            <div class="key">菜单名称</div>
            <input type="text" required pattern='.{2,}'
                   [(ngModel)]='menu.permEntryName' nbInput placeholder="名称"
                   name='name'>
            <div class="key">链接</div>
            <input type="text" required pattern='(\/[a-zA-Z0-9@\-]{2,}){1,}\/?' 
                   [(ngModel)]='menu.link' nbInput fullWidth placeholder="链接"
                   name='link'>
            <div class="key" *ngIf='!inEdit'>描述字段</div>
            <input *ngIf='!inEdit' type="text" required pattern='([a-zA-Z][a-zA-Z0-9_]{1,})' 
                   [(ngModel)]='menu.descriptor' nbInput fullWidth placeholder="描述字段"
                   name='descriptor'>
            <div class="key">类型</div>
            <div class="user-info-value editing-mode">
                <nb-select fullWidth [(ngModel)]="menu.entryType" name='entryType'>
                  <nb-option value="menu">菜单</nb-option>
                  <nb-option value="page">页面</nb-option>
                  <nb-option value="button">按钮</nb-option>
                </nb-select>
            </div>
        </div>
        <div class="buttons" *ngIf='inEdit'>
            <button nbButton status='warning' (click)="delete()" hero
                    [nbSpinner]='inDelete' nbSpinnerSatus='info'>删除</button>
            <button nbButton status='danger' (click)="deleteRecursively()"  outline
                    [nbSpinner]='inDeleteRec' nbSpinnerSatus='info'>递归删除</button>
        </div>
        <div class="buttons">
            <button nbButton status='primary' (click)="confirm()" hero [disabled]='!form.valid'>确认</button>
            <button nbButton status='primary' (click)="cancel()"  outline>取消</button>
        </div>
    </form>
    `,
    styles: [
        `
        .kv {
            display: grid;
            grid-template-columns: 30% 70%;
            grid-row-gap: 0.8em;
        }
        .buttons {
            padding: 1em 0em 0em 0em;
            display: flex;
            flex-direction: row;
            justify-content: space-between;
        }
        `,
    ],
})
export class MenuEditorComponent implements OnInit {
    @Input()
    menu: PermMenu;
    inEdit: boolean;

    inDelete: boolean;
    inDeleteRec: boolean;
    
    constructor(private windowRef: NbWindowRef,
                private permMenuService: PermMenuService,
                private toastrService: NbToastrService) {}

    ngOnInit() {
        this.inEdit = !!this.menu;
        this.menu = this.menu || new PermMenu();
        if(this.menu.entryType == null) {
            this.menu.entryType = 'menu';
        }
    }

    confirm() {
        this.windowRef.config.context['isConfirmed'] = true;
        this.windowRef.config.context['menu'] = this.menu;
        this.windowRef.close();
    }

    cancel() {
        this.windowRef.config.context['isConfirmed'] = false;
        this.windowRef.close();
    }

    async delete() {
        if(this.inDelete) return;
        this.inDelete = true;

        try {
            await this.permMenuService.delete(this.menu.descriptor);
        } catch {
            this.toastrService.danger("删除菜单失败", "菜单管理");
        } finally {
            this.inDelete = false;
        }
    }

    async deleteRecursively() {
        if(this.inDeleteRec) return;
        this.inDeleteRec = true;
        
        try {
            await this.permMenuService.delete(this.menu.descriptor, true);
        } catch {
            this.toastrService.danger("删除菜单失败", "菜单管理");
        } finally {
            this.inDeleteRec = false;
        }
    }
}

