using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Bus.Reportes.RRHH;
using Core.Erp.Info.RRHH;
using Core.Erp.Info.Reportes.RRHH;
using System.Collections.Generic;

namespace Core.Erp.Web.Reportes.RRHH
{
    public partial class ROL_022_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string usuario { get; set; }
        public string empresa { get; set; }

        public ROL_022_Rpt()
        {
            InitializeComponent();
        }

        private void ROL_022_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
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

                ROL_022_Bus bus_rpt = new ROL_022_Bus();
                List<ROL_022_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, IdNomina, IdNominaTipo, IdPeriodo, IdSucursal, IdDivision, IdArea, TipoRubro);
                this.DataSource = lst_rpt;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
