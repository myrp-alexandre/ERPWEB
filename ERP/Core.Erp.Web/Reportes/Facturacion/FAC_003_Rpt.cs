using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Bus.Reportes.Facturacion;
using Core.Erp.Info.Reportes.Facturacion;
using System.Collections.Generic;
using System.Linq;
using Core.Erp.Info.Helps;

namespace Core.Erp.Web.Reportes.Facturacion
{
    public partial class FAC_003_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        cl_funciones funciones = new cl_funciones();
        public FAC_003_Rpt()
        {
            InitializeComponent();
        }

        private void FAC_003_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {

            int IdEmpresa = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            int IdSucursal = p_IdSucursal.Value == null ? 0 : Convert.ToInt32(p_IdSucursal.Value);
            int IdBodega = p_IdBodega.Value == null ? 0 : Convert.ToInt32(p_IdBodega.Value);
            decimal IdCbteVta = p_IdCbteVta.Value == null ? 0 : Convert.ToDecimal(p_IdCbteVta.Value);
            bool mostrar_cuotas = p_mostrar_cuotas.Value == null ? false : Convert.ToBoolean(p_mostrar_cuotas.Value);

            FAC_003_Bus bus_rpt = new FAC_003_Bus();
            List<FAC_003_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, IdSucursal, IdBodega, IdCbteVta, mostrar_cuotas);
            if (lst_rpt.Count > 0)
            {
                lbl_valorenletras.Text = funciones.NumeroALetras(lst_rpt.Sum(q=>q.vt_total).ToString());
            }
            if (lst_rpt.Where(q => q.orden > 0).Count() > 0)
            {
                float Height = tbl_factura.Rows[1].HeightF;
                tbl_factura.Rows.Remove(tbl_factura.Rows[1]);
                tbl_factura.HeightF -= Height;
                Detail.HeightF = 16;
            }
            
            this.DataSource = lst_rpt;
        }

        private void xrTable4_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {

        }

        private void xrTable3_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {

        }

        private void xrTable1_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {

        }

        private void lbl_valorenletras_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {

        }

        private void xrTable2_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {

        }
    }
}
