select* from departments;
select * from employee;
select * from employee_projects;
select * from projects;

-- string functions
select concat(first_name,' ',last_name) as full_name 
from employee;

select lower(first_name) as first_name,lower(last_name) as last_name
from employee;

select substring(first_name,1,3) as first_3letters 
from employee;

select replace(email,'@company.com','@org.com')
from employee;

select trim(first_name) as no_space 
from employee; 

select length(concat(first_name,last_name)) as full_name_length 
from employee;

select position('@' in email) from employee;

select 
	case 
		when first_name in ('Alice','Carol','Eve','Grace','Ivy') then concat('Ms. ',' ',first_name,' ',last_name)
		else concat('Mr.',first_name,' ',last_name) 
	end as full_name
from employee;

select upper(project_name) as project_name 
from projects;

select replace(project_name,'-','') removed_dashes from projects;

select 
	'Emp:' || e.first_name || ' ' || e.last_name || ' ' ||'( '|| d.department_name || ' )' 
 from employee e join departments d 
 on e.department_id=d.department_id;

select length(email) as email_length from employee;

select substring(email,position('.'in email)+1,length(last_name)) from employee;

select concat(upper(last_name),',',first_name) from employee;

select 
	'Active'||' '|| e.first_name ||' '||e.last_name as full_name_status
	from employee e join employee_projects ep
	on e.employee_id=ep.employee_id;

-- numeric functions 16-25
select round(salary) 
	from employee;

select salary 
	from employee 
		where mod(salary,2)=0 ;

select age(end_date,start_date) from projects;

Select abs(e1.salary - e2.salary) 
from employee e1, employee e2
where e1.employee_id = 101 AND e2.employee_id = 102;

select (salary * power(1.10,1)) from employee;

select random() from employee;

select ceil(salary) as round_down_salary from employee;

select floor(salary) as round_up_salary from employee;

select length(phone) from employee;

select salary,
	case when salary>50000 then 'High_salary'
		 when salary>30000 and salary<50000 then 'Medium_salary'
	else 'Lower Salary'
	end
	from employee;

select length(salary::Text) from employee;

-- DATE/TIME Function 
select now();

select age(now(),hire_date) from employee;

select * from employee where hire_date= now();

select now();

select substring(hire_date::Text,1,4) as year_of_hire,
	   substring(hire_date::Text,6,2) as month_of_hire,
	   substring(hire_date::Text,9,2) as day_of_hire
	from employee;

select * from employee where substring(hire_date::text,1,4)<'2020';

select * from projects where age(end_date,start_date)>= '30';

select end_date-start_date from projects;

	select concat(
	      case  substring(hire_date::Text,6,2)
		   when '01' then 'January'
		   when '02' then 'February'
		   when '03' then 'March'
		   when '04' then 'April'
		   when '05' then 'May'
		   when '06' then 'June'
		   when '07' then 'July'
		   when '08' then 'August' 
		   when '09' then 'September'
		   when '10' then 'October'
		   when '11' then 'November'
		   when '12' then 'December'
		   else 'no month'
		   end,
		   ' ', 
		   substring(hire_date::Text,9,2),', ',
		   substring(hire_date::Text,1,4)) as hire_date
		   from employee;

select *,
	case 
	when end_date > now() then 'still active' 
	when end_date < now() then 'ended'
	when end_date is null  then 'ongoing'
	end as status_of_project
 from projects;

-- Conditional Functions

select salary,
	case when salary>50000 then 'High'
		 when salary>30000 and salary<50000 then 'Medium'
	else 'Lower'
	end as label_salary
	from employee;

select coalesce(email,'no email') from employee;

select 
    case when hire_date<'2015-01-01'then 'Veteran'
	else 'Rookie'
	end as nickname
from employee;

select coalesce(salary::text,'3000') from employee;

select 
	case (department_name)
	when 'Marketing' then 'MT'
	when 'Operations' then 'OP'
	when 'Legal' then 'LG'
	when 'Finance' then 'Fin'
	when 'Information Technology' then 'IT'
	when 'Human Resources' then 'HR'
	when 'Research and Development' then 'R&D'
	when 'Sales' then 'sal'
	when 'Procurement' then 'Proc'
	when 'Customer Service' then 'CS'
  end as categorized_departments
  from departments;

select *,
     case 
	 when e.employee_id = ep.employee_id then 'assigned'
	 else 'unassigned'
	 end
from employee e join employee_projects ep on e.employee_id=ep.employee_id;

select first_name,last_name,
 	case 
	 when salary<30000 then 'Low Tax'
	 when salary between 30000 and 99999 then 'Medium Tax'
	 when salary>=100000 then 'Large Tax'
	 end
from employee;

select project_name,start_date,end_date,
	case
	when (end_date-start_date)>100 then 'long_project'
	when (end_date-start_date)<100 then 'short_project'
	else 'ongoing_project'
	end 
from projects;


select first_name,last_name,employee_id,
	case when mod(employee_id,2)=0 then 'Odd_id'
	else 'Even_id'
	end
from employee;

select concat(
       coalesce(first_name,'no firstName'),
	   ' ',
	   coalesce(last_name,'no lastName')
	   )
from employee;

select first_name,last_name,
	case
	   when length(first_name)>10 then 'Long Name'
	   else 'Short Name'
	   end
	from employee;

select first_name,last_name,
	case
	when upper(email)='TEST' then 'dummy account'
	else 'real account'
	end
from employee;

select first_name,last_name ,
    case when hire_date<'2015-01-01'then 'Senior'
	else 'Junior'
	end as nickname
from employee;

select first_name,last_name,
 	case 
	 when salary<30000 then 'Increase by 15%'
	 when salary between 30000 and 99999 then 'Increase by 7%'
	 when salary>=100000 then 'Increase by 5%'
	 end as Increment_range
from employee;

select hire_date,now(),
     case 
	 when substring(hire_date::text,6,2)=substring(now()::text,6,2) then 'Its your anniversary'
	 else 'not yet'
	 end
from employee;
-- end 