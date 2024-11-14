/* SELECT FROM [dbo].[OIGE] a */
DECLARE @A AS DATE
DECLARE @B AS DATE
/* WHERE */
SET @A = /* a.CreateDate 'FromDate' */ '[%0]'
SET @B = /* a.CreateDate 'ToDate'  */ '[%1]'
select 
a.DocNum 'doc_num',
a.createDate 'create_date',
a.DocDate 'posting_date',
'' 'WO No',
'' 'Subject',
'' 'Category',
b.VisOrder + 1  'line',
c.U_MIS_IssuePName 'issue_purpose',
d.U_MIS_CategoryName 'job_category',
E.U_MIS_JobDesc 'job_name',
a.U_MIS_UnitNo 'unit_no',
g.U_MIS_ModeNo 'model_no',
a.U_MIS_SerialNo 'serial_no',
a.U_MIS_HoursMeter 'hours_meter',
b.ItemCode 'item_code',
b.Dscription 'dscription',
b.Quantity 'qty',
A.U_MIS_Project 'project',
f.WhsName,
a.U_MIS_NoBA,
'' [Order Type],
CASE 
WHEN U_MIS_CancelStat='Y' THEN 'Cancel'
END AS 'gi_status',
U_U_MIS_GRNo 'gr_no',
NULL 'm_ret_no',
NULL 'item_code',
NULL 'description',
NULL 'qty',
a.Comments
from OIGE a
inner join IGE1 b on a.DocEntry =  b.DocEntry
left join [@MIS_ISSUEPURPOSE] c on a.U_MIS_IssuePurpose = c.U_MIS_IssuePCode
left join [@MIS_JOBCATEGORY] d on a.U_MIS_JobCategory = d.U_MIS_CategoryCode
left join [@MIS_JOBCODE] e on a.U_MIS_JobCode = e.Code
left join OWHS f on b.WhsCode = f.WhsCode
left join OITM g on a.U_MIS_UnitNo  = g.U_MIS_UnitNo

WHERE 
a.CreateDate >= @A 
AND a.CreateDate <= @B


UNION 
select 
a.DocNum 'doc_num',
a.createDate 'create_date',
a.DocDate 'posting_date',
a.U_MIS_WoNo 'wo_no',
J.Subject 'subject',
CASE J.U_Mis_JobCtg
	WHEN 'A' THEN 'Schedule'
	WHEN 'B' THEN 'Unschedule'
	WHEN 'C' THEN 'Accident'
	WHEN 'D' THEN 'Addotional Job'
	WHEN 'E' THEN 'Unit Rental'
	END As 'catergory',
b.VisOrder + 1  'line',
c.U_MIS_IssuePName 'issue_purpose',
d.U_MIS_CategoryName 'job_category',
E.U_MIS_JobDesc 'job_name',
a.U_MIS_UnitNo 'unit_no',
g.U_MIS_ModeNo 'model_no',
a.U_MIS_SerialNo 'serial_no',
a.U_MIS_HoursMeter 'hours_meter',
b.ItemCode 'item_code',
b.Dscription 'description',
b.Quantity 'qty',
A.U_MIS_Project 'project',
f.WhsName,
a.U_MIS_NoBA,
a.U_MIS_OrderType,
''[Status Doc],
''[GR No],
h.DocNum 'M Ret No',
i.ItemCode,
i.Dscription,
i.Quantity,
a.Comments
from ODLN a
inner join DLN1 b on a.DocEntry =  b.DocEntry
Left Join RDN1 i on B.DocEntry=i.BaseEntry AND b.ItemCode=i.ItemCode
Left Join ORDN H on h.DocEntry=i.DocEntry 
Left Join OSCL	J on a.U_MIS_WoNo=J.DocNum
left join [@MIS_ISSUEPURPOSE] c on a.U_MIS_IssuePurpose = c.U_MIS_IssuePCode
left join [@MIS_JOBCATEGORY] d on a.U_MIS_JobCategory = d.U_MIS_CategoryCode
left join [@MIS_JOBCODE] e on a.U_MIS_JobCode = e.U_MIS_JobCode
left join OWHS f on b.WhsCode = f.WhsCode
left join OITM g on a.U_MIS_UnitNo  = g.U_MIS_UnitNo

WHERE 
a.CreateDate >= @A 
AND a.CreateDate <= @B


UNION
select 
a.DocNum 'doc_num',
a.createDate 'create_date',
a.DocDate 'posting_date',
d.U_MIS_WoNo 'wo_no',
e.Subject 'subject',
CASE e.U_Mis_JobCtg
	WHEN 'A' THEN 'Schedule'
	WHEN 'B' THEN 'Unschedule'
	WHEN 'C' THEN 'Accident'
	WHEN 'D' THEN 'Addotional Job'
	WHEN 'E' THEN 'Unit Rental'
	END As 'Category',
b.VisOrder + 1  'Line',
c.U_MIS_IssuePName 'Issue Purpose',
NULL 'Job Category',
NULL 'Job Name',
b.U_MIS_UnitNo 'unit_no',
f.U_MIS_ModeNo 'model_no',
a.U_MIS_SerialNo 'serial_no',
a.U_MIS_HoursMeter 'hours_meter',
b.ItemCode 'item_code',
b.Dscription 'description',
b.Quantity 'qty',
b.Project 'project',
NULL,
NULL,
a.U_MIS_OrderType,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
a.Comments
from OPCH a
inner join PCH1 b on a.DocEntry =b.DocEntry
left join ORDR d on b.U_MISMRNO =d.Docnum
left join OSCL e on d.u_mis_wono=e.docnum
left join [@MIS_ISSUEPURPOSE] c on a.U_MIS_IssuePurpose = c.U_MIS_IssuePCode
left join OITM f on b.U_MIS_UnitNo  = f.U_MIS_UnitNo
WHERE (b.ItemCode ='SV-CONSUMABLEPART' OR b.ItemCode ='SV-LABOUR' OR b.ItemCode ='SV-MILEAGE')AND
a.CreateDate >= @A AND a.CreateDate <= @B