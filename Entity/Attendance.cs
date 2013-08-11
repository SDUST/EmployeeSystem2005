using System;
using System.Collections.Generic;
using System.Text;

namespace Entity
{
    public class Attendance
    {
        string empCd;
        string block;
        DateTime attendanceDate;
        DateTime cardTimeStart;
        DateTime cardTimeEnd;
        decimal overTime;
        string lateTime;
        public string EmpCd
        {
            get { return empCd; }
            set { empCd = value; }
        }
        public string Block
        {
            get { return block; }
            set { block = value; }
        }
        public DateTime AttendanceDate
        {
            get { return attendanceDate; }
            set { attendanceDate = value; }
        }
        public DateTime CardTimeStart
        {
            get { return cardTimeStart; }
            set { cardTimeStart = value; }
        }
        public DateTime CardTimeEnd
        {
            get { return cardTimeEnd; }
            set { cardTimeEnd = value; }
        }
        public decimal OverTime
        {
            get { return overTime; }
            set { overTime = value; }
        }
        public string LateTime
        {
            get { return lateTime; }
            set { lateTime = value; }
        }
    }
}
