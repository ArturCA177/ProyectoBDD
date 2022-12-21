using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data.SqlClient;

namespace ProyectoBDD
{
    class Conexion
    {
        public static SqlConnection conectaSQL()
        {
            SqlConnection cxn = new SqlConnection();
            cxn.ConnectionString =
              "Data Source=MSI;" +
              "Initial Catalog=AdventureWorks2019;" +
              "User id=sa;" +
              "Password=@Drackmaster_12;";
            return cxn;
        }

        public void desconectaSQL(SqlConnection cxn)
        {
            cxn.Close();
        }
    }
}
