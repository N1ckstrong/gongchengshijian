import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { NbActionsModule, NbAlertModule, NbButtonModule, NbCardModule, NbCheckboxModule, NbDatepickerModule, NbIconModule, NbInputModule, NbLayoutModule, NbListModule, NbRadioModule, NbSelectModule, NbSpinnerModule, NbTimepickerModule, NbUserModule } from '@nebular/theme';
import { ThemeModule } from '../@theme/theme.module';
import { DashboardHeaderComponent } from './components/dashboard-header/dashboard-header.component';
import { ComponentsModule } from './components/components.module';
import { Ng2SmartTableModule } from 'ng2-smart-table';
import { InterceptorProviders } from '../core/http';


@NgModule({
    declarations: [],
    imports: [
        CommonModule,
    ],
    exports: [
        FormsModule,
        HttpClientModule,
        Ng2SmartTableModule,
        ThemeModule,
        NbDatepickerModule,
        NbTimepickerModule,
        NbActionsModule,
        NbSpinnerModule,
        NbSelectModule,
        NbListModule,
        NbLayoutModule,
        NbRadioModule,
        NbUserModule,
        NbIconModule,
        NbCardModule,
        NbAlertModule,
        NbInputModule,
        NbButtonModule,
        NbCheckboxModule,
        ComponentsModule,
    ],
    providers: [
        ...InterceptorProviders
    ]
})
export class SharedModule { }

