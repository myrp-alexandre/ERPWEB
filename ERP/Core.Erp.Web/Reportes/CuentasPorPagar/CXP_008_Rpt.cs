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
    public partial class CXP_008_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string usuario { get; set; }
        public string empresa { get; set; }
        public CXP_008_Rpt()
        {
            InitializeComponent();
        }

        private void CXP_008_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            lbl_fecha.Text = DateTime.Now.ToString("d/MM/yyyy hh:mm:ss");
            lbl_usuario.Text = usuario;
            lbl_empresa.Text = empresa;

            int IdEmpresa = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            decimal IdProveedor = p_IdProveedor.Value == null ? 0 : Convert.ToDecimal(p_IdProveedor.Value);
            DateTime fecha = p_fecha.Value == null ? DateTime.Now : Convert.ToDateTime(p_fecha.Value);
            bool no_mostrar_en_conciliacion = p_no_mostrar_en_conciliacion == null ? false : Convert.ToBoolean(p_no_mostrar_en_conciliacion.Value);
            bool no_mostrar_saldo_0 = p_no_mostrar_saldo_0 == null ? false : Convert.ToBoolean(p_no_mostrar_saldo_0.Value);

            CXP_008_Bus bus_rpt = new CXP_008_Bus();
            List<CXP_008_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, fecha, IdProveedor, no_mostrar_en_conciliacion, no_mostrar_saldo_0);
            this.DataSource = lst_rpt;
        }
    }
}
