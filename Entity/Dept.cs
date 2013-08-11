using System;
using System.Collections.Generic;
using System.Text;

namespace Entity
{
    public class Dept
    {
        string deptCd;
        string deptName;
        string deptClass;
        string parentDeptCd;
        string manager;

        string old_dept_cd;

        public string OldDeptCd
        {
            set { old_dept_cd = value; }
            get { return old_dept_cd; }
        }

        public string DeptCd
        {
            set { deptCd = value; }
            get { return deptCd; }
        }

        public string DeptName
        {
            set { deptName = value; }
            get { return deptName; }
        }

        public string DeptClass
        {
            set { deptClass = value; }
            get { return deptClass; }
        }

        public string ParentDeptCd
        {
            set { parentDeptCd = value; }
            get { return parentDeptCd; }
        }

        public string Manager
        {
            set { manager = value; }
            get { return manager; }
        }
    }
}
