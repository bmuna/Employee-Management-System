interface IDecodeToken {
    id: number;
	role_id:number,
    email: string;
	full_name: string;
	phone_number: string
    password: string;
	user_type: string;
	createdAt: string;
	updatedAt: string
}

export default interface IDecodeTokenUser{
	user: IDecodeToken
}