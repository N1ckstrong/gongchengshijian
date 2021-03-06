import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { UserInfoRoutingModule } from './user-info-routing.module';
import { UserInfoViewerComponent } from './user-info-viewer/user-info-viewer.component';
import { SharedModule } from 'src/app/shared/shared.module';
import { PrivEditWindowComponent } from './user-info-viewer/priv-edit-window.component';
import { ProfilePhotoUploadComponent } from './user-info-viewer/profile-photo-upload.component';


@NgModule({
    declarations: [ UserInfoViewerComponent, PrivEditWindowComponent, ProfilePhotoUploadComponent ],
    imports: [
        CommonModule,
        UserInfoRoutingModule,
        SharedModule
    ]
})
export class UserInfoModule { }

