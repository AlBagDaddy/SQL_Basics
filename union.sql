select
  tab.*,
  ter.*
from
  (select
    emp."EmployeeID",
    max(eter."TerritoryID") as "peak",
    'A' record_source
   --eter."TerritoryID"
  from
    employees emp
    join employeeterritories eter on
      eter."EmployeeID"=emp."EmployeeID"
  group by 
    emp."EmployeeID"
      --eter."TerritoryID"
  union all 
  select
    emp."EmployeeID",
    min(eter."TerritoryID"),
    'B'
   --eter."TerritoryID"
  from
    employees emp
    join employeeterritories eter on
      eter."EmployeeID"=emp."EmployeeID"
  group by 
    emp."EmployeeID") as tab
  join territories ter on ter."TerritoryID"=tab.peak
    --eter."TerritoryID"
order by "EmployeeID", "peak"