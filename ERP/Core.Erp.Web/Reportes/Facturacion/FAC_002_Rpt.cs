using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Bus.Reportes.Facturacion;
using Core.Erp.Info.Reportes.Facturacion;
using System.Collections.Generic;

namespace Core.Erp.Web.Reportes.Facturacion
{
    public partial class FAC_002_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string usuario { get; set; }
        public string empresa { get; set; }
        public FAC_002_Rpt()
        {
            InitializeComponent();
        }

        private void FAC_002_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            lbl_fecha.Text = DateTime.Now.ToString("d/MM/yyyy hh:mm:ss");
            lbl_usuario.Text = usuario;
            lbl_empresa.Text = empresa;

            int IdEmpresa = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            int IdSucursal = p_IdSucursal.Value == null ? 0 : Convert.ToInt32(p_IdSucursal.Value);
            decimal IdCliente = p_IdCliente.Value == null ? 0 : Convert.ToDecimal(p_IdCliente.Value);
            int IdClienteContacto = p_IdClienteContacto.Value == null ? 0 : Convert.ToInt32(p_IdClienteContacto.Value);
            DateTime fechaCorte = p_fechaCorte.Value == null ? DateTime.Now : Convert.ToDateTime(p_fechaCorte.Value);

            FAC_002_Bus bus_rpt = new FAC_002_Bus();
            List<FAC_002_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, IdSucursal, IdCliente, IdClienteContacto, fechaCorte);
            this.DataSource = lst_rpt;
        }
    }
}
