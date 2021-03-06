
import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ViewCell } from 'ng2-smart-table';
import { DictionaryType } from 'src/app/entity';

@Component({
    template: `
        <button nbButton status='info' size='small' (click)='gotoDict()' outline>查看</button>
    `,
})
export class ClickCellComponent implements ViewCell, OnInit {
    constructor(private router: Router, private activatedRouter: ActivatedRoute) {}

    @Input() value: string | number;
    @Input() rowData: DictionaryType;

    ngOnInit() {
    }

    async gotoDict() {
        await this.router.navigate(['../dict-info'], {
            relativeTo: this.activatedRouter,
            queryParams: {
                typeCode: this.rowData.typeCode
            },
        });
    }
}

