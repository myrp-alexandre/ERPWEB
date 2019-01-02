using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Bus.Reportes.CuentasPorPagar;
using Core.Erp.Info.Reportes.CuentasPorPagar;
using System.Collections.Generic;

namespace Core.Erp.Web.Reportes.CuentasPorPagar
{
    public partial class CXP_011_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public CXP_011_Rpt()
        {
            InitializeComponent();
        }

        private void CXP_011_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {

            int IdEmpresa = string.IsNullOrEmpty(p_IdEmpresa.Value.ToString()) ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            decimal IdSolicitud = string.IsNullOrEmpty(p_IdSolicitud.Value.ToString()) ? 0 : Convert.ToDecimal(p_IdSolicitud.Value);

            CXP_011_Bus bus_rpt = new CXP_011_Bus();
            List<CXP_011_Info> lst_rpt = bus_rpt.GetList(IdEmpresa, IdSolicitud);
            this.DataSource = lst_rpt;
        }
    }
}
