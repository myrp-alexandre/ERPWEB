using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Info.Reportes.RRHH;
using Core.Erp.Bus.Reportes.RRHH;
using System.Collections.Generic;
namespace Core.Erp.Web.Reportes.RRHH
{
    public partial class ROL_002_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public ROL_002_Rpt()
        {
            InitializeComponent();
        }

        private void ROL_002_Rpt_AfterPrint(object sender, EventArgs e)
        {
            try
            {
               
            }
            catch (Exception)
            {

                throw;
            }
        }

        private void ROL_002_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            try
            {
                lbl_empresa.Text = empresa.Value.ToString();
                int IdEmpresa = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
                int IdNomina = p_IdNomina.Value == null ? 0 : Convert.ToInt32(p_IdNomina.Value);
                int IdNominaTipo = p_IdNominaTipo.Value == null ? 0 : Convert.ToInt32(p_IdNominaTipo.Value);
                int IdPeriodo = p_IdPeriodo.Value == null ? 0 : Convert.ToInt32(p_IdPeriodo.Value);
                ROL_002_Bus bus_rpt = new ROL_002_Bus();
                List<ROL_002_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, IdNomina, IdNominaTipo, IdPeriodo);
                this.DataSource = lst_rpt;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
