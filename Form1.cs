using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using System.Data.SqlClient;
using System.Runtime.InteropServices;

namespace ProyectoBDD
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        #region "Botones de Consulta"

        private void btnC1_Click(object sender, EventArgs e)
        {
            dataGridView1.DataSource = null;
            panel1.Visible = true;
            lblP1.Visible = true;
            lblP2.Visible = false;
            lblP3.Visible = false;
            txtP1.Visible= true;
            txtP2.Visible=false;
            txtP3.Visible=false;
            dtp1.Visible=false;
            dtp2.Visible=false;
            btnP.Visible=true;

            lblP1.Text = "ID de la Categoria";
            lblP2.Text = "";
            lblP3.Text = "";
            txtP1.Text = "";
            txtP2.Text = "";
            txtP3.Text = "";
            dtp1.Value = DateTime.Today;
            dtp2.Value = DateTime.Today;

            lblCV.Text ="1";

        }

        private void btnC2_Click(object sender, EventArgs e)
        {
            dataGridView1.DataSource = null;
            panel1.Visible = false;
            lblP1.Visible = false;
            lblP2.Visible = false;
            lblP3.Visible = false;
            txtP1.Visible = false;
            txtP2.Visible = false;
            txtP3.Visible = false;
            dtp1.Visible = false;
            dtp2.Visible = false;
            btnP.Visible = false;

            lblP1.Text = "";
            lblP2.Text = "";
            lblP3.Text = "";
            txtP1.Text = "";
            txtP2.Text = "";
            txtP3.Text = "";
            dtp1.Value = DateTime.Today;
            dtp2.Value = DateTime.Today;

            lblCV.Text = "2";

            using (SqlConnection conn = Conexion.conectaSQL())
            {
                conn.Open();

                SqlCommand comand = new SqlCommand("CB", conn);
                comand.CommandType = System.Data.CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(comand);
                DataTable dt = new DataTable();
                da.Fill(dt);
                dataGridView1.DataSource = dt;

                conn.Close();
            }
        }

        private void btnC3_Click(object sender, EventArgs e)
        {
            dataGridView1.DataSource = null;
            panel1.Visible = true;
            lblP1.Visible = true;
            lblP2.Visible = true;
            lblP3.Visible = false;
            txtP1.Visible = true;
            txtP2.Visible = true;
            txtP3.Visible = false;
            dtp1.Visible = false;
            dtp2.Visible = false;
            btnP.Visible = true;

            lblP1.Text = "ID de la Categoria";
            lblP2.Text = "ID de la Localidad";
            lblP3.Text = "";
            txtP1.Text = "";
            txtP2.Text = "";
            txtP3.Text = "";
            dtp1.Value = DateTime.Today;
            dtp2.Value = DateTime.Today;

            lblCV.Text = "3";
        }

        private void btnC4_Click(object sender, EventArgs e)
        {
            dataGridView1.DataSource = null;
            panel1.Visible = false;
            lblP1.Visible = false;
            lblP2.Visible = false;
            lblP3.Visible = false;
            txtP1.Visible = false;
            txtP2.Visible = false;
            txtP3.Visible = false;
            dtp1.Visible = false;
            dtp2.Visible = false;
            btnP.Visible = false;

            lblP1.Text = "";
            lblP2.Text = "";
            lblP3.Text = "";
            txtP1.Text = "";
            txtP2.Text = "";
            txtP3.Text = "";
            dtp1.Value = DateTime.Today;
            dtp2.Value = DateTime.Today;

            lblCV.Text = "4";

            using (SqlConnection conn = Conexion.conectaSQL())
            {
                conn.Open();

                SqlCommand comand = new SqlCommand("CD", conn);
                comand.CommandType = System.Data.CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(comand);
                DataTable dt = new DataTable();
                da.Fill(dt);
                dataGridView1.DataSource = dt;

                conn.Close();
            }
        }

        private void btnC5_Click(object sender, EventArgs e)
        {
            dataGridView1.DataSource = null;
            panel1.Visible = true;
            lblP1.Visible = true;
            lblP2.Visible = true;
            lblP3.Visible = true;
            txtP1.Visible = true;
            txtP2.Visible = true;
            txtP3.Visible = true;
            dtp1.Visible = false;
            dtp2.Visible = false;
            btnP.Visible = true;

            lblP1.Text = "ID del Producto";
            lblP2.Text = "ID de la Orden";
            lblP3.Text = "Cantidad";
            txtP1.Text = "";
            txtP2.Text = "";
            txtP3.Text = "";
            dtp1.Value = DateTime.Today;
            dtp2.Value = DateTime.Today;

            lblCV.Text = "5";
        }

        private void btnC6_Click(object sender, EventArgs e)
        {
            dataGridView1.DataSource = null;
            panel1.Visible = true;
            lblP1.Visible = true;
            lblP2.Visible = true;
            lblP3.Visible = false;
            txtP1.Visible = true;
            txtP2.Visible = true;
            txtP3.Visible = false;
            dtp1.Visible = false;
            dtp2.Visible = false;
            btnP.Visible = true;

            lblP1.Text = "Metodo de Envio";
            lblP2.Text = "ID de la Orden";
            lblP3.Text = "";
            txtP1.Text = "";
            txtP2.Text = "";
            txtP3.Text = "";
            dtp1.Value = DateTime.Today;
            dtp2.Value = DateTime.Today;

            lblCV.Text = "6";
        }

        private void btnC7_Click(object sender, EventArgs e)
        {
            dataGridView1.DataSource = null;
            panel1.Visible = true;
            lblP1.Visible = true;
            lblP2.Visible = true;
            lblP3.Visible = true;
            txtP1.Visible = true;
            txtP2.Visible = true;
            txtP3.Visible = true;
            dtp1.Visible = false;
            dtp2.Visible = false;
            btnP.Visible = true;

            lblP1.Text = "Nombre";
            lblP2.Text = "Apellido";
            lblP3.Text = "Correo";
            txtP1.Text = "";
            txtP2.Text = "";
            txtP3.Text = "";
            dtp1.Value = DateTime.Today;
            dtp2.Value = DateTime.Today;

            lblCV.Text = "7";
        }

        private void btnC8_Click(object sender, EventArgs e)
        {
            dataGridView1.DataSource = null;
            panel1.Visible = false;
            lblP1.Visible = false;
            lblP2.Visible = false;
            lblP3.Visible = false;
            txtP1.Visible = false;
            txtP2.Visible = false;
            txtP3.Visible = false;
            dtp1.Visible = false;
            dtp2.Visible = false;
            btnP.Visible = false;

            lblP1.Text = "";
            lblP2.Text = "";
            lblP3.Text = "";
            txtP1.Text = "";
            txtP2.Text = "";
            txtP3.Text = "";
            dtp1.Value = DateTime.Today;
            dtp2.Value = DateTime.Today;

            lblCV.Text = "8";

            using (SqlConnection conn = Conexion.conectaSQL())
            {
                conn.Open();

                SqlCommand comand = new SqlCommand("CH", conn);
                comand.CommandType = System.Data.CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(comand);
                DataTable dt = new DataTable();
                da.Fill(dt);
                dataGridView1.DataSource = dt;

                conn.Close();
            }
        }

        private void btnC9_Click(object sender, EventArgs e)
        {
            dataGridView1.DataSource = null;
            panel1.Visible = true;
            lblP1.Visible = true;
            lblP2.Visible = true;
            lblP3.Visible = false;
            txtP1.Visible = false;
            txtP2.Visible = false;
            txtP3.Visible = false;
            dtp1.Visible = true;
            dtp2.Visible = true;
            btnP.Visible = true;

            lblP1.Text = "Fecha de Entrada";
            lblP2.Text = "Fecha de Salida";
            lblP3.Text = "";
            txtP1.Text = "";
            txtP2.Text = "";
            txtP3.Text = "";
            dtp1.Value = DateTime.Today;
            dtp2.Value = DateTime.Today;

            lblCV.Text = "9";
        }

        private void btnC10_Click(object sender, EventArgs e)
        {
            dataGridView1.DataSource = null;
            panel1.Visible = true;
            lblP1.Visible = true;
            lblP2.Visible = true;
            lblP3.Visible = false;
            txtP1.Visible = false;
            txtP2.Visible = false;
            txtP3.Visible = false;
            dtp1.Visible = true;
            dtp2.Visible = true;
            btnP.Visible = true;

            lblP1.Text = "Fecha de Entrada";
            lblP2.Text = "Fecha de Salida";
            lblP3.Text = "";
            txtP1.Text = "";
            txtP2.Text = "";
            txtP3.Text = "";
            dtp1.Value = DateTime.Today;
            dtp2.Value = DateTime.Today;

            lblCV.Text = "10";
        }



        #endregion

        #region "Boton Submit"

        private void btnP_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = Conexion.conectaSQL()) {

                conn.Open();

                if (lblCV.Text == "1") { //Aqui consulta A

                    SqlCommand comand = new SqlCommand("CA", conn);
                    comand.CommandType = System.Data.CommandType.StoredProcedure;

                    comand.Parameters.AddWithValue("@idCategoria", txtP1.Text);

                    SqlDataAdapter da = new SqlDataAdapter(comand);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    dataGridView1.DataSource = dt;
                }
                else if (lblCV.Text == "2") { //Aqui consulta B //Arriba
                }
                else if (lblCV.Text == "3") { //Aqui consulta C
                    SqlCommand comand = new SqlCommand("CC", conn);
                    comand.CommandType = System.Data.CommandType.StoredProcedure;

                    comand.Parameters.AddWithValue("@idCategoria", txtP1.Text);
                    comand.Parameters.AddWithValue("@idLocation", txtP2.Text);

                    SqlDataAdapter da = new SqlDataAdapter(comand);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    dataGridView1.DataSource = dt;
                }
                else if (lblCV.Text == "4") { //Aqui consulta D //Arriba
                }
                else if (lblCV.Text == "5") { //Aqui consulta E
                    SqlCommand comand = new SqlCommand("CE", conn);
                    comand.CommandType = System.Data.CommandType.StoredProcedure;

                    comand.Parameters.AddWithValue("@idProducto", txtP1.Text);
                    comand.Parameters.AddWithValue("@idOrden", txtP2.Text);
                    comand.Parameters.AddWithValue("@cantidad", txtP3.Text);

                    SqlDataAdapter da = new SqlDataAdapter(comand);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    dataGridView1.DataSource = dt;
                }
                else if (lblCV.Text == "6") { //Aqui consulta F
                    SqlCommand comand = new SqlCommand("CF", conn);
                    comand.CommandType = System.Data.CommandType.StoredProcedure;

                    comand.Parameters.AddWithValue("@metodoEnvio", txtP1.Text);
                    comand.Parameters.AddWithValue("@idOrden", txtP2.Text);

                    SqlDataAdapter da = new SqlDataAdapter(comand);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    dataGridView1.DataSource = dt;
                }
                else if (lblCV.Text == "7") { //Aqui consulta G
                    SqlCommand comand = new SqlCommand("CG", conn);
                    comand.CommandType = System.Data.CommandType.StoredProcedure;

                    comand.Parameters.AddWithValue("@nombre", txtP1.Text);
                    comand.Parameters.AddWithValue("@apellido", txtP2.Text);
                    comand.Parameters.AddWithValue("@correo", txtP3.Text);

                    SqlDataAdapter da = new SqlDataAdapter(comand);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    dataGridView1.DataSource = dt;
                }
                else if (lblCV.Text == "8") { //Aqui consulta H //Arriba
                }
                else if (lblCV.Text == "9") { //Aqui consulta I
                    SqlCommand comand = new SqlCommand("CI", conn);
                    comand.CommandType = System.Data.CommandType.StoredProcedure;

                    comand.Parameters.AddWithValue("@fechaEntrada", dtp1.Value);
                    comand.Parameters.AddWithValue("@fechaSalida", dtp2.Value);

                    SqlDataAdapter da = new SqlDataAdapter(comand);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    dataGridView1.DataSource = dt;
                }
                else if (lblCV.Text == "10") { //Aqui consulta J
                    SqlCommand comand = new SqlCommand("CJ", conn);
                    comand.CommandType = System.Data.CommandType.StoredProcedure;

                    comand.Parameters.AddWithValue("@fechaEntrada", dtp1.Value);
                    comand.Parameters.AddWithValue("@fechaSalida", dtp2.Value);

                    SqlDataAdapter da = new SqlDataAdapter(comand);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    dataGridView1.DataSource = dt;
                }
                conn.Close();
            }

        }

        #endregion
    }
}