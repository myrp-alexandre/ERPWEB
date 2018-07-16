using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Bus.Reportes.Banco;
using Core.Erp.Info.Reportes.Banco;
using System.Collections.Generic;

namespace Core.Erp.Web.Reportes.Banco
{
    public partial class BAN_005_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public BAN_005_Rpt()
        {
            InitializeComponent();
        }

        private void BAN_005_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            int IdEmpresa = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            int IdTipocbte = p_IdTipocbte.Value == null ? 0 : Convert.ToInt32(p_IdTipocbte.Value);
            decimal IdCbteCble = p_IdCbteCble.Value == null ? 0 : Convert.ToDecimal(p_IdCbteCble.Value);

            BAN_005_Bus bus_rpt = new BAN_005_Bus();
            List<BAN_005_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, IdTipocbte, IdCbteCble);
            this.DataSource = lst_rpt;
        }
    }
}
