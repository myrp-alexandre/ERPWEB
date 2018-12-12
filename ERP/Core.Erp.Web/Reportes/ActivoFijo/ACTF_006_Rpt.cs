﻿using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Bus.Reportes.ActivoFijo;
namespace Core.Erp.Web.Reportes.ActivoFijo
{
    public partial class ACTF_006_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public ACTF_006_Rpt()
        {
            InitializeComponent();
        }
        ACTF_006_Bus bus_rpt = new ACTF_006_Bus();

        private void ACTF_006_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            int IdEmpresa = string.IsNullOrEmpty(p_IdEmpresa.Value.ToString()) ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            decimal IdProducto = string.IsNullOrEmpty(IdActivoFijo.Value.ToString()) ? 0 : Convert.ToInt32(IdActivoFijo.Value);
            this.DataSource = bus_rpt.get_list(IdEmpresa, IdProducto);
        }
    }
}
