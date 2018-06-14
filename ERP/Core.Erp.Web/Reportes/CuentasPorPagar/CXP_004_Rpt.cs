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
    public partial class CXP_004_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string usuario { get; set; }
        public string empresa { get; set; }
        public CXP_004_Rpt()
        {
            InitializeComponent();
        }

        private void CXP_004_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            lbl_fecha.Text = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
            lbl_empresa.Text = empresa;
            lbl_usuario.Text = usuario;
            int IdEmpresa = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            int IdTipoCbte = p_IdTipoCbte.Value == null ? 0 : Convert.ToInt32(p_IdTipoCbte.Value);
            decimal IdCbteCble = p_IdCbteCble.Value == null ? 0 : Convert.ToDecimal(p_IdCbteCble.Value);

            CXP_004_Bus bus_rpt = new CXP_004_Bus();
            List<CXP_004_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, IdTipoCbte, IdCbteCble);
            this.DataSource = lst_rpt;
        }
    }
}
