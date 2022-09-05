import ITaskjson from '../interfaces/task'

const taskJsonFormatter = (result: any[], callback: (formattedJson: any[] | null) => void): void => {
	console.log(result);
var newdata:any = [];
var datas: any = [];
var userdatas = [...new Set(result.map((item:ITaskjson) => item.id))];

userdatas.forEach((userdata, i) => {
	var temp1:any  = {};
	datas[i] = [];
	result.forEach((d:ITaskjson)  => {
		if (d.id === userdata) {
			datas[i].push(d);
			temp1.id = d.id;
			temp1.employee_id = d.employee_id;
			temp1.user_id = d.user_id;
			temp1.role_id = d.role_id;
			temp1.full_name = d.full_name;
			temp1.email = d.email;
			temp1.password = d.password;
			temp1.phone_number = d.phone_number;
			temp1.user_type = d.user_type;
			temp1.token = d.token;
			temp1.createdAt = d.createdAt;
			temp1.updatedAt = d.updatedAt;
			temp1.role = d.role;
		}
	});


	temp1.tasks = [];

	var products = [...new Set(datas[i].map((item:ITaskjson) => item.task))];

		products.forEach((ps, k) => {
			var temp2 = {};

			datas[i].forEach((scat:ITaskjson) => {
				if (scat.task === ps) {
					temp2 = scat.task;
					temp1.tasks.push(temp2);
				}
			});
		});
		newdata.push(temp1);
		callback(newdata);

       
	});
}
export {taskJsonFormatter};
