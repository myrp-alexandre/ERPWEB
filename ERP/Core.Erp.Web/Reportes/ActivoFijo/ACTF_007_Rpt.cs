using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Bus.Reportes.ActivoFijo;
using Core.Erp.Info.Reportes.ActivoFijo;
using System.Collections.Generic;

namespace Core.Erp.Web.Reportes.ActivoFijo
{
    public partial class ACTF_007_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string empresa { get; set; }
        public ACTF_007_Rpt()
        {
            InitializeComponent();
        }

        private void ACTF_007_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            lbl_empresa.Text = empresa;
            lbl_fecha.Text = DateTime.Now.ToString("dd de MMMM del yyyy");
            int IdEmpresa = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            int IdActivoFijo = p_IdActivoFijo.Value == null ? 0 : Convert.ToInt32(p_IdActivoFijo.Value);

            ACTF_007_Bus bus_rpt = new ACTF_007_Bus();
            List<ACTF_007_Info> lst_rpt = bus_rpt.GetList(IdEmpresa, IdActivoFijo);
            this.DataSource = lst_rpt;
        }
    }
}
