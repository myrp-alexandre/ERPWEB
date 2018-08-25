using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Bus.Reportes.Inventario;
using System.Collections.Generic;
using Core.Erp.Info.Reportes.Inventario;

namespace Core.Erp.Web.Reportes.Inventario
{
    public partial class INV_003_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string usuario { get; set; }
        public string empresa { get; set; }
        public INV_003_Rpt()
        {
            InitializeComponent();
        }

        private void INV_003_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            lbl_fecha.Text = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
            lbl_empresa.Text = empresa;
            lbl_usuario.Text = usuario;
            int IdEmpresa = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            int IdSucursal = p_IdSucursal.Value == null ? 0 : Convert.ToInt32(p_IdSucursal.Value);
            int IdBodega = p_IdBodega.Value == null ? 0 : Convert.ToInt32(p_IdBodega.Value);
            decimal IdProducto = string.IsNullOrEmpty(p_IdProducto.Value.ToString()) ? 0 : Convert.ToDecimal(p_IdProducto.Value);
            string IdCategoria = p_IdCategoria.Value == null ? "" : Convert.ToString(p_IdCategoria.Value);
            int IdLinea = p_IdLinea.Value == null ? 0 : Convert.ToInt32(p_IdLinea.Value);
            int IdGrupo = p_IdGrupo.Value == null ? 0 : Convert.ToInt32(p_IdGrupo.Value);
            int IdSubgrupo = p_IdSubgrupo.Value == null ? 0 : Convert.ToInt32(p_IdSubgrupo.Value);
            DateTime fecha_corte = p_fecha_corte.Value == null ? DateTime.Now : Convert.ToDateTime(p_fecha_corte.Value);
            bool mostrar_stock_0 = p_mostrar_stock_0.Value == null ? false : Convert.ToBoolean(p_mostrar_stock_0.Value);
            int IdMarca = string.IsNullOrEmpty(p_IdMarca.Value.ToString()) ? 0 : Convert.ToInt32(p_IdMarca.Value);
            INV_003_Bus bus_rpt = new INV_003_Bus();
            List<INV_003_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, IdSucursal, IdBodega, IdProducto, IdCategoria, IdLinea, IdGrupo, IdSubgrupo, fecha_corte, mostrar_stock_0, IdMarca);
            this.DataSource = lst_rpt;
        }
    }
}
