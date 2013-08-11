--切换数据库
use EmpDB
go

--创建存储过程
--A 组
--1、根据不同条件查询员工信息
create proc p_GetEmps
@emp_cd varchar(20)=null,
@emp_name varchar(20)=null,
@dept_cd varchar(20)=null,
@pj_cd varchar(20)=null,
@contract_class  varchar(5)=null,
@marry varchar(20)=null
as
declare @sql varchar(2000),@where varchar(1000)
--  编号  姓名  部门  职务  工程  员工区分    婚姻状况   状态
set @sql = 'SELECT A.emp_cd,A.emp_name,B.dept_name,C.duty_name,D.dept_name AS pj_name,
 CASE A.emp_class WHEN ''0'' THEN ''试用期'' WHEN ''1'' THEN ''正式'' END AS emp_class
 ,E.fun_name AS contract_cd,CASE A.marry WHEN ''0'' THEN ''未婚'' WHEN ''1'' THEN ''已婚'' END AS marry
 ,CASE WHEN G.fun_name IS NULL THEN ''正常''ELSE G.fun_name END AS State
FROM tb_emp A
LEFT JOIN tb_dept B ON substring(A.dept_cd,0,6) = B.dept_cd AND B.dept_class=''0''
LEFT JOIN t_duty_record C ON A.emp_cd = C.emp_cd AND C.flag=''1''
LEFT JOIN tb_dept D ON substring(A.pj_cd,0,6) = D.dept_cd AND D.dept_class=''1''
LEFT JOIN tb_com_fun E ON E.combine_cd = A.contract_class
LEFT JOIN t_vac_record_list F ON F.emp_cd = A.emp_cd AND dbo.sysdate() = F.vac_date
LEFT JOIN Tb_com_Fun G ON F.vac_Class = G.Combine_cd '
set @where='WHERE A.job_class=''0'''
if(@emp_cd is not null and @emp_cd<>'')
	set @where=@where + ' and A.emp_cd='''+@emp_cd + ''''
if(@emp_name is not null and @emp_name<>'')
	set @where=@where + ' and A.emp_name like '''+@emp_name + ''''
if(@dept_cd is not null and @dept_cd<>'')
	set @where=@where + ' and B.dept_cd='''+ @dept_cd + ''''
if(@pj_cd is not null and @pj_cd<>'')
	set @where=@where + ' and A.pj_cd like'''+@pj_cd+'%'''
if(@contract_class is not null and @contract_class<>'')
	set @where=@where + ' and A.contract_class='''+ @contract_class + ''''
if(@marry is not null and @marry<>'')
	set @where=@where + ' and A.marry='''+ @marry + ''''
set @where=@where+' order by A.emp_cd'
set @sql=@sql + @where
execute(@sql)

GO

--2、插入员工详细信息
create proc emp_detail_insert
	    @emp_name          varchar(20),      
	    @sex               varchar(20)='0',      
	    @birthday          varchar(20)=null,      
        @id_card           varchar(20)=null,      
        @marry             varchar(20)='0',      
        @diploma           varchar(20)='初中',      
	    @homeplace         varchar(20)='辽宁',      
	    @nation            varchar(20)='汉族',      
        @postalcode        varchar(20)=null,      
        @linkman           varchar(20)=null,      
        @phone             varchar(20)=null,      
        @email             varchar(20)=null,      
        @contract_class    varchar(20)=null,      
        @address           varchar(20)=null,      
        @emp_cd            varchar(20),      
        @timecard          varchar(20)=null,      
        @dept_cd           varchar(20)=null,      
        @pj_cd             varchar(20)=null,      
        @join_date         varchar(20)=null,      
        @emp_class         varchar(20)=null,      
        @forward_work_year varchar(20)=null,      
        @dorm              varchar(20)=null,      
        @bed               varchar(20)=null,      
        @emp_memo          varchar(50)=null,
        @start_date        varchar(20),     
	    @end_date          varchar(20),      
        @flag              varchar(2)='1'               
AS      
declare @sum int
declare @contract_date varchar(20)
set @contract_date=convert(varchar(20),year(@start_date)-year(@end_date))
set @sum=0
begin transaction                   
INSERT INTO tb_emp (emp_name,sex,birthday,id_card,marry,diploma,homeplace,nation,postalcode,linkman,phone,email,contract_class,address,emp_cd,timecard,dept_cd,pj_cd,join_date,emp_class,forward_work_year,dorm,bed,emp_memo,job_class,emp_date) 
VALUES (@emp_name,@sex,@birthday,@id_card,@marry,@diploma,@homeplace,@nation,@postalcode,@linkman,@phone,@email,@contract_class,@address,@emp_cd,@timecard,@dept_cd,@pj_cd,@join_date,@emp_class,@forward_work_year,@dorm,@bed,@emp_memo,'0',dateadd(month,2,@join_date))
set @sum=@sum+@@error 
INSERT INTO t_contract_record (emp_cd,start_date,end_date,flag,contract_date) 
VALUES (@emp_cd,@start_date,@end_date,@flag,@contract_date)
set @sum=@sum+@@error 
UPDATE t_duty_record SET flag = '0'WHERE flag = '1'AND EMP_CD = @emp_cd 
set @sum=@sum+@@error            
if @sum <>0 
rollback transaction
else
commit transaction

GO

--3、删除员工信息（改状态为1）
create  proc p_tb_emp_delete	
	@emp_cd          varchar(20),     
	@chkflg          int  output             
AS      
SET NOCOUNT ON
begin transaction                   
update tb_emp set job_class='1'  WHERE  emp_cd = @emp_cd
if @@error <>0 
begin
set @chkflg=1
rollback transaction
return
end	     
set @chkflg = 0                       
commit transaction	
SET NOCOUNT OFF

GO

--4、根据员工编号获取关于此员工的所有信息
create proc GetEmpByemp_cd
@emp_cd  varchar(20)
as
select * from tb_emp where emp_cd=@emp_cd 

go

--5、通过emp_cd获取合同(起,止)时间
create proc GetContractTimeByemp_cd
@emp_cd varchar(20)
as
select start_date,end_date from t_contract_record where emp_cd=@emp_cd and flag='1' 

go

--6、通过emp_cd获取职务名称
create proc GetDutyNameByemp_cd
@emp_cd varchar(20)
as
select duty_name from t_duty_record where emp_cd=@emp_cd and flag='1'

go

--7、更新员工详细信息
create proc tb_emp_update	
        @old_emp_cd       varchar(20),      --员工编号
        @id_card          varchar(20),      -- 身份证号
	    @marry            varchar(20),      -- 婚否
	    @diploma          varchar(20),      -- 学历
	    @postalcode       varchar(20),      -- 邮编
	    @linkman          varchar(20),      -- 联系人
	    @phone            varchar(20) ,     -- 联系电话
        @email            varchar(20),      -- 邮箱
        @address          varchar(20),      -- 家庭住址
        @contract_class   varchar(20),      -- 合同区分
        @dept_cd          varchar(20),      -- 部门
        @pj_cd            varchar(20),      -- 工程
        @emp_class        varchar(20),      -- 员工区分
        @dorm             varchar(20),      -- 宿舍
        @bed              varchar(20),      -- 床位
        @timecard         varchar(20),      -- 考勤卡
        @emp_memo         varchar(50)       -- 备注
AS      
	SET NOCOUNT ON
	begin transaction                   
	UPDATE tb_emp  SET 
		id_card  = @id_card,
		marry  = @marry,
		diploma = @diploma,
		postalcode  = @postalcode ,
		linkman = @linkman,
        phone = @phone,
        email = @email,
        address = @address,
        contract_class = @contract_class,
        dept_cd = @dept_cd,
        pj_cd = @pj_cd,
        emp_class = @emp_class,
        dorm  = @dorm,
        bed  = @bed,
        timecard  = @timecard,
        emp_memo  = @emp_memo
	WHERE emp_cd = @old_emp_cd
	if @@error <>0 
		begin
			rollback transaction
			return
		end	                        
	commit transaction	
	SET NOCOUNT OFF
	
GO

--8、获取公司评价区分
create  proc GetCEC
as
SELECT combine_cd,fun_name
FROM tb_com_fun
WHERE fun_class_cd = '10'

GO

--9、在籍者移动查询
create proc Get_empMoveQuery 
@begindate varchar(20)='1753/01',
@enddate varchar(20)='2500/12'
as
  SELECT T6.mydate AS 月份  
          , (T6.monthStart-dd1.rbtm) as  月初人数  
          ,(T6.monthStart+dd.joinNum-dd1.rbtm - T6.resignationNum) as 月末人数  
         , dd.joinNum as 入社人数,T6.resignationNum   as  辞职人数
          , (T6.eighteen_twenty+ dd2.eighteen_twenty) as 从18到20--从18到20  
          , (T6.twenty_five+ dd2.twenty_five) as 从20到25  
          , (T6.thirty+dd2.thirty) as 从25到30  
          , (T6.thirtyOver+dd2.thirtyOver) as 从30到以上  
          , dd4.nianling as 平均  
           ,dd3.discoverture as 已婚,dd3.marry as 未婚
         FROM (SELECT T5.mydate, T5.monthStart,T5.resignationNum,    
          T5.eighteen_twenty, T5.twenty_five, T5.thirty, T5.thirtyOver  
          FROM (SELECT T4.mydate, T4.monthStart,  
         T4.resignationNum, T4.eighteen_twenty, T4.twenty_five, T4.thirty,  
          T4.thirtyOver, ISNULL(AVG(DATEDIFF(day, I.birthday, getdate()) / 365), 0) AS average  
          FROM (SELECT T3.mydate, T3.monthStart,  
          T3.resignationNum, T3.eighteen_twenty, T3.twenty_five,   
          T3.thirty, COUNT(DateDiff(Day, H.birthday, getdate()) / 365)   
            AS thirtyOver 
          FROM (SELECT T2.mydate, T2.monthStart,   
           T2.resignationNum, T2.eighteen_twenty, T2.twenty_five,   
           COUNT(DateDiff(Day, G.birthday, getdate()) / 365)   
          AS thirty    
          FROM (SELECT T1.mydate, T1.monthStart,   
           T1.resignationNum,   
           T1.eighteen_twenty, COUNT(DATEDIFF(day,  
          F.birthday, getdate()) / 365) AS twenty_five   
          FROM (SELECT T .mydate, T .monthStart,   
          T .resignationNum,   
          COUNT(DATEDIFF(day, E.birthday,  
         getdate()) / 365)    
          AS eighteen_twenty   
         FROM (SELECT TB.mydate, TB.monthStart,   
           COUNT(D .emp_cd)    
          AS resignationNum    
           FROM (SELECT TBL.mydate,   
          TBL.monthStart  
           FROM (  
           SELECT A.mydate, 
          COUNT(B.emp_cd)   
           AS monthStart  
           FROM t_date_temp A LEFT   
          Join   
          tb_emp B ON  
          CONVERT(datetime, B.join_date) < CONVERT(datetime,A.mydate + '/01')  
          left join t_dimission_record  tr  
          on B.emp_cd = tr.emp_cd and tr.dimission_date >= CONVERT(datetime,A.mydate + '/01')  
          WHERE CONVERT(datetime,A.mydate + '/01')  >= CONVERT(datetime, @begindate+'/01')   
          AND CONVERT(datetime, A.mydate + '/01') <=CONVERT(datetime, @enddate + '/01')  
         GROUP BY A.mydate    
          ) TBL ) TB LEFT   
           JOIN t_dimission_record D ON    CONVERT(datetime,D .dimission_date)    
          >= CONVERT(datetime, TB.mydate + '/01') AND CONVERT(datetime,D .dimission_date)  
          < DATEADD(month, 1, CONVERT(datetime,TB.mydate + '/01')) GROUP BY TB.mydate, TB.monthStart  ) T  
          LEFT JOIN tb_emp E ON  E.job_class = '0' AND   
          CONVERT(datetime, E.join_date) < DATEADD(month, 1,CONVERT(datetime, T .mydate + '/01'))   
          AND DATEDIFF(day, E.birthday, getdate())/ 365 >= 18 AND DATEDIFF(day,E.birthday, getdate()) / 365 <  
           20    
          GROUP BY T .mydate, T .monthStart,T .resignationNum) T1 LEFT JOIN   
          tb_emp F ON  F.job_class = '0' AND   
          CONVERT(datetime,F.join_date) < DATEADD(month, 1,CONVERT(datetime, T1.mydate + '/01')) AND   
          DATEDIFF(day, F.birthday, getdate())/ 365 >= 20 AND DATEDIFF(day, F.birthday,  
         getdate()) / 365 < 25  GROUP BY T1.mydate, T1.monthStart,    
          T1.resignationNum, T1.eighteen_twenty) T2 LEFT JOIN  tb_emp G ON   
         G.job_class = '0' AND    
           CONVERT(datetime, G.join_date) < DATEADD(month, 1, CONVERT(datetime,T2.mydate + '/01')) AND 
          DATEDIFF(day, G.birthday,getdate()) / 365 >= 25 AND  
          DATEDIFF(day, G.birthday,getdate()) / 365 < 30  GROUP BY   
          T2.mydate, T2.monthStart,T2.resignationNum, T2.eighteen_twenty,     
          T2.twenty_five) T3 LEFT JOIN  tb_emp H ON  H.job_class = '0' AND   
          CONVERT(datetime, H.join_date) < DATEADD(month, 1, CONVERT(datetime, T3.mydate + '/01'))  
           AND DATEDIFF(day, H.birthday, getdate()) / 365 >= 30   
            GROUP BY T3.mydate, T3.monthStart,  
           T3.resignationNum, T3.eighteen_twenty, T3.twenty_five,   
            T3.thirty) T4 LEFT JOIN  
          tb_emp I ON   
           I.job_class = '0' AND CONVERT(datetime,    
          I.join_date) < DATEADD(month, 1, CONVERT(datetime,T4.mydate + '/01'))   
             AND DATEDIFF(day, I.birthday, getdate())/ 365 >= 18   
         GROUP BY T4.mydate, T4.monthStart,   
           T4.resignationNum, T4.eighteen_twenty, T4.twenty_five, T4.thirty,   
          T4.thirtyOver) T5   
         ) T6    left join(    
          select tdt.mydate,count(cc.md) as joinNum    
          from t_date_temp tdt left join (   
          select replace(convert(varchar(7),bb.join_date,111),'/','-') as md    
         from tb_emp bb    
           where   
          bb.join_date  >= CONVERT(datetime, @begindate + '/01')  
           AND bb.join_date < DATEADD(month,1,CONVERT(datetime,@enddate + '/01'))   
          )cc   
           on tdt.mydate=cc.md   
           group by  tdt.mydate   
          ) dd    
           on dd.mydate = T6.mydate    
          left join(   
          select tdt1.mydate,count(tdr.dimission_date) as rbtm  
          from t_date_temp tdt1 left join  
           t_dimission_record tdr	 
           on  tdr.dimission_date < CONVERT(datetime, tdt1.mydate + '/01') 
          where CONVERT(datetime,tdt1.mydate + '/01')  >= CONVERT(datetime,@begindate+'/01')    
          AND CONVERT(datetime, tdt1.mydate + '/01') <=CONVERT(datetime, @enddate + '/01')  
          group by tdt1.mydate  
            ) dd1  
          on dd1.mydate = T6.mydate  
           left join(  
          select d.mydate,sum(isnull(eighteen_twenty ,0)) as eighteen_twenty  
          ,sum(isnull(twenty_five ,0)) as twenty_five  
          ,sum(isnull(thirty ,0)) as thirty  
          ,sum(isnull(thirtyOver ,0)) as thirtyOver  
          from (  
          select c.mydate,case c.flag when 1 then sum(c.nianling) end as eighteen_twenty  
          ,case c.flag when  2 then sum(c.nianling) end as twenty_five  
          ,case c.flag when 3 then sum(c.nianling) end as thirty  
          ,case c.flag when 4 then sum(c.nianling) end as thirtyOver  
          from (  
          select b.mydate,isnull(b.nianling,0) as flag,isnull(count(b.nianling),0) as nianling from(  
          select tdt1.mydate, case when (DATEDIFF(day, a.birthday,CONVERT(datetime, tdt1.mydate + '/01')) /  
           365)<18  
          then 0  
          when ((DATEDIFF(day, a.birthday,CONVERT(datetime, tdt1.mydate + '/01')) / 365)<20  
          and (DATEDIFF(day, a.birthday,CONVERT(datetime, tdt1.mydate + '/01')) / 365)>=18)  
          then 1   
          when ((DATEDIFF(day, a.birthday,CONVERT(datetime, tdt1.mydate + '/01')) / 365)<25  
         and (DATEDIFF(day, a.birthday,CONVERT(datetime, tdt1.mydate + '/01')) / 365)>=20)   
          then 2  
          when ((DATEDIFF(day, a.birthday,CONVERT(datetime, tdt1.mydate + '/01')) / 365)<30  
           and (DATEDIFF(day, a.birthday,CONVERT(datetime, tdt1.mydate + '/01')) / 365)>=25) 
          then 3  
          when (DATEDIFF(day, a.birthday,CONVERT(datetime, tdt1.mydate + '/01')) / 365)>=30   
          then 4  
          end as nianling   
          from t_date_temp tdt1 left join (  
           select tb.birthday,tb.join_date,tdr.* from t_dimission_record tdr  
          inner join  tb_emp tb   
           on  tb.emp_cd = tdr.emp_cd ) a 
         on  a.dimission_date>=CONVERT(datetime, tdt1.mydate + '/01') 
         where    
           CONVERT(datetime,tdt1.mydate + '/01')  >= CONVERT(datetime,@begindate+'/01')  
          AND CONVERT(datetime, tdt1.mydate + '/01') <=CONVERT(datetime, @enddate + '/01')  
         group by tdt1.mydate, a.birthday  ) b 
          group by b.mydate,b.nianling ) c   
          group by c.mydate,c.flag ) d 
          group by d.mydate  ) dd2 
            on dd2.mydate = T6.mydate  
          left join(  
          select c.mydate,sum(isnull(c.discoverture,0)) as discoverture  
          ,sum(isnull(c.marry,0)) as marry  
          from (  
           select tddtt.mydate  
           ,case when b.marry=0 then  count(b.marry) end as discoverture 
         ,case when b.marry=1 then  count(b.marry) end as marry   
          from t_date_temp tddtt  
          left join (  
          select a.*  
         ,case when a.dimission_date is null then '2100-12-12'    
           else a.dimission_date end as dimission_dummy 
           from(select tbe.* ,td.dimission_date  
          from tb_emp tbe   
          left join t_dimission_record td  
         on tbe.emp_cd = td.emp_cd   
           ) a  
          ) b on b.dimission_dummy >= convert(datetime,tddtt.mydate+'/01')   
          and b.join_date < convert(datetime,tddtt.mydate+'/01')  
          where CONVERT(datetime,tddtt.mydate + '/01')  >= CONVERT(datetime,@begindate+'/01')  
          AND CONVERT(datetime, tddtt.mydate + '/01') <=CONVERT(datetime, @enddate + '/01')  
          GROUP BY tddtt.mydate ,b.marry  
         ) c group by c.mydate   
          ) dd3 on dd3.mydate = T6.mydate  
          left join (  
          select c.mydate,avg(c.nianling) as nianling   
          from (  
          select ttdd.mydate,b.emp_cd,  
          (DATEDIFF(day, b.birthday,CONVERT(datetime, ttdd.mydate + '/01')) / 365) as nianling  
          from t_date_temp ttdd  
          left join (  
          select a.*  
          ,case when a.dimission_date is null then '2100-12-12'   
          else a.dimission_date end as dimission_dummy  
           from(select tbe.* ,td.dimission_date  
           from tb_emp tbe  
         left join t_dimission_record td   
          on tbe.emp_cd = td.emp_cd  
         ) a  ) b  
          on b.dimission_dummy >= convert(datetime,ttdd.mydate+'/01')   
         and b.join_date < convert(datetime,ttdd.mydate+'/01')   
          where CONVERT(datetime,ttdd.mydate + '/01')  >= CONVERT(datetime,@begindate+'/01')  
         AND CONVERT(datetime, ttdd.mydate + '/01') <=CONVERT(datetime, @enddate + '/01')   
          group by ttdd.mydate,b.birthday,b.emp_cd  
           ) c 
          group by c.mydate  
          ) dd4 on dd4.mydate = T6.mydate  
           GROUP BY T6.mydate, T6.monthStart    
           , T6.resignationNum,T6.eighteen_twenty, T6.twenty_five, T6.thirty, T6.thirtyOver, dd4.nianling  
          ,dd.joinNum,dd1.rbtm  
          ,dd2.eighteen_twenty,dd2.twenty_five , dd2.thirty,dd2.thirtyOver,dd3.discoverture,dd3.marry  
         order by T6.mydate asc

GO

--10、关于员工详细页面的修改--更新合同续签表
create proc t_contract_record_insert
	@emp_cd           varchar(20),      -- 员工编号
	@start_date       varchar(20),      -- 合同起始日期
	@end_date         varchar(20)       -- 合同结束日期
AS      
	SET NOCOUNT ON
        declare @sum int
        set @sum=0
        declare @contract_date varchar(20)
        set @contract_date=Convert(varchar(20),year(@end_date)-year(@start_date))
	begin transaction 
        update t_contract_record set flag='0' where  emp_cd=@emp_cd 
        set @sum=@sum+@@error                
	INSERT INTO t_contract_record (emp_cd,start_date,end_date,flag,contract_date) 
        VALUES (@emp_cd,@start_date,@end_date,'1',@contract_date)
        set @sum=@sum+@@error
	if @sum<>0
        rollback transaction
    else
        commit transaction	
go

--11、通过dept_class获取部门和工程区分
create proc GetDeptOrPj 
@dept_class int
as
select * from tb_dept where dept_class=@dept_class
go


--12、通过emp_cd获取职务信息
create proc GetDutyByEmp_cd 
@emp_cd varchar(20)
as
select * FRoM t_duty_record where emp_cd=@emp_cd

GO

--13、获取所有职务信息--用于在下拉框里显示职务名称
create proc GetDuty
as
select * from tb_duty

go

--14、添加职务变更信息
create proc insertDutyChange
@emp_cd varchar(20),
@duty_name varchar(20),
@record_date datetime,
@record_memo varchar(50)=null
as
declare @sum int
set @sum=0

begin transaction
update t_duty_record set flag='1' where emp_cd=@emp_cd
set @sum=@sum + @@error

insert into t_duty_record values(@emp_cd,@duty_name,@record_date,@record_memo,'1')
set @sum=@sum + @@error

if @sum<>0
	rollback transaction
else
	commit transaction

GO


--15、根据条件得到工程评价信息
create proc p_GetEvaluation
@emp_cd varchar(20)=null,
@emp_name varchar(20)=null,
@dept_cd varchar(20)=null,
@pj_cd varchar(20)=null,
@evaluation_class  varchar(5)=null,
@evaluation_date varchar(20)=null
as
declare @sql varchar(2000),@where varchar(1000)
--  编号  姓名  部门  职务  工程 评价时间 评价区分 备注
set @sql = 'SELECT A.emp_cd,A.emp_name,C.dept_name,E.duty_name,D.dept_name AS pj_name,B.evaluation_date,F.fun_name,B.evaluation_memo
FROM tb_emp A
LEFT JOIN t_pj_evaluation B ON A.emp_cd=B.emp_cd AND B.flag=''1'' 
LEFT JOIN tb_dept C ON  substring(A.dept_cd,0,6) = C.dept_cd AND C.dept_class=''0''
LEFT JOIN tb_dept D ON  substring(A.pj_cd,0,6) = D.dept_cd AND D.dept_class=''1''
LEFT JOIN tb_com_fun F ON F.combine_cd = B.evaluation_class
LEFT JOIN tb_com_fun G ON G.fun_name = convert(varchar(5),MONTH(B.evaluation_date))+''月''
LEFT JOIN t_duty_record E ON A.emp_cd = E.emp_cd AND E.flag=''1'' '
set @where='WHERE A.job_class=''0'' and B.evaluation_date is not null '
if(@emp_cd is not null and @emp_cd<>'')
	set @where=@where + ' and A.emp_cd='''+@emp_cd + ''''
if(@emp_name is not null and @emp_name<>'')
	set @where=@where + ' and A.emp_name like '''+@emp_name + ''''
if(@dept_cd is not null and @dept_cd<>'')
	set @where=@where + ' and A.dept_cd like '''+ @dept_cd + '%'''
if(@pj_cd is not null and @pj_cd<>'')
	set @where=@where + ' and A.pj_cd like '''+@pj_cd+'%'''
if(@evaluation_class is not null and @evaluation_class<>'')
	set @where=@where + ' and k.evaluation_class='''+ @evaluation_class + ''''
if(@evaluation_date is not null and @evaluation_date<>'')
	set @where=@where + ' and G.combine_cd='''+ @evaluation_date + ''''
set @where=@where+' order by A.emp_cd'
set @sql=@sql + @where
execute(@sql)

go

--16、根据emp_cd获取工程评价
create proc GetPj_Ebyemp_cd
@emp_cd varchar(10)
as
select * from t_pj_evaluation e left join tb_com_fun f on e.evaluation_class=f.combine_cd left join tb_emp k on k.emp_cd=e.emp_cd
where e.emp_cd=@emp_cd

GO

--17、插入工程评价
create  proc p_t_pj_evaluation_insert 
               @emp_cd              varchar(20) ,         --员工编号 
               @date                varchar(20),          --评价日期
               @class               varchar(5),           --评价区分
               @name                varchar(20)=null,     --评价人
               @flag                int='1',              --评价区分
               @memo                varchar(50)=null,     --备注
               @chkflg              int  output           --0:success 1:fail
AS
SET NOCOUNT ON
begin transaction
declare @sum int 
set @sum=0
--更新原有的评价记录中的flag（评价区分）为0：历史记录
UPDATE t_pj_evaluation SET flag = '0'WHERE flag = '1'AND EMP_CD = @emp_cd
set @sum=@sum+@@error	                   
-- 插入新的记录	                      
insert into t_pj_evaluation( emp_cd,evaluation_date,evaluation_class,evaluation_emp_name,flag,evaluation_memo)                             
Values( @emp_cd, @date, @class, @name, @flag, @memo)
set @sum=@sum+@@error	              
if @sum <>0 
begin
rollback transaction
set @chkflg=1
return
end	
set @chkflg=0                
commit transaction
SET NOCOUNT OFF
	
GO

--18、核对评价日期是否存在
create proc Check_pj_Date 
@emp_cd varchar(20),
@date datetime,
@result int output
as
if exists(select * from t_pj_evaluation where evaluation_date=@date and emp_cd=@emp_cd)
set @result=1
else
set @result=0

GO


--19、根据条件获取公司评价
create proc p_GetCompanyEvaluation  
@emp_cd varchar(20)=null,
@emp_name varchar(20)=null,
@dept_cd varchar(20)=null,
@pj_cd varchar(20)=null,
@evaluation_class  varchar(5)=null,
@dateBegin datetime='1953-1-1',
@dateEnd datetime='9999-12-31'
as
SELECT A.emp_cd,A.emp_name,C.dept_name,E.duty_name,D.dept_name pj_name,F.fun_name,(SELECT CONVERT(varchar(10),B.evaluation_date,120))AS evaluation_date,B.evaluation_memo
FROM tb_emp A
LEFT JOIN t_comy_evaluation B ON A.emp_cd=B.emp_cd AND B.flag='1'
LEFT JOIN tb_dept C ON  substring(A.dept_cd,0,6) = C.dept_cd AND C.dept_class='0'
LEFT JOIN tb_dept D ON  substring(A.pj_cd,0,6) = D.dept_cd AND D.dept_class='1'
LEFT JOIN t_duty_record E ON A.emp_cd = E.emp_cd AND E.flag='1'
LEFT JOIN tb_com_fun F ON F.combine_cd = B.evaluation_class
WHERE A.job_class='0' and B.evaluation_date is not null 
and A.emp_cd like case when @emp_cd is not null and @emp_cd<>'' then @emp_cd else '%' end
and A.emp_name like case when @emp_name is not null and @emp_name<>'' then @emp_name else '%' end
and A.dept_cd like case when @dept_cd is not null and @dept_cd<>'' then @dept_cd+'%' else '%' end
and A.pj_cd like case when @pj_cd is not null and @pj_cd<>'' then @pj_cd+'%' else '%' end 
and B.evaluation_class like case when @evaluation_class is not null and @evaluation_class<>'' then @evaluation_class else '%' end
and B.evaluation_date>case when @dateBegin is not null and @dateBegin<>''then @dateBegin else '1753-1-1' end
and B.evaluation_date<case when @dateEnd is not null and @dateEnd<>''then @dateEnd else '9999-12-31' end

GO

--20、公司评价插入
create  proc p_t_comy_evaluation_insert 
               @emp_cd                               varchar(20) ,         --员工编号 
               @evaluation_date                      varchar(20),           --评价日期
               @evaluation_class                     varchar(5),           --评价区分
               @evaluation_emp_name                  varchar(20),           --评价人
               @flag                                 int  ,                --评价区分
               @evaluation_memo                      varchar(50),           --备注
               @chkflg                               int  output              --0:success 1:fail
AS
SET NOCOUNT ON
begin transaction
declare @sum int 
set @sum=0
   
--更新原有的评价记录中的flag（评价区分）为0：历史记录
UPDATE t_comy_evaluation SET flag = '0'WHERE flag = '1'AND EMP_CD = @emp_cd
set @sum=@sum+@@error	                   
-- 插入新的记录
insert into t_comy_evaluation( emp_cd,evaluation_date,evaluation_class,evaluation_emp_name,flag,evaluation_memo)
Values( @emp_cd, @evaluation_date, @evaluation_class, @evaluation_emp_name, @flag, @evaluation_memo)			     
set @sum=@sum+@@error			      
if @sum <>0 
	begin
	  rollback transaction
      set @chkflg=1
	  return
	end	
set @chkflg=0                
commit transaction

go

--21、根据emp_cd获取公司评价
create proc GetComy_evaluationByemp_cd 
@emp_cd varchar(20)
as
select * from t_comy_evaluation where emp_cd=@emp_cd

go

--22、核对评价日期是否已经存在
create proc Check_Com_Date 
@emp_cd varchar(20),
@date datetime,
@result int output
as
if exists(select * from t_comy_evaluation where evaluation_date=@date and emp_cd=@emp_cd)
set @result=1
else
set @result=0

GO


--B 组
---------------------------------
--        工程分配页面        -- 
---------------------------------  
--23、查询部门名称或工程名称
create proc p_GetDeptNameOrPjName 
@DeptClass varchar(10) --部门区分（0：部门；1：工程）
as
select dept_cd,dept_name from tb_dept where dept_class=@DeptClass 

go

--24、多条可为空语句查询员工
create proc GetEmps
@EmpCd varchar(20)=null,
@EmpName varchar(20)=null,
@DeptCd varchar(20)=null,
@PjCd varchar(20)=null,
@selPjCd int--未分配传1
as
declare @sql varchar(2000),@where varchar(1000)
set @sql = 'select emp_cd,emp_name,d.dept_name, 区分=case 
          when datediff(month,e.join_date,getdate())<4 THEN ''新人要员''
          when datediff(month,e.join_date,getdate())>=4 and
               datediff(month,e.join_date,getdate())<=6  THEN ''准熟练要员''
          when datediff(month,e.join_date,getdate())>6 THEN ''熟练要员''
          else null
        end 
        from tb_emp e 
        left join tb_dept d on e.pj_cd=d.dept_cd and d.dept_class=''3'''
set @where='where e.job_class=''0'''
if(@EmpCd is not null and @EmpCd <>'')
	set @where=@where + ' and emp_cd='''+@EmpCd + ''''
if(@EmpName is not null and @EmpName<>'')
	set @where=@where + ' and emp_name like '''+@EmpName + ''''
if(@DeptCd is not null and @DeptCd<>'')
	set @where=@where + ' and e.dept_cd='''+ @DeptCd + ''''
if @selPjCd = 1
        set @where=@where + ' and (e.pj_cd is null or e.pj_cd='''')'
else 
    begin
        if(@PjCd is not null and @PjCd<>'')
	set @where=@where + ' and e.pj_cd='''+ @PjCd + ''''
    end
set @sql=@sql + @where + 'order by e.emp_cd'
execute(@sql)

go

--25、根据工程名获取员工编码、姓名
create proc p_GetEmpsAndPjNames
@PjCd varchar(20)
as
select emp_cd,emp_name,dept_name from tb_emp e 
left join  tb_dept d on e.pj_cd=d.dept_cd and d.dept_class='3'
where e.job_class='0' and e.pj_cd=@PjCd 
order by e.emp_cd

go


--26、员工分配到具体的工程中
CREATE PROCEDURE p_tb_emp_update  
               @emp_cd  varchar(315) ,           --应聘员工编号 
               @pj_cd  varchar(20),              --合格：0；不合格：1
               @chkflg int  output              --0:success 1:fail
AS
declare @emp_cdTempList varchar(315)
declare @emp_cdTempSingle varchar(20)
declare @temp_Number int
            
               SET NOCOUNT ON
               begin transaction
               set @emp_cdTempList = @emp_cd
               while(charindex(',',@emp_cdTempList)>0) 
                   begin
                       set @emp_cdTempSingle = substring(@emp_cdTempList,0,charindex(',',@emp_cdTempList))
                       set @emp_cdTempList = substring(@emp_cdTempList,charindex(',',@emp_cdTempList)+1,len(@emp_cdTempList))
 	           --更新应聘员工为合格或不合格
	         
	           	UPDATE tb_emp 
		     	SET pj_cd = @pj_cd
		       	WHERE emp_cd =  @emp_cdTempSingle
	             
                   end
              set @emp_cdTempSingle = @emp_cdTempList 
	      UPDATE tb_emp 
	      SET pj_cd = @pj_cd
	      WHERE emp_cd =  @emp_cdTempSingle
              if @@error <>0 
	      	begin
		  set @chkflg=1
		  rollback transaction
		  return
		end	     
	      set @chkflg = 0 
              commit transaction
              SET NOCOUNT OFF

GO

---------------------------------
--      用户权限设置页面       -- 
---------------------------------  
--27、多条可为空语句查询用户
create proc p_GetUsers
@userCd varchar(20)=null,
@userName varchar(20)=null
as
declare @sql varchar(2000),@where varchar(2000)
set @sql='select * from tb_user'
set @where=' where 1=1 '
if(@userCd is not null and @userCd<>'')
    set @where = @where + ' and user_cd=''' + @userCd + ''''
if(@userName is not null and @userName<>'')
    set @where = @where + ' and [user_name]=''' + @userName + ''''
set @sql=@sql + @where + ' order by user_cd'
execute(@sql)

go

---------------------------------
--    用户权限设置新增页面     -- 
--------------------------------- 
--28、用户权限信息新增：p_tb_user_insert（原有）	
CREATE PROCEDURE p_tb_user_insert	
	@user_cd varchar(20),     -- 用户CD
	@user_name varchar(20),	--用户名
	@password varchar(20)	  -- 用户密码
AS      
declare @fun_cdTemp  varchar(30)	
	SET NOCOUNT ON
	begin transaction 
	INSERT INTO tb_user (user_cd,user_name,password) VALUES (@user_cd,@user_name,@password)
	--cursor define
	declare popedom_module_cur cursor local for
	select fun_cd from t_popedom_module order by id
	--open cursor
	open popedom_module_cur
	fetch next from popedom_module_cur into @fun_cdTemp
	--read cursor
	WHILE @@fetch_status=0		
	BEGIN
		INSERT INTO t_popedom (log_cd,log_name,fun_cd,popedom_class)
		VALUES(@user_cd,@user_name,@fun_cdTemp,'0')
	
		if @@error <>0 
		begin
		--set @chkFlg='0'
			rollback transaction
			close popedom_module_cur
			deallocate popedom_module_cur	
			return
		end	
	 
		--read next record
		FETCH NEXT FROM  popedom_module_cur INTO @fun_cdTemp
	END
	--close cursor
	close popedom_module_cur
	deallocate popedom_module_cur
	if @@error <>0 
		begin
			rollback transaction
			return
		end	                        
	commit transaction	
	SET NOCOUNT OFF

GO

--29、验证新添加的登录ID，保证新添加的登录ID不在用户表中已存在！
create proc p_CheckUser 
@userCd varchar(20),
@chkflg int output --0:不存在 ；1：存在
as
if(exists(select user_cd from tb_user where user_cd=@userCd))
	set @chkflg=1
else
	set @chkflg=0
	
go

---------------------------------
--    用户权限设置管理页面     -- 
--------------------------------- 
--30、获取用户所有信息（包括权限信息），通过登录ID
create proc p_GetUser
@userCd varchar(20)
as
select u.user_cd,u.[user_name],u.[password],m.fun_cd,m.fun_name,m.operation,p.popedom_class
from tb_user u, t_popedom_module m
left join t_popedom p on m.fun_cd=p.fun_cd
where u.user_cd=@userCd and u.user_cd=p.log_cd
order by u.user_cd

go

--31、用户权限更新：p_tb_popedom_update（原有）用于用户权限更新
CREATE PROCEDURE dbo.p_tb_popedom_update  
               @old_log_cd  varchar(20) ,         --用户登录ID 
               @fun_cd_str varchar(1000),           --功能编号连接串
               @chkflg int  output              --0:success 1:fail
AS
declare @fun_cdTempList varchar(1000)
declare @fun_cdTempSingle varchar(50)
            
               SET NOCOUNT ON
               begin transaction
		-- 把被设置用户的所有权限区分设为0
		UPDATE t_popedom
		SET popedom_class = '0'
		WHERE log_cd = @old_log_cd     
	
               set @fun_cdTempList = @fun_cd_str
               while (charindex(',',@fun_cdTempList)>0) 	--(len(@fun_cdTempList)>0) 
                 begin
                 set @fun_cdTempSingle = substring(@fun_cdTempList,0,charindex(',',@fun_cdTempList))
                 set @fun_cdTempList = substring(@fun_cdTempList,charindex(',',@fun_cdTempList)+1,len(@fun_cdTempList))
		 UPDATE t_popedom
		 SET popedom_class = '1'
		 WHERE log_cd = @old_log_cd
			AND fun_cd = @fun_cdTempSingle
                 end
               if @@error <>0 
		begin
			set @chkflg=1
			rollback transaction
			return
		end	     
	 set @chkflg = 0 
               commit transaction
               SET NOCOUNT OFF

GO

---------------------------------
--        招聘管理页面        -- 
--------------------------------- 
--32、获取学历或标识
create proc p_GetComFun 
@fun_class_cd varchar(20) -- 功能区分编号（4：学历；11：标识）
as 
select fun_cd,fun_name from tb_com_fun where fun_class_cd = @fun_class_cd

go

--33、多条可为空语句查询招聘人员
create proc p_GetRect  
@rectCd varchar(20)=null,
@rectName varchar(20)=null,
@idCard varchar(20)=null,
@diploma varchar(20)=null,
@rectDate1 varchar(20)=null,
@rectDate2 varchar(20)=null,
@isRect int=2,--0:未应聘；1：应聘过；2：全部
@flag varchar(20)=null
as
declare @sql varchar(2000),@conn varchar(2000),@where varchar(1000)
set @sql = 'select a.rect_date,a.rect_cd,a.rect_name,a.sex,a.birthday,a.id_card,a.diploma,a.account_address,标识=case a.flag 
          when ''0'' THEN ''合格''
          when ''1'' THEN ''不合格''
          when ''2'' THEN ''已录用''
          when '''' THEN ''''
          end from t_rect as a '
set @where=' where 1=1 '
if @isRect = 0
begin
   set @conn='inner join( select b.id_card from t_rect b group by b.id_card having count(b.id_card) = ''1'') t on a.id_card = t.id_card'
   if(@rectCd is not null and @rectCd<>'')
           set @where=@where + ' and a.rect_cd='''+@rectCd + ''''

   if(@rectName is not null and @rectName<>'')
           set @where=@where + ' and a.rect_name='''+@rectName + ''''
   if(@idCard is not null and @idCard<>'')
           set @where=@where + ' and a.id_card='''+@idCard + ''''
   if(@diploma is not null and @diploma<>'')
           set @where=@where + ' and a.diploma='''+@diploma + ''''

   if(@flag is not null and @flag<>'')
           set @where=@where + ' and a.flag='''+@flag + ''''

   if(@rectDate1 is not null and @rectDate1<>'' and @rectDate2 is not null and @rectDate2<>'')
           set @where=@where +  ' and a.rect_date > ''' + @rectDate1+ ''''+' and rect_date < '''+@rectDate2 +''''

   else if(@rectDate1 is not null and @rectDate1<>'')
           set @where=@where + ' and a.rect_date > ''' + @rectDate1+ ''''

   else if(@rectDate2 is not null and @rectDate2<>'')
           set @where=@where + ' and a.rect_date < '''+@rectDate2 +''''  
end
else if @isRect = 1
begin
   set @conn='inner join( select b.id_card from t_rect b group by b.id_card having count(b.id_card) <> ''1'') t on a.id_card = t.id_card'
   
   if(@rectCd is not null and @rectCd<>'')
           set @where=@where + ' and a.rect_cd='''+@rectCd + ''''

   if(@rectName is not null and @rectName<>'')
           set @where=@where + ' and a.rect_name='''+@rectName + ''''
   if(@idCard is not null and @idCard<>'')
           set @where=@where + ' and a.id_card='''+@idCard + ''''
   if(@diploma is not null and @diploma<>'')
           set @where=@where + ' and a.diploma='''+@diploma + ''''

   if(@flag is not null and @flag<>'')
           set @where=@where + ' and a.flag='''+@flag + ''''

   if(@rectDate1 is not null and @rectDate1<>'' and @rectDate2 is not null and @rectDate2<>'')
           set @where=@where +  ' and a.rect_date > ''' + @rectDate1+ ''''+' and rect_date < '''+@rectDate2 +''''

   else if(@rectDate1 is not null and @rectDate1<>'')
           set @where=@where + ' and a.rect_date > ''' + @rectDate1+ ''''

   else if(@rectDate2 is not null and @rectDate2<>'')
           set @where=@where + ' and a.rect_date < '''+@rectDate2 +''''  
end
else
   set @conn = ''

set @sql=@sql +@conn + @where
execute(@sql)

go

--34、招聘人员合格与否判定：p_t_rect_update（原有）
CREATE PROCEDURE dbo.p_t_rect_update  
               @rect_cd varchar(315) ,           --应聘员工编号 
               @flag  varchar(1),              --合格：0；不合格：1
               @chkflg int  output              --0:success 1:fail
AS
declare @rect_cdTempList varchar(315)
declare @rect_cdTempSingle varchar(20)
declare @temp_Number int
            
               SET NOCOUNT ON
               begin transaction
               set @rect_cdTempList = @rect_cd
               while(charindex(',',@rect_cdTempList)>0) 
                   begin
                       set @rect_cdTempSingle = substring(@rect_cdTempList,0,charindex(',',@rect_cdTempList))
                       set @rect_cdTempList = substring(@rect_cdTempList,charindex(',',@rect_cdTempList)+1,len(@rect_cdTempList))
 	           --更新应聘员工为合格或不合格
	         
	           	UPDATE t_rect 
		     	SET flag = @flag
		       	WHERE rect_cd =  @rect_cdTempSingle
	             
                   end
              set @rect_cdTempSingle = @rect_cdTempList 
	      UPDATE t_rect 
	      SET flag = @flag
	      WHERE rect_cd =  @rect_cdTempSingle
              if @@error <>0 
	      	begin
		  set @chkflg=1
		  rollback transaction
		  return
		end	     
	      set @chkflg = 0 
              commit transaction
              SET NOCOUNT OFF
GO

---------------------------------
--        导入文件页面         -- 
--------------------------------- 
--35、招聘员工新增
create proc p_RectInsert
@rect_name varchar(20),
@rect_date datetime,
@sex varchar(20),
@birthday datetime,
@id_card varchar(20),
@diploma varchar(20),
@account_address varchar(50)
as
insert into t_rect(rect_name,rect_date,sex,birthday,id_card,diploma,account_address) values(@rect_name,@rect_date,@sex,@birthday,@id_card,@diploma,@account_address)

go

---------------------------------
--          登录页面           -- 
--------------------------------- 
--36、验证用户名是否存在
create proc p_LoginCheck
@userCd varchar(20),
@chkflg int output --0：不存在；1：存在
as
if(exists(select user_cd from tb_user where user_cd=@userCd))
       select @chkflg=1
else
       select @chkflg=0
       
go

--37、登录验证
create proc p_Login
@userCd varchar(20),
@pwd varchar(20) output
as
select @pwd=[password] from tb_user where user_cd=@userCd

go

---------------------------------
--           母版页            -- 
--------------------------------- 
--38、获取用户名，通过登录ID
create proc p_GetUserName
@userCd varchar(20)
as
select [user_name] from tb_user where user_cd=@userCd

go

--------------------------------
--      用户访问页权限        --
--------------------------------
--39、获取用户的页面访问权限
create proc p_GetPopedom
@logCd varchar(20)
as
select fun_cd from t_popedom where log_cd=@logcd and popedom_class=1

go


--C 组
--40、出勤日报表相关
create proc p_Attendances_Select
@attendance_date_begin datetime=null,
@attendance_date_end datetime=null
as
SELECT TBL.day_date,COUNT(B.emp_cd) AS yearVac,COUNT(C.emp_cd) AS illVac ,COUNT(D.emp_cd) AS caseVac
 ,COUNT(E.emp_cd) AS speVac,COUNT(F.emp_cd) AS jobInjure,COUNT(G.emp_cd) AS absent,COUNT(H.emp_cd) AS whtAbsent
 ,COUNT(B.emp_cd) + COUNT(C.emp_cd) + COUNT(D.emp_cd) + COUNT(E.emp_cd) + COUNT(F.emp_cd) + COUNT(G.emp_cd) + COUNT(H.emp_cd) AS total
 ,COUNT(J.emp_cd) AS attendance,'M.matsuda' AS manager,'LiJun' AS minister,'孙大海' AS secretary
FROM (
SELECT CONVERT(varchar(10),A.attendance_date,111) AS day_date 
FROM t_chk_attendance_temp A
WHERE CONVERT(varchar(10),A.attendance_date,111) <= case when @attendance_date_end is null then CONVERT(varchar(10),A.attendance_date,111) else CONVERT(varchar(10),@attendance_date_end,111) end	--比较时转换可能是为了去掉小时和分钟，只比较天
      AND CONVERT(varchar(10),A.attendance_date,111) >= case when @attendance_date_begin is null then CONVERT(varchar(10),A.attendance_date,111) else CONVERT(varchar(10),@attendance_date_begin,111) end
GROUP BY CONVERT(varchar(10),A.attendance_date,111)) TBL
LEFT JOIN t_vac_record_list B ON TBL.day_date = B.vac_date AND B.vac_class = '13-05'
LEFT JOIN t_vac_record_list C ON TBL.day_date = C.vac_date AND C.vac_class = '13-01'
LEFT JOIN t_vac_record_list D ON TBL.day_date = D.vac_date AND D.vac_class = '13-02' 
LEFT JOIN t_vac_record_list E ON TBL.day_date = E.vac_date AND E.vac_class = '13-03' OR E.vac_class = '13-04' OR E.vac_class = '13-07'
LEFT JOIN t_vac_record_list F ON TBL.day_date = F.vac_date AND F.vac_class = '13-10'
LEFT JOIN t_vac_record_list G ON TBL.day_date = G.vac_date AND G.vac_class = '13-06'
LEFT JOIN t_vac_record_list H ON TBL.day_date = H.vac_date AND H.vac_class = '13-08'
LEFT JOIN t_chk_attendance_temp J ON TBL.day_date = J.attendance_date
GROUP BY TBL.day_date
order by TBL.day_date desc

go

--41、导入考勤数据相关
create proc Get_chk_record
as
select * from t_chk_record
order by record_time desc

go

--42、导入考勤数据
create PROCEDURE ImportWorkAttendInfo
@empCd          	varchar(20),		-- 员工编号
---- t_chk_attendance_temp 考勤临时表
@block			varchar(20)=null,	-- 卡号
@attendanceDate   	datetime,		-- 考勤日期/休假日期
@cardTimeStart		datetime=null,		-- 打卡开始时间
@cardTimeEnd		datetime=null,		-- 打卡结束时间
@overtime		decimal(5,1)=null,	-- 加班时间
@lateTime		varchar(1),		-- 迟到区分

---- t_vac_record_list 休假登记明细表
@vacClass		varchar(20)=null,
--@vacDate=@attendanceDate
@vacTime		decimal(9,2)=null,
---- tb_year_hols 年假mst
--@year=substring(@attendanceDate,1,4)
@usedDay		decimal(9,1)=null,
@chkflg                 int  output		--0:success 1:fail
AS
begin transaction
if @empCd in (select emp_cd from tb_emp)
begin
	insert into t_chk_attendance_temp values(@empCd,@block,@attendanceDate,@cardTimeStart,@cardTimeEnd,@overtime,@lateTime)

	if @vacClass is not null and @vacClass!=''
		insert into t_vac_record_list values(@empCd,@vacClass,@attendanceDate,@vacTime)

	if @usedDay is not null and @vacClass='13-05'
	begin
		if exists(select * from tb_year_hols where emp_cd=@empCd and [year]=convert(varchar(4),year(@attendanceDate)))
		begin
			update tb_year_hols set total_day=total_day-@usedDay,use_day=use_day+@usedDay
			where emp_cd=@empCd and [year]=convert(varchar(4),year(@attendanceDate))
		end
		else
			insert into tb_year_hols values(@empCd,convert(varchar(4),year(@attendanceDate)),4-@usedDay,@usedDay)
	end
end
else
begin
	set @chkflg=1
	rollback transaction
	return
end

if @@error <>0
begin
	set @chkflg=1
	rollback transaction
end
else
begin
	set @chkflg=0
end
commit transaction

go

--43、
create proc AddCheckRecord
@recordTime datetime,
@recordSum varchar(20)='0',
@flag varchar(20)
as
insert into t_chk_record values(@recordTime,@recordSum,@flag)

go

--44、加班日报表相关
create  proc GetOvertimesDaily	
@empCd varchar(20)=null,
@empName varchar(20)=null,
@deptCd varchar(20)=null,
@pjCd varchar(20)=null,
@attendanceDate datetime=null
as
select chk.emp_cd,emp_name,sy,zs,qb,one,two,three,four,five,six,seven,eight,nine,ten 
 ,eleven,twelve,thirteen,fourteen,fifteen,sixteen,seventeen,eighteen,ninteen,twenty 
 ,twentyone,twentytwo,twentythree,twentyfour,twentyfive,twentysix,twentyseven,twentyeight,twentynine,thirty,thirtyone 
 from 
 (select * from  (select  CASE WHEN (GROUPING(sy.emp_cd) = 1) THEN '合计' 
 ELSE ISNULL(sy.emp_cd, 'UNKNOWN') END AS emp_cd 
  ,CASE WHEN (GROUPING(sy.emp_name) = 1) THEN cast(count(sy.emp_name)as varchar(10)) ELSE ISNULL(sy.emp_name, 'UNKNOWN') end emp_name 
 ,sum(sy) sy,sum(zs) zs,sum(qb) qb 
 from (select te.emp_cd,te.emp_name,isnull(试用,0) sy,isnull(正式,0) zs,isnull(全部,0) qb  
 from  V_EMP_TEMP te  
WHERE 1=case when @attendanceDate is null then 1 else (case when yy = year(@attendanceDate) then 1 else 0 end) end and 1=case when @attendanceDate is null then 1 else (case when mm = month(@attendanceDate) then 1 else 0 end) end
	and 1=case when @empCd is null or @empCd='' then 1 else (case when te.emp_cd=@empCd then 1 else 0 end) end
	and 1=case when @empName is null or @empName='' then 1 else (case when te.emp_name=@empName then 1 else 0 end) end
	and 1=case when @deptCd is null or @deptCd='' then 1 else (case when te.dept_cd=@deptCd then 1 else 0 end) end
	and 1=case when @pjCd is null or @pjCd='' then 1 else (case when te.pj_cd=@pjCd then 1 else 0 end) end
 ) as sy 
 group by sy.emp_cd ,sy.emp_name with rollup ) as nsy where emp_name<>'1' or emp_cd = '合计' ) as chk 
 ,( SELECT  CASE WHEN (GROUPING(te.emp_cd) = 1) THEN '合计' 
 ELSE ISNULL(te.emp_cd, 'UNKNOWN')  END AS emp_cd 
 ,sum(isnull(VOC.one,0)) one,sum(isnull(VOC.two,0)) two  ,sum(isnull(VOC.three,0)) three,sum(isnull(VOC.four,0)) four,sum(isnull(VOC.five,0)) five  ,sum(isnull(VOC.six,0)) six,sum(isnull(VOC.seven,0)) seven,sum(isnull(VOC.eight,0)) eight 
 ,sum(isnull(VOC.nine,0)) nine,sum(isnull(VOC.ten,0)) ten  ,sum(isnull(VOC.eleven,0)) eleven,sum(isnull(VOC.twelve,0)) twelve 
 ,sum(isnull(VOC.thirteen,0)) thirteen,sum(isnull(VOC.fourteen,0)) fourteen,sum(isnull(VOC.fifteen,0)) fifteen  
 ,sum(isnull(VOC.sixteen,0)) sixteen,sum(isnull(VOC.seventeen,0)) seventeen,sum(isnull(VOC.eighteen,0)) eighteen 
 ,sum(isnull(VOC.ninteen,0)) ninteen,sum(isnull(VOC.twenty,0)) twenty  ,sum(isnull(VOC.twentyone,0)) twentyone 
 ,sum(isnull(VOC.twentytwo,0)) twentytwo,sum(isnull(VOC.twentythree,0)) twentythree,sum(isnull(VOC.twentyfour,0)) twentyfour 
 ,sum(isnull(VOC.twentyfive,0)) twentyfive  ,sum(isnull(VOC.twentysix,0)) twentysix,sum(isnull(VOC.twentyseven,0)) twentyseven 
 ,sum(isnull(VOC.twentyeight,0)) twentyeight,sum(isnull(VOC.twentynine,0)) twentynine,sum(isnull(VOC.thirty,0)) thirty  ,sum(isnull(VOC.thirtyone,0)) thirtyone 
 FROM TB_EMP TE LEFT JOIN (select * from V_OVERTIME_CALENDAR
WHERE 1=case when @attendanceDate is null then 1 else (case when [year] = year(@attendanceDate) then 1 else 0 end) end and 1=case when @attendanceDate is null then 1 else (case when [month] = month(@attendanceDate) then 1 else 0 end) end
) as voc  ON TE.EMP_CD = VOC.EMP_CD  
WHERE TE.JOB_CLASS = '0'
	and 1=case when @empCd is null or @empCd='' then 1 else (case when te.emp_cd=@empCd then 1 else 0 end) end
	and 1=case when @empName is null or @empName='' then 1 else (case when te.emp_name=@empName then 1 else 0 end) end
	and 1=case when @deptCd is null or @deptCd='' then 1 else (case when te.dept_cd=@deptCd then 1 else 0 end) end
	and 1=case when @pjCd is null or @pjCd='' then 1 else (case when te.pj_cd=@pjCd then 1 else 0 end) end
 group by te.emp_cd  with rollup ) act 
 where chk.emp_cd = act.emp_cd
order by chk.emp_cd

go

--45、获取工作时间
create proc tb_worktime_get
as
select * from tb_worktime

go

--46、补录考勤数据 相关
create proc GetEmpNameByCd
@empCd varchar(20)
as
select emp_name from  tb_emp
where emp_cd=@empCd

go

--47、获取休假类别信息
create proc GetVacClasses
as
SELECT NULL combine_cd, NULL fun_name
UNION ALL
SELECT combine_cd, fun_name
FROM tb_com_fun
WHERE fun_class_cd='13'

go

--48、补录考勤信息前，检查是否已有该记录：如果有返回1,没有返回0
create proc TheDayInsertedCheck
@empCd			varchar(20),
@attendanceDate 	datetime,
@chkflg			int		output
as
if(exists
(
select t_vac_record_list.emp_cd,t_chk_attendance_temp.emp_cd
from t_vac_record_list,t_chk_attendance_temp
where convert(varchar(10),t_vac_record_list.vac_date)=convert(varchar(10),@attendanceDate)
	and convert(varchar(10),t_chk_attendance_temp.attendance_date)=convert(varchar(10),@attendanceDate)
	and t_vac_record_list.emp_cd=@empCd and t_chk_attendance_temp.emp_cd=@empCd
)
)
	set @chkflg=1
else
	set @chkflg=0
	
go

--49、加班出勤统计相关
create proc GetOvertimesMonthly
@empCd varchar(20)=null,
@empName varchar(20)=null,
@deptCd varchar(20)=null,
@pjCd varchar(20)=null,
@attendanceDate datetime=null,
@empClass varchar(20)=null
as
SELECT A.emp_cd AS emp_cd
,A.emp_name AS emp_name
,ISNULL(SUM(T1.overtime),0) AS comOvertime
,ISNULL(SUM(T2.overtime),0) AS genOvertime
,ISNULL(SUM(T3.overtime),0) AS fdOvertime
,ISNULL(SUM(T4.overtime),0) AS proComOvertime
,ISNULL(SUM(T5.overtime),0) AS proGenOvertime
,ISNULL(SUM(T6.overtime),0) AS prodfdOvertime
,ISNULL(SUM(T1.overtime),0)+ISNULL(SUM(T2.overtime),0)+ISNULL(SUM(T3.overtime),0)+ISNULL(SUM(T4.overtime),0)+ISNULL(SUM(T5.overtime),0)+ISNULL(SUM(T6.overtime),0) AS total
FROM tb_emp A
LEFT JOIN (SELECT CONVERT(varchar(10),B.attendance_date,111) AS attendance_date,B.overtime,B.emp_cd
     FROM t_chk_attendance_temp B
     INNER JOIN tb_calendar C ON SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),1,4) = C.year  
    AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),6,2) = C.month 
    AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),9,2) = C.day 
    AND C.calendar_flag = '平日') T1
   ON A.emp_cd = T1.emp_cd
    AND 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T1.attendance_date) >= CONVERT(datetime,@attendanceDate) then 1 else 0 end) end
    AND 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T1.attendance_date) < DATEADD(month, 1,CONVERT(datetime,@attendanceDate)) then 1 else 0 end) end
    AND A.emp_class = '1'
LEFT JOIN (SELECT CONVERT(varchar(10),B.attendance_date,111) AS attendance_date,B.overtime,B.emp_cd
    FROM t_chk_attendance_temp B
    INNER JOIN tb_calendar C ON SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),1,4) = C.year  
    AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),6,2) = C.month  
    AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),9,2) = C.day 
    AND C.calendar_flag = '公休日') T2
    ON A.emp_cd = T2.emp_cd
    AND 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T2.attendance_date) >= CONVERT(datetime,@attendanceDate) then 1 else 0 end) end
    AND 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T2.attendance_date) < DATEADD(month, 1,CONVERT(datetime,@attendanceDate)) then 1 else 0 end) end
    AND A.emp_class = '1'
LEFT JOIN (SELECT CONVERT(varchar(10),B.attendance_date,111) AS attendance_date,B.overtime,B.emp_cd
    FROM t_chk_attendance_temp B
    INNER JOIN tb_calendar C ON SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),1,4) = C.year  
    AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),6,2) = C.month 
    AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),9,2) = C.day 
    AND C.calendar_flag = '法定假日') T3
    ON A.emp_cd = T3.emp_cd
    AND 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T3.attendance_date) >= CONVERT(datetime,@attendanceDate) then 1 else 0 end) end
    AND 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T3.attendance_date) < DATEADD(month, 1,CONVERT(datetime,@attendanceDate)) then 1 else 0 end) end
     AND A.emp_class = '1'
LEFT JOIN (SELECT CONVERT(varchar(10),B.attendance_date,111) AS attendance_date,B.overtime,B.emp_cd
    FROM t_chk_attendance_temp B
   left JOIN tb_calendar C ON SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),1,4) = C.year 
    AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),6,2) = C.month 
    AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),9,2) = C.day 
     AND C.calendar_flag = '平日') T4
    ON A.emp_cd = T4.emp_cd
    AND 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T4.attendance_date) >= CONVERT(datetime,@attendanceDate) then 1 else 0 end) end
    AND 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T4.attendance_date) < DATEADD(month, 1,CONVERT(datetime,@attendanceDate)) then 1 else 0 end) end
    AND A.emp_class = '0'
LEFT JOIN (SELECT CONVERT(varchar(10),B.attendance_date,111) AS attendance_date,B.overtime,B.emp_cd
	 FROM t_chk_attendance_temp B
	left JOIN tb_calendar C ON SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),1,4) = C.year  
	 AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),6,2) = C.month  
	AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),9,2) = C.day 
	 AND C.calendar_flag = '公休日') T5
	ON A.emp_cd = T5.emp_cd
    AND 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T4.attendance_date) >= CONVERT(datetime,@attendanceDate) then 1 else 0 end) end
    AND 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T4.attendance_date) < DATEADD(month, 1,CONVERT(datetime,@attendanceDate)) then 1 else 0 end) end
AND A.emp_class = '0'
LEFT JOIN (SELECT CONVERT(varchar(10),B.attendance_date,111) AS attendance_date,B.overtime,B.emp_cd 
 FROM t_chk_attendance_temp B
left JOIN tb_calendar C ON SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),1,4) = C.year 
 AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),6,2) = C.month 
 AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),9,2) = C.day 
 AND C.calendar_flag = '法定假日') T6 
  ON A.emp_cd = T6.emp_cd
    AND 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T6.attendance_date) >= CONVERT(datetime,@attendanceDate) then 1 else 0 end) end
    AND 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T6.attendance_date) < DATEADD(month, 1,CONVERT(datetime,@attendanceDate)) then 1 else 0 end) end
AND A.emp_class = '0'
WHERE A.job_class = '0'
	and 1=case when @empCd is null or @empCd='' then 1 else (case when  A.emp_cd=@empCd then 1 else 0 end) end
	and 1=case when @empName is null or @empName='' then 1 else (case when A.emp_name=@empName then 1 else 0 end) end
	and 1=case when @deptCd is null or @deptCd='' then 1 else (case when A.dept_cd=@deptCd then 1 else 0 end) end
	and 1=case when @pjCd is null or @pjCd='' then 1 else (case when A.pj_cd=@pjCd then 1 else 0 end) end
	and 1=case when @empClass is null or @empClass='' then 1 else (case when A.emp_class=(case when @empClass='01' then '1' when @empClass='02' then '0' end) then 1 else 0 end) end
GROUP BY A.emp_cd,A.emp_name

go

--50、获取月加班统计信息
create proc GetOvertimesMonthlyTotal	-- null,null,'会计部',null,null,null
@empCd varchar(20)=null,
@empName varchar(20)=null,
@deptCd varchar(20)=null,
@pjCd varchar(20)=null,
@attendanceDate datetime=null,
@empClass varchar(20)=null
as
SELECT '合计' AS emp_cd,CONVERT(varchar(10),COUNT(emp_name))+'人' AS emp_name,ISNULL(SUM(comOvertime),0) AS comOvertime,
ISNULL(SUM(genOvertime),0) AS genOvertime,ISNULL(SUM(fdOvertime),0) AS fdOvertime,
ISNULL(SUM(proComOvertime),0) AS proComOvertime,ISNULL(SUM(proGenOvertime),0) AS proGenOvertime,
ISNULL(SUM(prodfdOvertime),0) AS prodfdOvertime,ISNULL(SUM(total),0) AS total
FROM (
SELECT A.emp_cd AS emp_cd --'工号
,A.emp_name AS emp_name --'姓名
,ISNULL(T1.overtime,0) AS comOvertime --'一般加班
,ISNULL(T2.overtime,0) AS genOvertime --'公休加班
,ISNULL(T3.overtime,0) AS fdOvertime --'法定假日加班
,ISNULL(T4.overtime,0) AS proComOvertime --'试用期一般加班
,ISNULL(T5.overtime,0) AS proGenOvertime --'试用期公休加班
,ISNULL(T6.overtime,0) AS prodfdOvertime --'试用期法定假日加班
,ISNULL(T1.overtime,0)+ISNULL(T2.overtime,0)+ISNULL(T3.overtime,0)+ISNULL(T4.overtime,0)+ISNULL(T5.overtime,0)+ISNULL(T6.overtime,0) AS total --'合计
FROM tb_emp A
LEFT JOIN
(select T1tst.emp_cd,sum(T1tst.overtime) as overtime
from
	(SELECT CONVERT(varchar(10),B.attendance_date,111) AS attendance_date,B.overtime,B.emp_cd
	FROM t_chk_attendance_temp B
	INNER JOIN tb_calendar C
	ON SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),1,4) = C.year  
	AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),6,2) = C.month 
	AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),9,2) = C.day 
	AND C.calendar_flag = '平日') T1tst
where 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T1tst.attendance_date) >= CONVERT(datetime,@attendanceDate) then 1 else 0 end) end
	AND 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T1tst.attendance_date) < DATEADD(month, 1,CONVERT(datetime,@attendanceDate)) then 1 else 0 end) end
group by T1tst.emp_cd
) T1 on A.emp_cd = T1.emp_cd
	AND A.emp_class = '1'
LEFT JOIN
(select T2tst.emp_cd,sum(T2tst.overtime) as overtime
from
	(SELECT CONVERT(varchar(10),B.attendance_date,111) AS attendance_date,B.overtime,B.emp_cd
	FROM t_chk_attendance_temp B
	INNER JOIN tb_calendar C ON SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),1,4) = C.year  
	AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),6,2) = C.month  
	AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),9,2) = C.day 
	AND C.calendar_flag = '公休日') T2tst
where 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T2tst.attendance_date) >= CONVERT(datetime,@attendanceDate) then 1 else 0 end) end
	AND 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T2tst.attendance_date) < DATEADD(month, 1,CONVERT(datetime,@attendanceDate)) then 1 else 0 end) end
group by T2tst.emp_cd
) T2 ON A.emp_cd = T2.emp_cd
	AND A.emp_class = '1'
LEFT JOIN
(select T3tst.emp_cd,sum(T3tst.overtime) as overtime
from
	(SELECT CONVERT(varchar(10),B.attendance_date,111) AS attendance_date,B.overtime,B.emp_cd
	FROM t_chk_attendance_temp B
	INNER JOIN tb_calendar C ON SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),1,4) = C.year  
	AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),6,2) = C.month 
	AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),9,2) = C.day 
	AND C.calendar_flag = '法定假日') T3tst
where 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T3tst.attendance_date) >= CONVERT(datetime,@attendanceDate) then 1 else 0 end) end
	AND 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T3tst.attendance_date) < DATEADD(month, 1,CONVERT(datetime,@attendanceDate)) then 1 else 0 end) end
group by T3tst.emp_cd
) T3 ON	A.emp_cd = T3.emp_cd
	AND A.emp_class = '1'
LEFT JOIN
(select T4tst.emp_cd,sum(T4tst.overtime) as overtime
from
	(SELECT CONVERT(varchar(10),B.attendance_date,111) AS attendance_date,B.overtime,B.emp_cd
	FROM t_chk_attendance_temp B
	INNER JOIN tb_calendar C ON SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),1,4) = C.year 
	AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),6,2) = C.month 
	AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),9,2) = C.day 
	AND C.calendar_flag = '平日') T4tst
where 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T4tst.attendance_date) >= CONVERT(datetime,@attendanceDate) then 1 else 0 end) end
	AND 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T4tst.attendance_date) < DATEADD(month, 1,CONVERT(datetime,@attendanceDate)) then 1 else 0 end) end
group by T4tst.emp_cd
) T4 ON	A.emp_cd = T4.emp_cd
	AND A.emp_class = '0'
LEFT JOIN
(select T5tst.emp_cd,sum(T5tst.overtime) as overtime
from
	(SELECT CONVERT(varchar(10),B.attendance_date,111) AS attendance_date,B.overtime,B.emp_cd
	FROM t_chk_attendance_temp B
	INNER JOIN tb_calendar C ON SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),1,4) = C.year  
	AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),6,2) = C.month  
	AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),9,2) = C.day 
	AND C.calendar_flag = '公休日') T5tst
where 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T5tst.attendance_date) >= CONVERT(datetime,@attendanceDate) then 1 else 0 end) end
	AND 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T5tst.attendance_date) < DATEADD(month, 1,CONVERT(datetime,@attendanceDate)) then 1 else 0 end) end
group by T5tst.emp_cd
) T5 ON	A.emp_cd = T5.emp_cd
	AND A.emp_class = '0'
LEFT JOIN
(select T6tst.emp_cd,sum(T6tst.overtime) as overtime
from
	(SELECT CONVERT(varchar(10),B.attendance_date,111) AS attendance_date,B.overtime,B.emp_cd 
	FROM t_chk_attendance_temp B
	INNER JOIN tb_calendar C ON SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),1,4) = C.year 
	AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),6,2) = C.month 
	AND SUBSTRING(CONVERT(varchar(10),B.attendance_date,111),9,2) = C.day 
	AND C.calendar_flag = '法定假日') T6tst
where 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T6tst.attendance_date) >= CONVERT(datetime,@attendanceDate) then 1 else 0 end) end
	AND 1=case when @attendanceDate is null then 1 else (case when CONVERT(datetime, T6tst.attendance_date) < DATEADD(month, 1,CONVERT(datetime,@attendanceDate)) then 1 else 0 end) end
group by T6tst.emp_cd
) T6 ON	A.emp_cd = T6.emp_cd
	AND A.emp_class = '0'
WHERE A.job_class = '0'
	and 1=case when @empCd is null or @empCd='' then 1 else (case when  A.emp_cd=@empCd then 1 else 0 end) end
	and 1=case when @empName is null or @empName='' then 1 else (case when A.emp_name=@empName then 1 else 0 end) end
	and 1=case when @deptCd is null or @deptCd='' then 1 else (case when A.dept_cd=@deptCd then 1 else 0 end) end
	and 1=case when @pjCd is null or @pjCd='' then 1 else (case when A.pj_cd=@pjCd then 1 else 0 end) end
	and 1=case when @empClass is null or @empClass='' then 1 else (case when A.emp_class=(case when @empClass='01' then '1' when @empClass='02' then '0' end) then 1 else 0 end) end
) TBL

go

--51、
create proc GetEmpClasses
as
select emp_class=null,fun_name=null
union
select case combine_cd when '7-01' then '1' when '7-02' then '0' end,fun_name from tb_com_fun
where fun_class_cd='7'

go

--52、考勤月报表 相关
create proc GetAttendancesMonthly
@empCd varchar(20)=null,
@empName varchar(20)=null,
@deptCd varchar(20)=null,
@pjCd varchar(20)=null,
@attendanceDate datetime=null
as
select emp.*,one,two,three,four,five,six,seven,eight,nine,ten ,eleven,twelve,thirteen,fourteen,fifteen,sixteen 
,seventeen,eighteen,ninteen,twenty ,twentyone,twentytwo,twentythree,twentyfour,twentyfive,twentysix,twentyseven 
,twentyeight,twentynine,thirty,thirtyone,ew.kg,ew.wgkg,ew.bj,ew.hj,ew.cj,ew.sj,ew.gs,ew.shj,ew.cd,ew.use_day,ew.left_day 
from ( 
        SELECT 
        te.emp_cd,
        te.emp_name,
        C.dept_name,
        D.dept_name AS pj_name,
        convert(varchar(30),te.join_date,111 ) join_date 
        FROM TB_EMP te  
        LEFT JOIN tb_dept C ON te.dept_cd = C.dept_cd AND C.dept_class='0' 
        LEFT JOIN tb_dept D ON te.pj_cd = D.dept_cd AND D.dept_class='3' 
and te.job_class = 0 
	and 1=case when @empCd is null or @empCd='' then 1 else (case when te.emp_cd=@empCd then 1 else 0 end) end
	and 1=case when @empName is null or @empName='' then 1 else (case when te.emp_name=@empName then 1 else 0 end) end
	and 1=case when @deptCd is null or @deptCd='' then 1 else (case when te.dept_cd=@deptCd then 1 else 0 end) end
	and 1=case when @pjCd is null or @pjCd='' then 1 else (case when te.pj_cd=@pjCd then 1 else 0 end) end
) as emp, ( 
select tt.*,vv.kg,vv.wgkg,vv.bj,vv.hj,vv.cj,vv.sj,vv.gs,vv.shj,vv.cd,vv.use_day,vv.left_day from
(select te.* from V_EMPWORKCALENDAR te 
where 1=case when @attendanceDate is null then 1 else (case when te.[year] = year(@attendanceDate) then 1 else 0 end) end and 1=case when @attendanceDate is null then 1 else (case when te.[month] = month(@attendanceDate) then 1 else 0 end) end
	and 1=case when @empCd is null or @empCd='' then 1 else (case when te.emp_cd=@empCd then 1 else 0 end) end
	and 1=case when @empName is null or @empName='' then 1 else (case when te.emp_name=@empName then 1 else 0 end) end
	and 1=case when @deptCd is null or @deptCd='' then 1 else (case when te.dept_cd=@deptCd then 1 else 0 end) end
	and 1=case when @pjCd is null or @pjCd='' then 1 else (case when te.pj_cd=@pjCd then 1 else 0 end) end
) tt 
left join V_VAC_INFO vv 
 on tt.emp_cd = vv.emp_cd 
 and tt.year = vv.yy 
 and tt.month = vv.mm 
 and 1=case when @attendanceDate is null then 1 else (case when vv.yy = year(@attendanceDate) then 1 else 0 end) end and 1=case when @attendanceDate is null then 1 else (case when vv.mm = month(@attendanceDate) then 1 else 0 end) end
) as ew where emp.emp_cd = ew.emp_cd

go


--D 组
--53、根据员工编号获取员工姓名
create proc GetEmpNameByEmpId
@empid varchar(20)=null
as
select emp_name from tb_emp where emp_cd=@empid
go

--54、根据员工的编号、姓名、部门等信息获取员工的详细信息

create proc GetEmpsAndDutyName 
@eid varchar(20)=null,
@name varchar(20)=null,
@deptid varchar(20)=null,
@pjid varchar(20)=null
as
declare @sql varchar(2000),@where varchar(1000)
set @sql = 'select A.emp_cd,A.emp_name, case A.emp_class when ''0'' then ''试用期'' else ''正式'' end as emp_class, C.dept_name,B.duty_name,D.dept_name as pj_name  
from tb_emp A 
left join t_duty_record B on B.emp_cd=A.emp_cd and B.flag=''1''
left join tb_dept C on substring(A.dept_cd,0,6) = C.dept_cd and dept_class=''0''
left join tb_dept D on A.pj_cd = D.dept_cd  '
set @where='where A.job_class=''0'' '
if(@eid is not null and @eid<>'')
	set @where=@where + ' and A.emp_cd='''+@eid + ''''
if(@name is not null and @name<>'')
	set @where=@where + ' and A.emp_name like '''+@name + ''''
if(@deptid is not null and @deptid<>'')
	set @where=@where + ' and substring(A.dept_cd,0,6)='''+ substring(@deptid,0,6) + ''''
if(@pjid is not null and @pjid<>'')
	set @where=@where + ' and A.pj_cd='''+ @pjid + ''''
set @sql=@sql + @where
execute(@sql)

go

--55、根据合同日期获取员工信息
create proc GetEmpInfoByContractDate 
@eid varchar(20)=null,
@name varchar(20)=null,
@deptid varchar(20)=null,
@pjid varchar(20)=null,
@dateBegin datetime='1953-1-1',     
@dateEnd datetime='9999-12-31'
as
select A.emp_cd,A.emp_name, case A.emp_class when '0' then '试用期' else '正式' end as emp_class, C.dept_name,B.duty_name,D.dept_name as pj_name  
from tb_emp A 
left join t_duty_record B on B.emp_cd=A.emp_cd and B.flag='1'
left join tb_dept C on substring(A.dept_cd,0,6) = C.dept_cd and dept_class='0'
left join tb_dept D on A.pj_cd = D.dept_cd 
left join t_contract_record E on A.emp_cd=E.emp_cd 
where A.job_class='0'and E.flag='1' and 
E.start_date between @dateBegin and @dateEnd and 
E.end_date between @dateBegin and @dateEnd and 
A.emp_cd like case when @eid is not null and @eid<>'' then @eid else '%' end and 
A.emp_name like case when @name is not null and @name<>'' then @name else '%' end  and 
substring(A.dept_cd,0,6) like case when @deptid is not null and @deptid<>'' then @deptid else '%' end and 
A.pj_cd like case when @pjid is not null and @pjid<>'' then @pjid else '%' end

go

--56、根据员工编号和要查询的月份，获取员工加班信息
create proc GetMonthTotalInfoSql
@emp_cd varchar(10)=null,
@datetime varchar(10)=null
as
set @datetime=@datetime+'/01'
select emp_cd,emp_name 
        ,isnull(sum(case when attendance_date>=emp_date  and calendar_flag='平日' 
        then overtime end ) 
        ,0) as '一般加班' 
        ,isnull(sum(case when  attendance_date>=join_date and attendance_date<emp_date and calendar_flag='平日' 
        then overtime end ) 
        ,0) as '试用期一般加班' 
        ,isnull(sum(case when attendance_date>=emp_date  and (calendar_flag='公休日' or calendar_flag='法定假日') 
        then overtime end ) 
        ,0) as '公休加班' 
        ,isnull(sum(case when  attendance_date>=join_date and attendance_date<emp_date 
        and (calendar_flag='公休日' or calendar_flag='法定假日') then overtime end ) ,0) as '试用期公休加班' 
        ,isnull(sum(overtime),0) as '全部' 
        from 
        (select isnull(tcat.emp_cd,@emp_cd) as emp_cd 
         ,tcat.emp_name 
        ,isnull(overtime,0) as overtime 
        ,attendance_Date 
        ,join_date 
        ,emp_date 
        ,calendar_flag 
        from tb_calendar tc 
        left join 
        (select tca.emp_cd,te.emp_name 
        ,tca.attendance_Date 
        ,datepart(yy,attendance_Date) as yy 
        ,datepart(mm,attendance_Date) as mm 
        ,datepart(dd,attendance_Date) as dd 
        ,overtime 
        ,join_date 
        ,emp_date 
        from  t_chk_attendance_temp tca 
        left join 
        (select emp_cd,emp_name 
        ,join_date 
        ,isnull(emp_date,getdate()) as emp_date 
        from tb_emp) te 
        on tca.emp_cd = te.emp_cd) tcat 
        on tc.year = tcat.yy and tc.month = tcat.mm and tc.day =tcat.dd 
        where isnull(tcat.emp_cd,@emp_cd)=@emp_cd 
        and  tc.year =year(@datetime)
        and  tc.month =month(@datetime) 
        and  attendance_Date is not null) as aa 
        group by emp_cd,emp_name 
go


--57、根据员工编号和查询月份，获取员工的休假信息
create proc GetSearchChkInfoSql --'0001','2008/08'
@emp_cd varchar(10)=null,
@datetime varchar(10)=null
as
set @datetime=@datetime+'/01'
select tt.*,vv.kg,vv.wgkg,vv.bj,vv.hj,vv.cj,vv.sj,vv.gs,vv.shj,vv.cd,vv.use_day,vv.left_day from
         (select a.* from V_EMPWORKCALENDAR a 
         where a.year = year(@datetime)  and  a.month = month(@datetime)
        
        ) tt 
         left join V_VAC_INFO vv 
         on tt.emp_cd = vv.emp_cd 
         and tt.year = vv.yy 
         and tt.month = vv.mm 
        and vv.yy = year(@datetime)  and  vv.mm =  month(@datetime)
	where tt.emp_cd=@emp_cd

go


--58、根据员工编号及年月获取员工的加班信息
create   proc GetSearchConInfoSql 
@emp_cd varchar(10)=null,
@datetime varchar(10)=null
as
set @datetime=@datetime+'/01'
select emp_cd 
        ,emp_name 
        ,count(case when attendance_date>=join_date 
        and attendance_date<emp_date then 1 end) as 试用 
        ,count(case when attendance_date>=emp_date then 1 end) as 正式 
        ,count(*) as 全部 
        from 
        (select te.emp_cd 
        ,te.emp_name 
        ,join_date 
        ,isnull(emp_date,getdate()) as emp_date 
        ,attendance_date 
        from 
        tb_emp te 
        left join 
        (select 
        emp_cd,attendance_date as attendance_date 
        from t_chk_attendance_temp) 
        tcat 
        on te.emp_cd = tcat.emp_cd 
        where te.emp_cd =@emp_cd) aa 
        where datepart(yy,attendance_date) =year(@datetime)
        and datepart(mm,attendance_date) =month(@datetime)
        group by emp_cd,emp_name 
        
go

--59、根据员工编号获取员工的合同开始日和结束日期
create  proc GetContractTimeByemp_cd 
@emp_cd varchar(20)=null
as
select start_date,end_date from t_contract_record where emp_cd=@emp_cd and flag='1' 

go


--60、根据员工编号获取员工离职的详细信息
create proc GetResignationEmpInfobyId 
@empid varchar(20)=null
as
select A.emp_cd,emp_name,datename(year,join_date)+'/'+datename(month,join_date)+'/'+datename(day,join_date) as join_date,
datename(year,start_date)+'/'+datename(month,start_date)+'/'+datename(day,start_date) as start_date,
datename(year,end_date)+'/'+datename(month,end_date)+'/'+datename(day,end_date) as end_date,C.dept_name,D.dept_name as pj_name,
datename(year,dimission_date)+'/'+datename(month,dimission_date)+'/'+datename(day,dimission_date) as dimission_date,E.emp_card,E.timecard,E.wage_card,E.tools,E.ark_key,E.dorm_key,E.dimission_memo
from t_contract_record A,t_dimission_record E, tb_emp B left join tb_dept C on substring(B.dept_cd,0,6) = C.dept_cd
left join tb_dept D on B.pj_cd = D.dept_cd 
where A.emp_cd=B.emp_cd and A.flag=1 and A.emp_cd=@empid and B.emp_cd=E.emp_cd

go

--61、根据部门区分获取部门名和工程名
create proc GetDeptOrPj 
@dept_class int=null
as
select * from tb_dept where dept_class=@dept_class

go

--62、根据员工编号获取员工的职务名称
create proc GetDutyNameByemp_cd
@emp_cd varchar(20)=null
as
select duty_name from t_duty_record where emp_cd=@emp_cd and flag='1'

go

--63、根据员工编号获取员工信息
create proc GetEmpInfobyId 
@empid varchar(20)=null
as
select a.emp_cd,emp_name,datename(year,join_date)+'/'+datename(month,join_date)+'/'+datename(day,join_date) as join_date,
datename(year,start_date)+'/'+datename(month,start_date)+'/'+datename(day,start_date) as start_date,
datename(year,end_date)+'/'+datename(month,end_date)+'/'+datename(day,end_date) as end_date,c.dept_name,d.dept_name as pj_name
from t_contract_record a,tb_emp b left join tb_dept C on substring(b.dept_cd,0,6) = C.dept_cd
left join tb_dept D on b.pj_cd = D.dept_cd 
where a.emp_cd=b.emp_cd and a.flag=1 and a.emp_cd=@empid

go

--64、根据员工编号获取合同履历
create proc GetContractRecord
@emp_cd varchar(20)=null
as
select datename(year,start_date)+'-'+datename(month,start_date)+'-'+datename(day,start_date)  as 鉴定日期,datename(year,end_date)+'-'+datename(month,end_date)+'-'+datename(day,end_date) as  '结束日期',contract_date '合同期（年）',contract_memo '备注'
from t_contract_record
where emp_cd=@emp_cd

GO
 
--65、根据员工编号获取在职员工的员工编号，姓名，部门和工程名称
create proc GetSearchEmpInfoSql
@emp_cd varchar(10)=null
as
SELECT  A.emp_cd,
	A.emp_name,
        C.dept_name,
        D.dept_name AS pj_name,
        convert(varchar(30),A.join_date,111 ) join_date 
        FROM TB_EMP A 
        LEFT JOIN tb_dept C ON A.dept_cd = C.dept_cd AND C.dept_class='0' 
        LEFT JOIN tb_dept D ON  A.pj_cd = D.dept_cd AND D.dept_class='3' 
        WHERE job_class='0' and A.emp_cd=@emp_cd

go

--66、根据员工编号获取姓名，考勤查询信息（试用期合计，正式合计，总合计）
create proc GetSearchConInfoSql 
@emp_cd varchar(10)=null,
@datetime varchar(10)=null
as
set @datetime=@datetime+'/01'
select emp_cd 
        ,emp_name 
        ,count(case when attendance_date>=join_date 
        and attendance_date<emp_date then 1 end) as 试用 
        ,count(case when attendance_date>=emp_date then 1 end) as 正式 
        ,count(*) as 全部 
        from 
        (select te.emp_cd 
        ,te.emp_name 
        ,join_date 
        ,isnull(emp_date,getdate()) as emp_date 
        ,attendance_date 
        from 
        tb_emp te 
        left join 
        (select 
        emp_cd,attendance_date as attendance_date 
        from t_chk_attendance_temp) 
        tcat 
        on te.emp_cd = tcat.emp_cd 
        where te.emp_cd =@emp_cd) aa 
        where datepart(yy,attendance_date) =year(@datetime)
        and datepart(mm,attendance_date) =month(@datetime)
        group by emp_cd,emp_name 
        
go

--67、根据员工编号和日期 获取加班信息
create  proc GetSearchOverTimeSql
@emp_cd varchar(10)=null,
@datetime varchar(10)=null
as
set @datetime=@datetime+'/01'
select  
         sum(isnull(case when day=1 then overtime end,0)) as one 
        , sum(isnull( case when day=2 then overtime end,0)) as two 
        , sum(isnull( case when day=3 then overtime end,0)) as three 
        , sum(isnull( case when day=4 then overtime end,0)) as four 
        , sum(isnull( case when day=5 then overtime end,0)) as five 
        , sum(isnull( case when day=6 then overtime end,0)) as six 
        , sum(isnull( case when day=7 then overtime end,0)) as seven 
        , sum(isnull( case when day=8 then overtime end,0)) as eight 
        , sum(isnull( case when day=9 then overtime end,0)) as nine 
        , sum(isnull( case when day=10 then overtime end,0)) as ten 
        , sum(isnull( case when day=11 then overtime end,0)) as eleven 
        , sum(isnull( case when day=12 then overtime end,0)) as twelve 
        , sum(isnull( case when day=13 then overtime end,0)) as thirteen 
        , sum(isnull( case when day=14 then overtime end,0)) as fourteen 
        , sum(isnull( case when day=15 then overtime end,0)) as fifteen 
        , sum(isnull( case when day=16 then overtime end,0)) as sixteen 
        ,sum(isnull( case when day=17 then overtime end,0)) as seventeen 
        ,sum(isnull( case when day=18 then overtime end,0)) as eighteen 
        ,sum(isnull( case when day=19 then overtime end,0)) as ninteen 
        ,sum(isnull( case when day=20 then overtime end,0))  as twenty 
        ,sum(isnull( case when day=21 then overtime end,0))  as twentyone 
        ,sum(isnull( case when day=22 then overtime end,0)) as twentytwo 
        ,sum(isnull( case when day=23 then overtime end,0))  as twentythree 
        ,sum(isnull( case when day=24 then overtime end,0))  as twentyfour 
        ,sum(isnull( case when day=25 then overtime end,0))  as twentyfive 
        ,sum(isnull( case when day=26 then overtime end,0))  as twentysix 
        ,sum(isnull( case when day=27 then overtime end,0))  as twentyseven 
        ,sum(isnull( case when day=28 then overtime end,0))  as twentyeight 
        ,dbo.Get_monthMaxDay(year,month,29, 
         sum(isnull( case when day=29 then overtime end,0)) )  as twentynine 
        ,dbo.Get_monthMaxDay(year,month,30,sum(isnull( case when day=30 then overtime end,0))  ) as thirdty 
        ,dbo.Get_monthMaxDay(year,month,31,sum(isnull( case when day=31 then overtime end,0))  )  as thirdtyone 
         from ( select isnull(tcat.emp_cd,@emp_cd) as emp_cd,isnull(overtime,0) as overtime,tc.year ,tc.month,tc.day 
         from tb_calendar tc 
        left join ( select emp_cd,convert(varchar(10),attendance_Date,111) as attendance_Date ,datepart(yy,attendance_Date) as yy ,datepart(mm,attendance_Date) as mm ,datepart(dd,attendance_Date) as dd ,overtime 
          from  t_chk_attendance_temp ) tcat on tc.year = tcat.yy and tc.month = tcat.mm and tc.day =tcat.dd 
        where isnull(tcat.emp_cd,@emp_cd)=@emp_cd 
        and  tc.year =year(@datetime)		--' strContract.Split(''/'')(0)  ' 
        and  tc.month =month(@datetime)  --cast (' strContract.Split(''/'')(1) 'as int  )
)
as aa
group by emp_cd ,year ,month 

go

--68、合同批量续签
create    PROCEDURE dbo.p_t_contract_record_insert  
               @emp_cd                               varchar(315)=null ,         --员工编号 
               @start_date                           varchar(10)=null,           --签定日期
               @contract_date                        int=null,                   --合同签订年
               @contractflag                         int=null,                   --1:批量续签，0单个续签
               @contract_memo                        varchar(50)=null,            --备注
               @chkflg                               int  output              --0:success 1:fail
AS

declare @emp_cdTempList varchar(315)
declare @emp_cdTempSingle varchar(20)
declare @temp_Number int
            
               SET NOCOUNT ON
               begin transaction
               set @emp_cdTempList = @emp_cd
               while(charindex(',',@emp_cdTempList)>0) 
                 begin
                 set @emp_cdTempSingle = substring(@emp_cdTempList,0,charindex(',',@emp_cdTempList))
                 set @emp_cdTempList = substring(@emp_cdTempList,charindex(',',@emp_cdTempList)+1,len(@emp_cdTempList))
                   select @temp_Number = count(*) from t_contract_record
                     where flag = '0'
                       and end_date = (
			  select distinct end_date from t_contract_record
			     where emp_cd = @emp_cdTempSingle
				and flag ='1'
			)
                       and EMP_CD = @emp_cdTempSingle

                   if @temp_Number>0  
                     begin
                      set @chkflg = 2
                      --return 
                     end
                   else
                     begin
	              --更新原有的合同履历记录中的flag（履历区分）为2：历史记录
	               UPDATE t_contract_record 
	                   SET FLAG = '2'
	                   WHERE FLAG = '1'   
                             AND EMP_CD = @emp_cdTempSingle
	              -- 插入新的记录
			insert into t_contract_record
			     ( emp_cd
			      ,start_date
			      ,end_date
			      ,flag
			      ,contract_date
			      ,contract_memo)
			select emp_cd
			      ,case when @contractflag =1 then end_date+1 else @start_date end start_date
			      ,case when @contractflag =1 then dateadd(year,@contract_date,case when @contractflag =1 then end_date else @start_date end )
				else dateadd(year,@contract_date,case when @contractflag =1 then end_date else @start_date end )-1 end
			      ,'1'
			      ,@contract_date
			      ,@contract_memo 
			from t_contract_record
			where emp_cd = @emp_cdTempSingle
                          and FLAG = '2'

                        UPDATE t_contract_record 
	                   SET FLAG = '0'
	                   WHERE FLAG = '2'   
                             AND EMP_CD = @emp_cdTempSingle
                 end
	end
		set @emp_cdTempSingle = @emp_cdTempList
		select @temp_Number = count(*) from t_contract_record
                     where flag = '0'
                       and end_date = (
			  select distinct end_date from t_contract_record
			     where emp_cd = @emp_cdTempSingle
				and flag ='1'
			)
                       and EMP_CD = @emp_cdTempSingle

                   if @temp_Number>0  
                     begin
                      set @chkflg = 2
                      --return 
                     end
                   else
                     begin     
                  
                       --更新原有的合同履历记录中的flag（履历区分）为2：历史记录
	               UPDATE t_contract_record 
	                   SET FLAG = '2'
	                   WHERE FLAG = '1'   
                             AND EMP_CD = @emp_cdTempSingle
                       
	              -- 插入新的记录
			insert into t_contract_record
			     ( emp_cd
			      ,start_date
			      ,end_date
			      ,flag
			      ,contract_date
			      ,contract_memo)
			select emp_cd
			      ,case when @contractflag =1 then end_date+1 else @start_date end start_date
			      ,case when @contractflag =1 then dateadd(year,@contract_date,case when @contractflag =1 then end_date else @start_date end )
				else dateadd(year,@contract_date,case when @contractflag =1 then end_date else @start_date end )-1 end
			      --,dateadd(year,@contract_date,case when @contractflag =1 then end_date else @start_date end )
			     -- ,dateadd(year,@contract_date,@start_date)
			      ,'1'
			      ,@contract_date
			      ,@contract_memo
			from t_contract_record
			where emp_cd = @emp_cdTempSingle
                          and FLAG = '2'

                        UPDATE t_contract_record 
	                   SET FLAG = '0'
	                   WHERE FLAG = '2'   
                             AND EMP_CD = @emp_cdTempSingle
	           end 


               if @@error <>0 
		begin
			set @chkflg=1
			rollback transaction
			return
		end	     
	 set @chkflg = 0 
               commit transaction
               SET NOCOUNT OFF

GO

--69、根据员工编号获取合同终止日期
create proc GetContractEndDate
@eid varchar(10)=null
as
select convert(varchar(30),end_date+1,111) end_date
from t_contract_record
where t_contract_record.emp_cd=@eid and flag='1'

GO

--70、单个合同续签
create  proc p_OneContractContinue
@eid varchar(10)=null,
@startDate datetime=null,
@endDate datetime=null,
@conDate varchar(10)=null,
@memo  varchar(50)=null
as
update t_contract_record set flag='0' where emp_cd=@eid
insert into t_contract_record values(@eid,@startDate,@endDate,'1',@conDate,@memo)

go

--71、将员工离职信息插入到离职信息表
create  proc p_tb_emp_insert  --离职登记新增
@EmpCd varchar(20),          --员工编号
@dimission_date datetime,    --离职日期
@dimission_memo varchar(50), --备注
@emp_card varchar(1),        --工作卡
@timecard varchar(1),        --考勤卡
@wage_card varchar(1),       --工资卡
@tools varchar(1),           --工具
@ark_key varchar(1),         --更衣柜钥匙
@dorm_key varchar(1)         --宿舍钥匙
as
insert into t_dimission_record 
 values(@EmpCd,@dimission_date,@dimission_memo,@emp_card,@timecard,@wage_card,@tools,@ark_key,@dorm_key)
update tb_emp set job_class='1' where emp_cd=@EmpCd

go

--72、根据编号，名称，部门及工程名称 获取离职员工信息
create  proc  GetEmpsAndDate 
@eid varchar(20)=null,
@name varchar(20)=null,
@deptid varchar(20)=null,
@pjid varchar(20)=null
as
declare @sql varchar(2000),@where varchar(1000)
set @sql = 'select A.emp_cd,A.emp_name,  C.dept_name,B.duty_name,D.dept_name as pj_name ,datename(year,A.join_date)+''/''+datename(month,A.join_date)+''/''+datename(day,A.join_date) as join_date,datename(year,E.dimission_date)+''/''+datename(month,E.dimission_date)+''/''+datename(day,E.dimission_date) as dimission_date
from tb_emp A 
left join t_duty_record B on B.emp_cd=A.emp_cd and B.flag=''1''
left join tb_dept C on substring(A.dept_cd,0,6) = C.dept_cd and dept_class=''0''
left join tb_dept D on A.pj_cd = D.dept_cd
left join t_dimission_record  E on A.emp_cd=E.emp_cd '
set @where='where A.job_class=''1'' '
if(@eid is not null and @eid<>'')
	set @where=@where + ' and A.emp_cd='''+@eid + ''''
if(@name is not null and @name<>'')
	set @where=@where + ' and A.emp_name like '''+@name + ''''
if(@deptid is not null and @deptid<>'')
	set @where=@where + ' and substring(A.dept_cd,0,6)='''+ substring(@deptid,0,6) + ''''
if(@pjid is not null and @pjid<>'')
	set @where=@where + ' and A.pj_cd='''+ @pjid + ''''
set @sql=@sql + @where
execute(@sql)

go

--73、根据编号,名称,部门及工程名称,月 获取离职员工信息和考勤信息
create proc GetResignEmpByMonth 
@eid varchar(20)=null,
@name varchar(20)=null,
@deptid varchar(20)=null,
@pjid varchar(20)=null,
@month varchar(20)=null
as
declare @sql varchar(8000),@where varchar(1000)
set @sql='
SELECT A.emp_cd AS 工号,
A.emp_name AS 姓名,
B.dept_name AS 工程,
case A.emp_class when ''0'' then ''试用期'' else ''正式'' end AS 区分,
Isnull(T1.overtime,0.0) AS 一般加班,
Isnull(T2.overtime,0.0) AS 试用期一般加班,
Isnull(T3.overtime,0.0) AS 公休加班,
Isnull(T4.overtime,0.0) AS 试用期公休加班,
Isnull(T1.overtime,0.0)+Isnull(T2.overtime,0.0)+Isnull(T3.overtime,0.0)+Isnull(T4.overtime,0.0) AS 合计,

J.vac_date AS 旷工,
K.vac_date AS 病假,
L.vac_date AS 婚假,
M.vac_date AS 产假,
N.vac_date AS 丧假,
O.vac_date AS 工伤,
P.vac_date AS 事假,
T5.late_time AS 迟到早退 

FROM tb_emp A 
LEFT JOIN tb_dept B ON A.pj_cd = B.dept_cd  

LEFT JOIN 
(select T1tst.emp_cd,sum(T1tst.overtime) as overtime 
from 
	(SELECT CONVERT(varchar(10),C.attendance_date,111) AS attendance_date,C.overtime,C.emp_cd 
	FROM t_chk_attendance_temp C 
	inner JOIN tb_calendar D 
	ON SUBSTRING(CONVERT(varchar(10),C.attendance_date,111),1,4) = D.year  
	AND SUBSTRING(CONVERT(varchar(10),C.attendance_date,111),6,2) = D.month  
	AND SUBSTRING(CONVERT(varchar(10),C.attendance_date,111),9,2) = D.day  
	AND D.calendar_flag = ''平日'') T1tst 
where CONVERT(varchar(10),T1tst.attendance_date,111) >= '''+@month+'''+''/01''  
	AND CONVERT(varchar(10),T1tst.attendance_date,111) < DATEADD(month,1,CONVERT(datetime,'''+@month+'''+''/01'')) 
group by T1tst.emp_cd
) T1 ON A.emp_cd = T1.emp_cd 
	AND A.emp_class = ''1'' 

LEFT JOIN 
(select T2tst.emp_cd,sum(T2tst.overtime) as overtime 
from 
	(SELECT CONVERT(varchar(10),D.attendance_date,111) AS attendance_date,D.overtime,D.emp_cd 
	FROM t_chk_attendance_temp D 
	inner JOIN tb_calendar E 
	ON SUBSTRING(CONVERT(varchar(10),D.attendance_date,111),1,4) = E.year  
	AND SUBSTRING(CONVERT(varchar(10),D.attendance_date,111),6,2) = E.month  
	AND SUBSTRING(CONVERT(varchar(10),D.attendance_date,111),9,2) = E.day  
	AND E.calendar_flag = ''平日'') T2tst 
where CONVERT(varchar(10),T2tst.attendance_date,111) >= '''+@month+'''+''/01'' 
	AND CONVERT(varchar(10),T2tst.attendance_date,111) < DATEADD(month,1,CONVERT(datetime,'''+@month+'''+''/01'')) 
group by T2tst.emp_cd
) T2 ON A.emp_cd = T2.emp_cd 
	AND A.emp_class = ''0'' 

LEFT JOIN 
(select T3tst.emp_cd,sum(T3tst.overtime) as overtime 
from 
	(SELECT CONVERT(varchar(10),F.attendance_date,111) AS attendance_date,F.overtime,F.emp_cd 
	FROM t_chk_attendance_temp F 
	inner JOIN tb_calendar G 
	ON SUBSTRING(CONVERT(varchar(10),F.attendance_date,111),1,4) = G.year  
	AND SUBSTRING(CONVERT(varchar(10),F.attendance_date,111),6,2) = G.month  
	AND SUBSTRING(CONVERT(varchar(10),F.attendance_date,111),9,2) = G.day 
	AND G.calendar_flag = ''公休日'') T3tst 
where CONVERT(varchar(10),T3tst.attendance_date,111) >= '''+@month+'''+''/01'' 
	AND CONVERT(varchar(10),T3tst.attendance_date,111) < DATEADD(month,1,CONVERT(datetime,'''+@month+'''+''/01'')) 
group by T3tst.emp_cd
) T3 ON A.emp_cd = T3.emp_cd 
	AND A.emp_class = ''1'' 

LEFT JOIN 
(select T4tst.emp_cd,sum(T4tst.overtime) as overtime 
from 
	(SELECT CONVERT(varchar(10),H.attendance_date,111) AS attendance_date,H.overtime,H.emp_cd 
	FROM t_chk_attendance_temp H 
	inner JOIN tb_calendar I ON SUBSTRING(CONVERT(varchar(10),H.attendance_date,111),1,4) = I.year 
	AND SUBSTRING(CONVERT(varchar(10),H.attendance_date,111),6,2) = I.month 
	AND SUBSTRING(CONVERT(varchar(10),H.attendance_date,111),9,2) = I.day 
	AND I.calendar_flag = ''公休日'') T4tst 
where CONVERT(varchar(10),T4tst.attendance_date,111) >= '''+@month+'''+''/01'' 
	AND CONVERT(varchar(10),T4tst.attendance_date,111) < DATEADD(month,1,CONVERT(datetime,'''+@month+'''+''/01'')) 
group by T4tst.emp_cd
) T4 ON A.emp_cd = T4.emp_cd 
	AND A.emp_class = ''0'' 

LEFT JOIN 
(select Jtst.emp_cd,COUNT(Jtst.vac_date) as vac_date 
from 
t_vac_record_list Jtst  
where Jtst.vac_class = ''13-06''  
AND CONVERT(varchar(10),Jtst.vac_date,111) >= '''+@month+'''+''/01''  
AND CONVERT(varchar(10),Jtst.vac_date,111) < DATEADD(month,1,CONVERT(datetime,'''+@month+'''+''/01'')) 
group by Jtst.emp_cd 
) J ON A.emp_cd = J.emp_cd  

LEFT JOIN 
(select Ktst.emp_cd,COUNT(Ktst.vac_date) as vac_date 
from 
t_vac_record_list Ktst 
where Ktst.vac_class = ''13-01'' 
AND CONVERT(varchar(10),Ktst.vac_date,111) >= '''+@month+'''+''/01'' 
AND CONVERT(varchar(10),Ktst.vac_date,111) < DATEADD(month,1,CONVERT(datetime,'''+@month+'''+''/01'')) 
group by Ktst.emp_cd 
) K ON A.emp_cd = K.emp_cd 

LEFT JOIN 
(select Ltst.emp_cd,COUNT(Ltst.vac_date) as vac_date 
from 
t_vac_record_list Ltst 
where Ltst.vac_class = ''13-03'' 
 AND CONVERT(varchar(10),Ltst.vac_date,111) >= '''+@month+'''+''/01'' 
 AND CONVERT(varchar(10),Ltst.vac_date,111) < DATEADD(month,1,CONVERT(datetime,'''+@month+'''+''/01'')) 
group by Ltst.emp_cd 
) L ON A.emp_cd = L.emp_cd  

LEFT JOIN 
(select Mtst.emp_cd,COUNT(Mtst.vac_date) as vac_date 
from 
t_vac_record_list Mtst  
where Mtst.vac_class = ''13-04''  
 AND CONVERT(varchar(10),Mtst.vac_date,111) >= '''+@month+'''+''/01''  
 AND CONVERT(varchar(10),Mtst.vac_date,111) < DATEADD(month,1,CONVERT(datetime,'''+@month+'''+''/01'')) 
group by Mtst.emp_cd 
) M ON A.emp_cd = M.emp_cd   

LEFT JOIN 
(select Ntst.emp_cd,COUNT(Ntst.vac_date) as vac_date  
from 
t_vac_record_list Ntst 
where Ntst.vac_class = ''13-07''  
 AND CONVERT(varchar(10),Ntst.vac_date,111) >= '''+@month+'''+''/01''  
 AND CONVERT(varchar(10),Ntst.vac_date,111) < DATEADD(month,1,CONVERT(datetime,'''+@month+'''+''/01'')) 
group by Ntst.emp_cd 
) N ON A.emp_cd = N.emp_cd   

LEFT JOIN 
(select Otst.emp_cd,COUNT(Otst.vac_date) as vac_date  
from  
t_vac_record_list Otst  
where Otst.vac_class = ''13-09''  
 AND CONVERT(varchar(10),Otst.vac_date,111) >= '''+@month+'''+''/01''  
 AND CONVERT(varchar(10),Otst.vac_date,111) < DATEADD(month,1,CONVERT(datetime,'''+@month+'''+''/01''))  
group by Otst.emp_cd  
) O ON A.emp_cd = O.emp_cd  

LEFT JOIN 
(select Ptst.emp_cd,COUNT(Ptst.vac_date) as vac_date  
from  
t_vac_record_list Ptst  
where Ptst.vac_class = ''13-02'' 
 AND CONVERT(varchar(10),Ptst.vac_date,111) >= '''+@month+'''+''/01'' 
 AND CONVERT(varchar(10),Ptst.vac_date,111) < DATEADD(month,1,CONVERT(datetime,'''+@month+'''+''/01''))  
group by Ptst.emp_cd  
) P ON A.emp_cd = P.emp_cd   

LEFT JOIN 
(select T5tst.emp_cd,COUNT(T5tst.late_time) as late_time  
from 
	(SELECT CONVERT(varchar(10),S.attendance_date,111) AS attendance_date,S.late_time,S.emp_cd  
	FROM t_chk_attendance_temp S  
	LEFT JOIN tb_calendar D ON SUBSTRING(CONVERT(varchar(10),S.attendance_date,111),1,4) = D.year   
	AND SUBSTRING(CONVERT(varchar(10),S.attendance_date,111),6,2) = D.month   
	AND SUBSTRING(CONVERT(varchar(10),S.attendance_date,111),9,2) = D.day   
	AND D.calendar_flag = ''平日'') T5tst  
where T5tst.late_time = ''1''  
	AND CONVERT(varchar(10),T5tst.attendance_date,111) >= '''+@month+'''+''/01''   
	AND CONVERT(varchar(10),T5tst.attendance_date,111) < DATEADD(month,1,CONVERT(datetime,'''+@month+'''+''/01''))  
group by T5tst.emp_cd
) T5 on A.emp_cd = T5.emp_cd    
' 
set @where='where A.job_class=''1'' '
if(@eid is not null and @eid<>'') 
	set @where=@where + ' and A.emp_cd='''+@eid + '''' 
if(@name is not null and @name<>'') 
	set @where=@where + ' and A.emp_name like '''+@name + '''' 
if(@deptid is not null and @deptid<>'') 
	set @where=@where + ' and substring(A.dept_cd,0,6)='''+ substring(@deptid,0,6) + '''' 
if(@pjid is not null and @pjid<>'') 
	set @where=@where + ' and A.pj_cd='''+ @pjid + '''  ' 
--set @where=@where+'group by A.emp_cd,A.emp_name,B.dept_name,A.emp_class' 
set @sql=@sql + @where 
execute(@sql) 

go

--74、根据员工编号获取员工详细信息（应用于DetailInfo.aspx页）
create proc GetEmpByemp_cdGroupD 
@emp_cd varchar(20)
as
SELECT A.birthday,A.id_card,A.nation,A.postalcode,A.linkman,A.phone,A.address, A.emp_cd,I.fun_name,H.fun_name as diploma, case A.sex when '1' then '男' else '女' end as sex,A.emp_name,B.dept_name,C.duty_name,D.dept_name AS pj_name,A.email,A.emp_memo,A.dorm,A.bed,A.timecard,A.emp_class,A.join_date,A.forward_work_year,j.fun_name,A.homeplace,
 CASE A.emp_class WHEN '0' THEN '试用期' WHEN '1' THEN '正式' END AS emp_class
 ,E.fun_name AS contract_cd,CASE A.marry WHEN '0' THEN '未婚' WHEN '1' THEN '已婚' END AS marry
 ,CASE WHEN G.fun_name IS NULL THEN '正常'ELSE G.fun_name END AS State
FROM tb_emp A
LEFT JOIN tb_dept B ON substring(A.dept_cd,0,6) = B.dept_cd 
LEFT JOIN t_duty_record C ON A.emp_cd = C.emp_cd AND C.flag='1'
LEFT JOIN tb_dept D ON A.pj_cd = D.dept_cd 
LEFT JOIN tb_com_fun E ON E.combine_cd = A.contract_class
LEFT JOIN t_vac_record_list F ON F.emp_cd = A.emp_cd AND dbo.sysdate() = F.vac_date
LEFT JOIN Tb_com_Fun G ON F.vac_Class = G.Combine_cd 
LEFT JOIN Tb_com_Fun H ON A.diploma=H.combine_cd 
LEFT JOIN Tb_com_Fun I ON A.contract_class=I.combine_cd 
left join tb_com_fun J on A.Diploma=j.combine_cd
WHERE A.job_class=1 and A.emp_cd=@emp_cd

go


--E 组
--75、获取熟练度
create proc procficiency_get
@pjcd varchar(20)
as
select * from tb_proficiency_set where pj_cd=@pjcd

go

--76、获得管理上级名称
create proc GetDeptPjBydeptcd
@dept_cd varchar(20)
as
select d1.dept_cd,d1.dept_name,d2.dept_name dept_name2 from tb_dept d1 left join tb_dept d2 on d1.parent_dept_cd=d2.dept_cd
where d1.dept_cd=@dept_cd

GO

--77、获取职务信息
create proc duty_get
as
select * from tb_duty

go

--78、按职务查职务
create proc GetDutyBydutycd
@duty_cd varchar(20)
as
select * from tb_duty where duty_cd=@duty_cd

go

--79、按部门Cd
create   proc GetdeptByDeptcd
@dept_cd varchar(20)
as
select d1.dept_cd,d1.dept_name,d1.dept_class,d2.dept_cd dept_cd2,d1.manager from tb_dept d1 left join tb_dept d2 on d1.parent_dept_cd=d2.dept_cd where d1.dept_cd=@dept_cd

go

--80、获得部门名称
create  proc Getdeptname
as
select dept_cd,dept_name from tb_dept  where dept_class='0'

go

--81、组合查询部门信息
create proc GetDepts
@eid varchar(20)=null,
@name varchar(20)=null,
@deptid varchar(20)=null,
@pjid varchar(20)=null
as
declare @sql varchar(2000),@where varchar(1000)
set @sql = 'select d1.dept_cd,d1.dept_name,d2.dept_name dept_name2,dept_class=case d1.dept_class when ''0'' then ''部门'' when ''3'' then ''工程'' else null end from tb_dept d1 left join tb_dept d2 on d1.parent_dept_cd=d2.dept_cd '
set @where='where 1=1'
if(@eid is not null and @eid<>'')
	set @where=@where + ' and d1.dept_cd='''+@eid + ''''
if(@name is not null and @name<>'')
	set @where=@where + ' and d1.dept_name like '''+@name + ''''
if(@deptid is not null and @deptid<>'')
	set @where=@where + ' and d1.dept_class='''+ @deptid + ''''
if(@pjid is not null and @pjid<>'')
	set @where=@where + ' and d1.parent_dept_cd='''+ @pjid + ''''
set @sql=@sql + @where
execute(@sql)

go

--82、或得上级部门名称
create proc getparent_dept_name
as
select dept_cd,dept_name from tb_dept where dept_class=0

go

--83、或得工作时间
create  proc tb_worktime_get
as
select * from tb_worktime

go

--84、获得指定年、月的日历信息
create proc p_tb_calendar_get
@year int,
@month int
as
select [day],calendar_flag flag,calendar_memo memo
from tb_calendar
where [year]=@year and [month]=@month

go

--85、获取指定日期的信息
create proc p_tb_calendar_getday
@year int,
@month int,
@day int
as
select calendar_flag flag,calendar_memo memo
from tb_calendar
where [year]=@year and [month]=@month and [day]=@day

go

--86、职务更新
create proc duty_update
@old_duty_cd      varchar(20),     -- 旧的职务CD
@duty_cd          varchar(20),     -- 职务CD
@duty_name        varchar(20),     -- 职务名称
@chkflg  	  int  output       --0:success 1:fail 2:数据已存在
AS      
declare @flag_temp  varchar(2)
SET NOCOUNT ON
begin transaction  
select @flag_temp=count(*) from tb_duty where duty_cd=@duty_cd 
if @flag_temp<>0 and @old_duty_cd<>@duty_cd
begin
	set @chkflg = 2
end     
	else if @flag_temp=0 or (@flag_temp<>0 and @old_duty_cd=@duty_cd)
begin                 
	UPDATE tb_duty SET 
		duty_cd = @duty_cd,
		duty_name = @duty_name
	WHERE duty_cd = @old_duty_cd
	set @chkflg = 0
end
	if @@error <>0 
		begin
			rollback transaction
			set @chkflg = 1
			return
		end	                        
	commit transaction	
	SET NOCOUNT OFF

GO

--87、部门添加
create proc dept_insert
@dept_cd          varchar(20),     -- 员工CD
@dept_name        varchar(20),     -- 员工姓名
@parent_dept_cd   varchar(20),     -- 管理部门
@dept_class       varchar(1),      -- 管理区分
@manager          varchar(20),      -- 管理担当
@chkflg  	  int  output       --0:success 1:fail 2:数据已存在
AS    
declare @flag_temp  varchar(2)  
SET NOCOUNT ON
begin transaction 
select @flag_temp=count(*) from tb_dept where dept_cd=@dept_cd 
if @flag_temp<>0
begin
	set @chkflg = 2
end     
	else if @flag_temp=0
begin                  
	INSERT INTO tb_dept (dept_cd,dept_name,parent_dept_cd,dept_class,manager) VALUES (@dept_cd,@dept_name,@parent_dept_cd,@dept_class,@manager)
	set @chkflg = 0
end
	if @@error <>0 
		begin
			rollback transaction
			set @chkflg = 1
			return
		end	                        
	commit transaction	
	SET NOCOUNT OFF

GO

--88、部门更新
create proc dept_update
@old_dept_cd      varchar(20),     -- 旧的部门CD
@dept_cd          varchar(20),     -- 员工CD
@dept_name        varchar(20),     -- 员工姓名
@parent_dept_cd   varchar(20),     -- 管理部门
@dept_class       varchar(1),      -- 管理区分
@manager          varchar(20),      -- 管理区分
@chkflg  	  int  output       --0:success 1:fail 2:数据已存在
AS     
declare @flag_temp  varchar(2) 
SET NOCOUNT ON
begin transaction 
select @flag_temp=count(*) from tb_dept where dept_cd=@dept_cd 
if @flag_temp<>0 and @dept_cd<>@old_dept_cd
begin
	set @chkflg = 2
end     
	else if @flag_temp=0 or (@flag_temp<>0 and @dept_cd=@old_dept_cd)
begin                  
	UPDATE tb_dept SET 
		dept_cd = @dept_cd,
		dept_name = @dept_name,
		parent_dept_cd = @parent_dept_cd,
		dept_class = @dept_class,
		manager = @manager
	WHERE dept_cd = @old_dept_cd
	set @chkflg = 0
end
	if @@error <>0 
		begin
			rollback transaction
			set @chkflg = 1
			return
		end	                        
	commit transaction	
	SET NOCOUNT OFF

GO

--89、补录考勤信息
CREATE PROCEDURE p_t_chk_attendance_insert
	@emp_cd          	varchar(20),     -- 员工编号
	@attendance_date   	varchar(20),	 -- 考勤日期/休假日期
	@card_time_start	datetime,	 -- 打卡开始时间
	@card_time_end		datetime,	 -- 打卡结束时间
	@overtime		varchar(4),	 -- 加班时间
	@late_time		varchar(1),	 -- 迟到区分
	@vac_class		varchar(5),	 -- 休假区分
	@vac_time		varchar(5),	 -- 休假时数
	@chkflg                 int  output              --0:success 1:fail

AS      

declare @off_dutyTemp varchar(20)	-- 下班时间
declare @minuteTemp int			-- 加班时间(以分钟为单位)
declare @minuteTemp_two int	
declare @computeMinuteTemp decimal(5,1)

	SET NOCOUNT ON
	begin transaction                   

	if @overtime is null or @overtime = ''
		set @overtime='0'

	-- 考勤数据输入情况下
	if (@card_time_start is not null and @card_time_start <> '') and 
	   (@card_time_end is not null and @card_time_end <> '')
	begin

		delete t_chk_attendance_temp where emp_cd=@emp_cd and attendance_date=@attendance_date
		INSERT INTO t_chk_attendance_temp (emp_cd,attendance_date,card_time_start,card_time_end,overtime,late_time) 
				values (@emp_cd,@attendance_date,@card_time_start,@card_time_end,@overtime,@late_time)

		update t_chk_record set record_sum=record_sum+1 
			where record_time=(select max(record_time) from t_chk_record where flag='成功')
	end

	-- 休假数据输入情况下
	 if @vac_class is not null and @vac_class <> ''
		and @vac_time is not null and @vac_time<> ''	
	begin
		delete t_vac_record_list where emp_cd=@emp_cd and vac_date=@attendance_date
		INSERT INTO t_vac_record_list (emp_cd,vac_class,vac_date,vac_time) 
				values (@emp_cd,@vac_class,@attendance_date,@vac_time)
		-- 如果休假区分为“年假”
		if @vac_class = '13-05'
		begin
			update tb_year_hols set total_day=(select totalDay from V_YEAR_HOLIDAY_COUNT where emp_cd=@emp_cd)
				,use_day=use_day+@vac_time
				where emp_cd=@emp_cd
		end
		update t_chk_record set record_sum=record_sum+1 
			where record_time=(select max(record_time) from t_chk_record where flag='成功')
	end
	

	if @@error <>0 
		begin
                        set @chkflg=1
			rollback transaction
			return
		end	
        set @chkflg=0                        
	commit transaction	
	SET NOCOUNT OFF

GO