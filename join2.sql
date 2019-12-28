select 
  emp."EmployeeID",
  emp."FirstName",
  emp."LastName",
  ter."TerritoryID" as "territory max",
  ter."TerritoryDescription" as "Last territory desc",
  reg."RegionDescription" as "Last region desc",
  ter2."TerritoryID" as "Territory min",
  ter2."TerritoryDescription" as "First territory desc",
  coalesce(ter2."TerritoryID", ter."TerritoryID"),
  (select
    ter7."TerritoryDescription"
  from
    territories ter7
  where
    ter7."TerritoryID"=coalesce(ter2."TerritoryID", ter."TerritoryID"))
  
from 
  employees as emp
  join employeeterritories as eter
    on emp."EmployeeID"=eter."EmployeeID"
 left join territories as ter
    on ter."TerritoryID"=eter."TerritoryID" and ter."TerritoryID"=(
  select
    max(eter2."TerritoryID")
  from
    employeeterritories as eter2
  where
    eter2."EmployeeID"=emp."EmployeeID"
 )
 left join region as reg 
    on ter."RegionID"=reg."RegionID"
  --join employeeterritories as eter2
   -- on emp."EmployeeID"=eter2."EmployeeID"
 left join territories as ter2
    on ter2."TerritoryID"=eter."TerritoryID" and ter2."TerritoryID"=(
  select
    min(eter3."TerritoryID")
  from
    employeeterritories as eter3
  where
    eter3."EmployeeID"=emp."EmployeeID"
 )
where
  ter."TerritoryID" is not null or
  ter2."TerritoryID" is not null;
  
select
  emp."EmployeeID",
  max(eter."TerritoryID")
from 
  employees as emp
  join employeeterritories as eter
    on emp."EmployeeID"=eter."EmployeeID"
    group by emp."EmployeeID"