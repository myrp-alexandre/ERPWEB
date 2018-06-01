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
    public partial class ACTF_004_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string usuario { get; set; }
        public string empresa { get; set; }
        public ACTF_004_Rpt()
        {
            InitializeComponent();
        }

        private void ACTF_004_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {

            lbl_fecha.Text = DateTime.Now.ToString("d/MM/yyyy hh:mm:ss");
            lbl_usuario.Text = usuario;
            lbl_empresa.Text = empresa;

            int IdEmpresa = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            DateTime fecha_corte = p_fecha_corte.Value == null ? DateTime.Now : Convert.ToDateTime(p_fecha_corte.Value);

            ACTF_004_Bus bus_rpt = new ACTF_004_Bus();
            List<ACTF_004_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, fecha_corte);
            this.DataSource = lst_rpt;

        }
    }
}
