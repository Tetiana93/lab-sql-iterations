DELIMITER //
create procedure store_total(in x int, out y float)
begin 
select sum(amount) as total_business into y
from store
join customer using(store_id)
join payment using(customer_id)
group by store_id
having store_id=x;
end //
DELIMITER ;
call store_total(2, @y);
select @y;
drop procedure if exists store_total_1;
DELIMITER //
create procedure store_total_1(in x int, out y float)
begin
declare total_sales_value float default 0.0;
select sum(amount) as total_business into total_sales_value
from store
join customer using(store_id)
join payment using(customer_id)
group by store_id
having store_id=x;
select total_sales_value into y;
end //
DELIMITER ;
call store_total_1(2, @y);
select @y;
drop procedure if exists store_total_2;
DELIMITER //
create procedure store_total_2(in x int, out y float, out z varchar(20))
begin
declare total_sales_value float default 0.0;
declare flag varchar(20);
select sum(amount) as total_business into total_sales_value
from store
join customer using(store_id)
join payment using(customer_id)
group by store_id
having store_id=x;
select total_sales_value;
if total_sales_value > 30000 then
set flag = 'green_flag';
else
set  flag = 'red_flag';
end if;
select flag;
set y = total_sales_value;
set z = flag;

end //
DELIMITER ;
call store_total_2(1, @y,@z);
select @y, @z;