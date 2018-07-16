using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Bus.Reportes.Banco;
using System.Collections.Generic;
using Core.Erp.Info.Reportes.Banco;

namespace Core.Erp.Web.Reportes.Banco
{
    public partial class BAN_006_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public BAN_006_Rpt()
        {
            InitializeComponent();
        }

        private void BAN_006_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {

            int IdEmpresa = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            int IdTipoCbte = p_IdTipoCbte.Value == null ? 0 : Convert.ToInt32(p_IdTipoCbte.Value);
            decimal IdCbteCble = p_IdCbteCble.Value == null ? 0 : Convert.ToDecimal(p_IdCbteCble.Value);

            BAN_006_Bus bus_rpt = new BAN_006_Bus();
            List<BAN_006_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, IdTipoCbte, IdCbteCble);
            this.DataSource = lst_rpt;
        }
    }
}
