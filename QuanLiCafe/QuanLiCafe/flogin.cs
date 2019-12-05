using QuanLiCafe.DAO;
using QuanLiCafe.DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLiCafe
{
    public partial class flogin : Form
    {
        public flogin()
        {
            InitializeComponent();
        }

        private void dangnhap_Load(object sender, EventArgs e)
        {

        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void dangnhap_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (MessageBox.Show("Thoát chương trình?", "Thông Báo", MessageBoxButtons.OKCancel) != System.Windows.Forms.DialogResult.OK)
            {
                e.Cancel = true;
            }
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            string userName = txbuserName.Text;
            string passWord = txbpassWord.Text;
            if (Login(userName,passWord))
            {
                Account loginAccount = AccountDAO.Instance.GetAccountByUserName(userName);
                QLyQuanCf f = new QLyQuanCf(loginAccount);
                this.Hide();
                f.ShowDialog();
                this.Show();
            }
            else
            {
                MessageBox.Show("sai ten dang nhap hoac mat khau");
            }

        }
        bool Login(string userName, string passWord)
        {
            return AccountDAO.Instance.Login(userName, passWord);
        }
    }
}
