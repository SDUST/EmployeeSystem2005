using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using DataAccess;
using Entity;

namespace Business
{
    public class Attendances
    {
        public int AttendanceInsert(string empCd, string attendanceDate, DateTime cardTimeStart, DateTime cardTimeEnd, string overTime, string lateTime, string vacClass, string vacTime, out int chkFlg)
        {
            SqlParameter[] paras = new SqlParameter[]
            {
                new SqlParameter("@emp_cd",empCd),
                new SqlParameter("@attendance_date",attendanceDate),
                new SqlParameter("@card_time_start",cardTimeStart),
                new SqlParameter("@card_time_end",cardTimeEnd),
                new SqlParameter("@overtime",overTime),
                new SqlParameter("@late_time",lateTime),
                new SqlParameter("@vac_class",vacClass),
                new SqlParameter("@vac_time",vacTime),
                new SqlParameter("@chkflg",1)
            };
            paras[8].Direction = ParameterDirection.Output;
            int count = DataBaseAccess.ExecuteSql("p_t_chk_attendance_insert", CommandType.StoredProcedure, paras);
            chkFlg = Convert.ToInt32(paras[8].Value);
            return count;
        }

        public DataSet AttendancesSelect(DateTime attendanceDateBegin, DateTime attendanceDateEnd)
        {
            SqlParameter[] paras = new SqlParameter[2];

            paras[0] = new SqlParameter("@attendance_date_begin", attendanceDateBegin);

            paras[1] = new SqlParameter("@attendance_date_end", attendanceDateEnd);

            return DataBaseAccess.GetDataSet("p_attendances_select", "Attendances", CommandType.StoredProcedure, paras);
        }

        public DataSet AttendancesSelectMonthly(string empCd, string empName, string deptCd, string pjCd, DateTime attendanceDate)
        {
            SqlParameter[] paras = new SqlParameter[5];

            paras[0] = new SqlParameter("@empCd", empCd);
            paras[1] = new SqlParameter("@empName", empName);
            paras[2] = new SqlParameter("@deptCd", deptCd);
            paras[3] = new SqlParameter("@pjCd", pjCd);

            if (attendanceDate == DateTime.MinValue)
                paras[4] = new SqlParameter("@attendanceDate", null);
            else
                paras[4] = new SqlParameter("@attendanceDate", attendanceDate);

            return DataBaseAccess.GetDataSet("GetAttendancesMonthly", "AttendancesMonthly", CommandType.StoredProcedure, paras);
        }

        public DataSet CheckRecordsSelect()
        {
            return DataBaseAccess.GetDataSet("Get_chk_record", "CheckRecords", CommandType.StoredProcedure);
        }

        public DataSet GetOvertimesDaily(string empCd, string empName, string deptCd, string pjCd, DateTime attendanceDate)
        {
            SqlParameter[] paras = new SqlParameter[5];

            paras[0] = new SqlParameter("@empCd", empCd);
            paras[1] = new SqlParameter("@empName", empName);
            paras[2] = new SqlParameter("@deptCd", deptCd);
            paras[3] = new SqlParameter("@pjCd", pjCd);

            if (attendanceDate == DateTime.MinValue)
                paras[4] = new SqlParameter("@attendanceDate", null);
            else
                paras[4] = new SqlParameter("@attendanceDate", attendanceDate);

            return DataBaseAccess.GetDataSet("GetOvertimesDaily", "OvertimesDaily", CommandType.StoredProcedure, paras);
        }

        public DataSet GetOvertimesMonthly(string empCd, string empName, string deptCd, string pjCd, DateTime attendanceDate, string empClass)
        {
            SqlParameter[] paras = new SqlParameter[6];

            paras[0] = new SqlParameter("@empCd", empCd);
            paras[1] = new SqlParameter("@empName", empName);
            paras[2] = new SqlParameter("@deptCd", deptCd);
            paras[3] = new SqlParameter("@pjCd", pjCd);

            if (attendanceDate == DateTime.MinValue)
                paras[4] = new SqlParameter("@attendanceDate", null);
            else
                paras[4] = new SqlParameter("@attendanceDate", attendanceDate);

            paras[5] = new SqlParameter("@empClass", empClass);

            return DataBaseAccess.GetDataSet("GetOvertimesMonthly", "OvertimesMonthly", CommandType.StoredProcedure, paras);
        }

        public DataSet GetOvertimesMonthlyTotal(string empCd, string empName, string deptCd, string pjCd, DateTime attendanceDate, string empClass)
        {
            SqlParameter[] paras = new SqlParameter[6];

            paras[0] = new SqlParameter("@empCd", empCd);
            paras[1] = new SqlParameter("@empName", empName);
            paras[2] = new SqlParameter("@deptCd", deptCd);
            paras[3] = new SqlParameter("@pjCd", pjCd);

            if (attendanceDate == DateTime.MinValue)
                paras[4] = new SqlParameter("@attendanceDate", null);
            else
                paras[4] = new SqlParameter("@attendanceDate", attendanceDate);

            paras[5] = new SqlParameter("@empClass", empClass);

            return DataBaseAccess.GetDataSet("GetOvertimesMonthlyTotal", "OvertimesMonthlyTotal", CommandType.StoredProcedure, paras);
        }

        public int ImportWorkAttendInfo(Attendance attendance, VacationRecord vacationRecord, YearHoliday yearHoliday, out int chkFlg)
        {
            SqlParameter[] paras = new SqlParameter[11];

            paras[0] = new SqlParameter("@empCd", attendance.EmpCd);
            paras[1] = new SqlParameter("@block", attendance.Block);
            paras[2] = new SqlParameter("@attendanceDate", attendance.AttendanceDate);
            if (attendance.CardTimeStart != DateTime.MinValue)
                paras[3] = new SqlParameter("@cardTimeStart", attendance.CardTimeStart);
            else
                paras[3] = new SqlParameter("@cardTimeStart", null);
            if (attendance.CardTimeEnd != DateTime.MinValue)
                paras[4] = new SqlParameter("@cardTimeEnd", attendance.CardTimeEnd);
            else
                paras[4] = new SqlParameter("@cardTimeEnd", null);
            paras[5] = new SqlParameter("@overtime", attendance.OverTime);
            paras[6] = new SqlParameter("@lateTime", attendance.LateTime);

            paras[7] = new SqlParameter("@vacClass", vacationRecord.VacClass);
            paras[8] = new SqlParameter("@vacTime", vacationRecord.VacTime);

            paras[9] = new SqlParameter("@usedDay", yearHoliday.UsedDay);

            paras[10] = new SqlParameter("@chkFlg", 1);
            paras[10].Direction = ParameterDirection.Output;

            int count = DataBaseAccess.ExecuteSql("ImportWorkAttendInfo", CommandType.StoredProcedure, paras);
            chkFlg = Convert.ToInt32(paras[10].Value);
            return count;
        }
        public int ImportWorkAttendInfo(string empCd, string block, DateTime attendanceDate, DateTime cardTimeStart, DateTime cardTimeEnd, decimal overtime, string lateTime, string vacClass, decimal vacTime, decimal usedDay, out int chkFlg)
        {
            Attendance attendance = new Attendance();
            attendance.EmpCd = empCd;
            attendance.AttendanceDate = attendanceDate;
            attendance.CardTimeStart = cardTimeStart;
            attendance.CardTimeEnd = cardTimeEnd;
            attendance.OverTime = overtime;
            attendance.LateTime = lateTime;

            VacationRecord vacationRecord = new VacationRecord();
            vacationRecord.EmpCd = empCd;
            vacationRecord.VacClass = vacClass;
            vacationRecord.VacTime = vacTime;

            YearHoliday yearHoliday = new YearHoliday();
            yearHoliday.UsedDay = usedDay;

            return this.ImportWorkAttendInfo(attendance, vacationRecord, yearHoliday, out chkFlg);
        }

        public int AddCheckRecord(DateTime recordTime, string recordSum, string flag)
        {
            SqlParameter[] paras = new SqlParameter[]
            {
                new SqlParameter("@recordTime",recordTime),
                new SqlParameter("@recordSum",recordSum),
                new SqlParameter("@flag",flag)
            };
            return DataBaseAccess.ExecuteSql("AddCheckRecord", CommandType.StoredProcedure, paras);
        }

        public int TheDayInsertedCheck(string empCd, DateTime attendanceDate, out int chkFlg)
        {
            string[] paraNames = new string[] { "@empCd", "@attendanceDate" };
            object[] paraValues = new object[] { empCd, attendanceDate };
            object chk;

            int ans = DataBaseAccess.ExecuteSql("TheDayInsertedCheck", CommandType.StoredProcedure, paraNames, paraValues, "@chkflg", out chk, SqlDbType.Int);
            chkFlg = (int)chk;
            return ans;
        }
    }
}
