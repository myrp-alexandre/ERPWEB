using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Bus.Reportes.RRHH;
using Core.Erp.Info.Reportes.RRHH;
using System.Collections.Generic;
using System.Linq;
namespace Core.Erp.Web.Reportes.RRHH
{
    public partial class ROL_021_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public ROL_021_Rpt()
        {
            InitializeComponent();
        }

        public string usuario { get; set; }
        public string empresa { get; set; }        

        private void ROL_001_Rpt_AfterPrint(object sender, EventArgs e)
        {
            try
            {
                (sender as XtraReport).PrintingSystem.Document.AutoFitToPagesWidth = 1;
            }
            catch (Exception)
            {

                throw;
            }
        }

        private void ROL_021_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            try
            {
                //(sender as XtraReport).PrintingSystem.Document.AutoFitToPagesWidth = 1;

                lbl_fecha.Text = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
                lbl_empresa.Text = empresa;
                lbl_usuario.Text = usuario;

                int IdEmpresa = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
                int IdNomina = p_IdNomina.Value == null ? 0 : Convert.ToInt32(p_IdNomina.Value);
                int IdNominaTipo = p_IdNominaTipo.Value == null ? 0 : Convert.ToInt32(p_IdNominaTipo.Value);
                int IdPeriodo = p_IdPeriodo.Value == null ? 0 : Convert.ToInt32(p_IdPeriodo.Value);
                int IdSucursal = p_IdSucursal.Value == null ? 0 : Convert.ToInt32(p_IdSucursal.Value);
                int IdDivision = P_IdDivision.Value == null ? 0 : Convert.ToInt32(P_IdDivision.Value);
                int IdArea = P_IdArea.Value == null ? 0 : Convert.ToInt32(P_IdArea.Value);
                string TipoRubro = P_TipoRubro.Value == null ? "" : Convert.ToString(P_TipoRubro.Value);
                switch (TipoRubro)
                {
                    case "I":
                        lblNombreReporte.Text = "Reporte de rubros de ingresos";
                        xrPivotGrid1.OptionsView.ShowColumnTotals = true;
                        pivotGridField5.Visible = false;
                        break;
                    case "E":
                        lblNombreReporte.Text = "Reporte de rubros de descuento";
                        xrPivotGrid1.OptionsView.ShowColumnTotals = false;
                        pivotGridField5.Visible = false;
                        break;
                    case "A":
                        lblNombreReporte.Text = "Rol General";
                        xrPivotGrid1.OptionsView.ShowColumnTotals = false;
                        pivotGridField5.Visible = true;
                        break;
                    default:
                        lblNombreReporte.Text = "Rol General";
                        xrPivotGrid1.OptionsView.ShowColumnTotals = false;
                        pivotGridField5.Visible = true;
                        break;
                }
                ROL_021_Bus bus_rpt = new ROL_021_Bus();
                List<ROL_021_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, IdNomina, IdNominaTipo, IdPeriodo, IdSucursal, IdDivision, IdArea, TipoRubro);
                this.DataSource = lst_rpt;
            }
            catch (Exception)
            {

                throw;
            }
        }
        
    }
}
