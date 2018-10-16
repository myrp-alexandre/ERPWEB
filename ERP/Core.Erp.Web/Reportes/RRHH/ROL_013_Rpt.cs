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
    public partial class ROL_013_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string usuario { get; set; }
        public string empresa { get; set; }
        public ROL_013_Rpt()
        {
            InitializeComponent();
        }

        private void ROL_013_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {

            lbl_fecha.Text = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
            lbl_empresa.Text = empresa;
            lbl_usuario.Text = usuario;
            int IdEmpresa = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            int IdNomina = p_IdNomina.Value == null ? 0 : Convert.ToInt32(p_IdNomina.Value);
            decimal IdEmpleado = p_IdEmpleado.Value == null ? 0 : Convert.ToDecimal(p_IdEmpleado.Value);
            DateTime fecha_inicio = p_fecha_inicio.Value == null ? DateTime.Now : Convert.ToDateTime(p_fecha_inicio.Value);
            DateTime fecha_fin = p_fecha_fin.Value == null ? DateTime.Now : Convert.ToDateTime(p_fecha_fin.Value);

            ROL_013_Bus bus_rpt = new ROL_013_Bus();
            List<ROL_013_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, IdNomina, IdEmpleado, fecha_inicio, fecha_fin);
            this.DataSource = lst_rpt;
        }
    }
}
