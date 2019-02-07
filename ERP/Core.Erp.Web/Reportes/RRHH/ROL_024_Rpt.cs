using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Bus.Reportes.RRHH;
using Core.Erp.Info.Reportes.RRHH;
using System.Collections.Generic;

namespace Core.Erp.Web.Reportes.RRHH
{
    public partial class ROL_024_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string empresa { get; set; }
        public string usuario { get; set; }
        public ROL_024_Rpt()
        {
            InitializeComponent();
        }

        private void ROL_024_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            lbl_fecha.Text = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
            lbl_empresa.Text = empresa;
            lbl_usuario.Text = usuario;

            int IdEmpresa = string.IsNullOrEmpty(p_IdEmpresa.Value.ToString()) ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            int IdSucursal = string.IsNullOrEmpty(p_IdSucursal.Value.ToString()) ? 0 : Convert.ToInt32(p_IdSucursal.Value);
            int IdNominaTipo = string.IsNullOrEmpty(p_IdNominaTipo.Value.ToString()) ? 0 : Convert.ToInt32(p_IdNominaTipo.Value);
            int IdNominaTipoLiqui = string.IsNullOrEmpty(p_IdNominaTipoLiqui.Value.ToString()) ? 0 : Convert.ToInt32(p_IdNominaTipoLiqui.Value);
            int IdPeriodo = string.IsNullOrEmpty(p_IdPeriodo.Value.ToString()) ? 0 : Convert.ToInt32(p_IdPeriodo.Value);

            ROL_024_Bus bus_rpt = new ROL_024_Bus();
            List<ROL_024_Info> lst_rpt = bus_rpt.GetList(IdEmpresa, IdSucursal, IdNominaTipo, IdNominaTipoLiqui, IdPeriodo);
            this.DataSource = lst_rpt;

        }
    }
}
