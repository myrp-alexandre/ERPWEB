using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Info.Reportes.CuentasPorPagar;
using Core.Erp.Bus.Reportes.CuentasPorPagar;
using System.Collections.Generic;

namespace Core.Erp.Web.Reportes.CuentasPorPagar
{
    public partial class CXP_009_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string usuario { get; set; }
        public string empresa { get; set; }
        List<CXP_009_resumen_Info> lst_resumen = new List<CXP_009_resumen_Info>();
        public CXP_009_Rpt()
        {
            InitializeComponent();
        }

        private void CXP_009_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            lbl_fecha.Text = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
            lbl_usuario.Text = usuario;
            lbl_empresa.Text = empresa;

            int IdEmpresa = string.IsNullOrEmpty(p_IdEmpresa.Value.ToString()) ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            DateTime Fecha_ini = string.IsNullOrEmpty(p_Fecha_ini.Value.ToString()) ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(p_Fecha_ini.Value).Date;
            DateTime Fecha_fin = string.IsNullOrEmpty(p_Fecha_fin.Value.ToString()) ? DateTime.Now.Date : Convert.ToDateTime(p_Fecha_fin.Value).Date;
            
            CXP_009_Bus bus_rpt = new CXP_009_Bus();
            List<CXP_009_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, Fecha_ini,Fecha_fin, ref lst_resumen);
            this.DataSource = lst_rpt;
        }

        private void xrSubreport1_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            ((XRSubreport)sender).ReportSource.DataSource = lst_resumen;
            ((XRSubreport)sender).ReportSource.FillDataSource();
        }
    }
}
