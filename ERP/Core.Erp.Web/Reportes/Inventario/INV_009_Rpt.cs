using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Bus.Reportes.Inventario;
using Core.Erp.Info.Reportes.Inventario;
using System.Collections.Generic;

namespace Core.Erp.Web.Reportes.Inventario
{ 
    public partial class INV_009_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string usuario { get; set; }
        public string empresa { get; set; }
        public INV_009_Rpt()
        {
            InitializeComponent();
        }

        private void INV_009_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {

            lbl_fecha.Text = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
            lbl_empresa.Text = empresa;
            lbl_usuario.Text = usuario;

            int IdEmpresa = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            int IdSucursal = p_IdSucursal.Value == null ? 0 : Convert.ToInt32(p_IdSucursal.Value);
            int IdBodega = p_IdBodega.Value == null ? 0 : Convert.ToInt32(p_IdBodega.Value);
            int IdMarca = p_IdMarca.Value == null ? 0 : Convert.ToInt32(p_IdMarca.Value);
            decimal IdProductoPadre = string.IsNullOrEmpty(p_IdProductoPadre.Value.ToString()) ? 0 : Convert.ToDecimal(p_IdProductoPadre.Value);
            DateTime fechaCorte = string.IsNullOrEmpty(p_fechaCorte.Value.ToString()) ? DateTime.Now : Convert.ToDateTime(p_fechaCorte.Value);

            INV_009_Bus bus_rpt = new INV_009_Bus();
            List<INV_009_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, IdSucursal, IdBodega, IdMarca, IdProductoPadre, fechaCorte);
            this.DataSource = lst_rpt;
        }
    }
}
