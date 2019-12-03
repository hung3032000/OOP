using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLiCafe.DAO
{
    class AccountDAO
    {
        private static AccountDAO instance;

        public static AccountDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new AccountDAO();
                }
                return instance;
            }

            private set
            {
                instance = value;
            }
        }
        private AccountDAO() {}
        public bool Login(string userName, string passWorrd)
        {
            string query = " SELECT * FROM dbo.Account WHERE UserName = N'" + userName + "' AND PassWord = N'"+passWorrd+"' ";
            DataTable result = DataProvider.Instance.ExecuteQuery(query); 
            return result.Rows.Count >0;
        }
    }
}
