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
    public partial class CXC_004_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string usuario { get; set; }
        public string empresa { get; set; }
        public CXC_004_Rpt()
        {
            InitializeComponent();
        }

        private void CXC_004_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {

            lbl_fecha.Text = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
            lbl_empresa.Text = empresa;
            lbl_usuario.Text = usuario;

            int IdEmpresa = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            decimal IdCliente = string.IsNullOrEmpty(p_IdCliente.Value.ToString()) ? 0 : Convert.ToDecimal(p_IdCliente.Value);
            int IdContacto = p_IdContacto.Value == null ? 0 : Convert.ToInt32(p_IdContacto.Value);
            DateTime fecha_corte = string.IsNullOrEmpty(p_fecha_corte.Value.ToString()) ? DateTime.Now : Convert.ToDateTime(p_fecha_corte.Value);
            string Estado = string.IsNullOrEmpty(p_MostrarSaldo0.Value.ToString()) ? "" : ( Convert.ToBoolean(p_MostrarSaldo0.Value) ? "" : "PENDIENTE");
            CXC_004_Bus bus_rpt = new CXC_004_Bus();
            List<CXC_004_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, IdCliente, IdContacto, fecha_corte, Estado);
            this.DataSource = lst_rpt;
        }
    }
}
