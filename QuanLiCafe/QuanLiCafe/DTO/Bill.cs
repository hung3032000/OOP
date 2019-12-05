using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLiCafe.DTO
{
    class Bill
    {
        private DateTime? dateCheckIn;
        private DateTime? dateCheckOut;
        private int iD;
        private int status;
        public Bill(int id, DateTime? dateCheckin, DateTime? dateCheckout)
        {
            this.ID = id;
            this.Status = status;
            this.DateCheckIn = dateCheckin;
            this.DateCheckOut = dateCheckout;
        }
        public Bill(DataRow row)
        {
            this.ID = (int)row["id"];
            this.DateCheckIn = (DateTime?)row["dateCheckin"];

            var dateCheckOutTemp = row["dateCheckout"];

            if (dateCheckOutTemp.ToString() != "")
            {
                this.dateCheckOut = (DateTime?)dateCheckOutTemp;

            }
            this.Status = (int)row["status"];

        }
        public DateTime? DateCheckIn
        {
            get
            {
                return dateCheckIn;
            }

            set
            {
                dateCheckIn = value;
            }
        }

        public DateTime? DateCheckOut
        {
            get
            {
                return dateCheckOut;
            }

            set
            {
                dateCheckOut = value;
            }
        }

        public int ID
        {
            get
            {
                return iD;
            }

            set
            {
                iD = value;
            }
        }

        public int Status
        {
            get
            {
                return status;
            }

            set
            {
                status = value;
            }
        }
    }
}
