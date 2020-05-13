

create database BANKING_ENTERPRISE;
use BANKING_ENTERPRISE;
create table Branch(
branch_name varchar(30),
branch_city varchar(10),
assets real,
PRIMARY KEY (branch_name));

insert into Branch values(
'SBI_Chamrajpet','Bangalore',50000),
("SBI_ResidencyRoad","Bangalore",10000),
("SBI_ShivajiRoad","Bonbay",20000),
("SBI_ParliamentRoad","Delhi",10000),
("SBI_Jantarmantar","Delhi",20000);
select * from Branch;


create table Bank_account(
acc_no int,
branch_name varchar(30),
balance real,
PRIMARY KEY (acc_no),
FOREIGN KEY (branch_name) REFERENCES BRANCH(branch_name));

insert into Bank_account values(
1,"SBI_Chamrajpet",2000),(2,"SBI_ResidencyRoad",5000),(3,"SBI_ShivajiRoad",6000),(4,"SBI_ParliamentRoad",9000),(5,"SBI_Jantarmantar",8000),(6,"SBI_ShivajiRoad",4000),(8,"SBI_ResidencyRoad",4000),(9,"SBI_ParliamentRoad",3000),(10,"SBI_ResidencyRoad",5000),(11,"SBI_Jantarmantar",2000);
select * from Bank_account;

create table Bank_Customer(
customername varchar(30),
customerstreet varchar(30),
customercity varchar(30),
primary key (customername));

insert into Bank_Customer values("Avinash","Bull Temple Road","Bangalore"),
("Dinesh","Bannergatta Road","Bangalore"),
("Mohan","National College Road","Bangalore"),
("Nikil","Akbar Road","Delhi"),
("Ravi","Prithviraj Road","Delhi");

create table Depositor(
customername varchar(30),
acc_no int,
PRIMARY KEY (customername,acc_no),
FOREIGN KEY (customername) REFERENCES Bank_Customer (customername),
FOREIGN KEY (acc_no) REFERENCES Bank_account(acc_no));

insert into Depositor values(
"Avinash",1),("Dinesh",2),("Nikil",4),("Ravi",5),("Avinash",8),("Nikil",9),("Dinesh",10),("Nikil",11);
select * from Depositor;

create table Loan(
loan_num int,
branch_name varchar(30),
amount real,
PRIMARY KEY (loan_num),
FOREIGN KEY (branch_name) REFERENCES Branch(branch_name));

insert into Loan values(
1,"SBI_Chamrajpet",1000),(2,"SBI_ResidencyRoad",2000),(3,"SBI_ShivajiRoad",3000),(4,"SBI_ParliamentRoad",4000),(5,"SBI_Jantarmantar",5000);
select * from Loan;

create table borrower(
customername varchar(30),
loan_num int,
foreign key(customername) references  Bank_Customer (customername),
foreign key(loan_num) references Loan(loan_num));

insert into borrower values('Avinash',1), ('Dinesh',2), ('Nikil',3), ('Avinash', 4), ('Dinesh', 5);
				      
select C.customername 
from Bank_Customer C
where exists (
				select D.customername, count(D.customername)
                from Depositor D,Bank_account BA
                where
                D.acc_no = BA.acc_no AND C.customername = D.customername AND BA.branch_name='SBI_ResidencyRoad' 
                group by D.customername
                having count(D.customername) >=2);
                
select BC.customer_name from BankCustomer BC where not exists(
	select branch_name from Branch where branch_city = 'Delhi'
	and branch_name not in(
    select BA.branch_name from Depositer D, BankAccount BA
	where D.accno = BA.accno and BC.customer_name = D.customer_name)
);
                    
delete from Bank_account 
where branch_name in (select branch_name 
					  from Branch
                      where branch_city='Bonbay');
select * from Bank_account;
