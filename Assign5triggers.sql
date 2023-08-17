create database Assignement5DB
on primary
(name = AssignDb_data,
filename = 'M:\Simplilearn\mphasis\Phase-2\day-5\Assign5\AssignDB_data.mdf')
--------------------
use Assignement5DB
create schema Bank
create table Bank.Customer 
(CId int primary key,
CName nvarchar(50) not null,
CEmail nvarchar(100) not null unique,
Contact nvarchar(20) not null unique,
CPwd AS right(CName, 2) + convert(nvarchar(10),CId) + left(Contact, 2) persisted
)

create table Bank.MailInfo 
( MailTo nvarchar(100),
MailDate date default getdate(),
MailMessage nvarchar(max)
)

create trigger TOMailInfo
on Bank.Customer
after insert
as
begin
insert into Bank.MailInfo (MailTo, MailMessage)
select i.CEmail, 'Your net banking Password is : ' + i.CPwd + '. It is valid up to 2 days only. Update it.'
from inserted i;
end

----inserting data into custumer

insert into Bank.Customer (CId, CName, CEmail, Contact) values (1001, 'sivakumar', 'sivamail@tic.com', '1234567890'),(1002, 'Ram', 'Mymail@m.com', '8457165874');


select * from Bank.MailInfo