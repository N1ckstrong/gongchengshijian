import { API_ADDRESS } from 'src/app/shared/utils';


export module Auth {
    export const login = API_ADDRESS + '/apis/auth/login';
    export const jwt   = API_ADDRESS + '/apis/auth/jwt';
}

