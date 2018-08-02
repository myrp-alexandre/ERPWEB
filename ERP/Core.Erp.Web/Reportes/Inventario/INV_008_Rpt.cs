using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Bus.Reportes.Inventario;
using Core.Erp.Info.Reportes.Inventario;
using System.Collections.Generic;
using Core.Erp.Web.Areas.Reportes.Controllers;
using Core.Erp.Info.Inventario;

namespace Core.Erp.Web.Reportes.Inventario
{
    public partial class INV_008_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string usuario { get; set; }
        public string empresa { get; set; }
        public List<in_Producto_Info> lst_producto { get; set; }
        public INV_008_Rpt()
        {
            InitializeComponent();
        }

        private void INV_008_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            lbl_fecha.Text = DateTime.Now.ToString("d/MM/yyyy hh:mm:ss");
            lbl_usuario.Text = usuario;
            lbl_empresa.Text = empresa;

            int IdEmpresa = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            int IdSucursal = p_IdSucursal.Value == null ? 0 : Convert.ToInt32(p_IdSucursal.Value);
            int IdBodega = p_IdBodega.Value == null ? 0 : Convert.ToInt32(p_IdBodega.Value);
            bool mostrar_saldos_en_0 = p_mostrar_saldos_en_0.Value == null ? false : Convert.ToBoolean(p_mostrar_saldos_en_0.Value);
            

            INV_008_Bus bus_rpt = new INV_008_Bus();
            List<INV_008_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, IdSucursal, IdBodega, mostrar_saldos_en_0, lst_producto);
            this.DataSource = lst_rpt;
        }
    }
}