using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Bus.Reportes.CuentasPorCobrar;
using Core.Erp.Info.Reportes.CuentasPorCobrar;
using System.Collections.Generic;

namespace Core.Erp.Web.Reportes.CuentasPorCobrar
{
    public partial class CXC_006_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string usuario { get; set; }
        public string empresa { get; set; }
        public CXC_006_Rpt()
        {
            InitializeComponent();
        }

        private void CXC_006_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            lbl_fecha.Text = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
            lbl_empresa.Text = empresa;
            lbl_usuario.Text = usuario;

            int IdEmpresa = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            decimal IdLiquidacion = p_IdLiquidacion.Value == null ? 0 : Convert.ToDecimal(p_IdLiquidacion.Value);

            CXC_006_Bus bus_rpt = new CXC_006_Bus();
            List<CXC_006_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, IdLiquidacion);
            this.DataSource = lst_rpt;
        }

        private void Subreporte_sin_comisiones_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            ((XRSubreport)sender).ReportSource.Parameters["p_IdEmpresa"].Value = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            ((XRSubreport)sender).ReportSource.Parameters["p_IdLiquidacion"].Value = p_IdLiquidacion.Value == null ? 0 : Convert.ToDecimal(p_IdLiquidacion.Value);
            ((XRSubreport)sender).ReportSource.RequestParameters = false;

        }
    }
}
