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
    public partial class CXC_006_sin_comision_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public CXC_006_sin_comision_Rpt()
        {
            InitializeComponent();
        }

        private void CXC_006_sin_comision_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {

            int IdEmpresa = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            decimal IdLiquidacion = p_IdLiquidacion.Value == null ? 0 : Convert.ToDecimal(p_IdLiquidacion.Value);

            CXC_006_sin_comision_Bus bus_rpt = new CXC_006_sin_comision_Bus();
            List<CXC_006_sin_comision_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, IdLiquidacion);
            this.DataSource = lst_rpt;
        }
    }
}
