using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Info.Reportes.Banco;
using System.Collections.Generic;
using Core.Erp.Bus.Reportes.Banco;

namespace Core.Erp.Web.Reportes.Banco
{
    public partial class BAN_009_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string usuario { get; set; }
        public string empresa { get; set; }
        public int[] IntArray { get; set; }
        public BAN_009_Rpt()
        {
            InitializeComponent();
        }

        private void BAN_009_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            lbl_fecha.Text = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
            lbl_usuario.Text = usuario;
            lbl_empresa.Text = empresa;

            int IdEmpresa = string.IsNullOrEmpty(p_IdEmpresa.Value.ToString()) ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            DateTime fecha_fin = string.IsNullOrEmpty(p_fecha_fin.Value.ToString()) ? DateTime.Now : Convert.ToDateTime(p_fecha_fin.Value);
            int IdBanco = string.IsNullOrEmpty(p_IdBanco.Value.ToString()) ? 0 : Convert.ToInt32(p_IdBanco.Value);

            BAN_009_Bus bus_rpt = new BAN_009_Bus();
             

            List<BAN_009_Info> lst_rpt = new List<BAN_009_Info>();
            if (IntArray != null)
            {
                foreach (var item in IntArray)
                {
                    lst_rpt.AddRange(bus_rpt.GetList(IdEmpresa, item, fecha_fin, !Convert.ToBoolean(p_mostrar_agrupado.Value)));
                }
            }           
             
            this.DataSource = lst_rpt;

        }

        private void GroupHeader2_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
        }

        private void GroupFooter2_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
        }

        private void GroupHeader1_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
        }

        private void GroupFooter1_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
        }
    }
}
