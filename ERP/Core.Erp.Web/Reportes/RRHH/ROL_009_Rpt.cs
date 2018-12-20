using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Info.Reportes.RRHH;
using System.Collections.Generic;
using Core.Erp.Bus.Reportes.RRHH;

namespace Core.Erp.Web.Reportes.RRHH
{
    public partial class ROL_009_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string usuario { get; set; }
        public string empresa { get; set; }
        public ROL_009_Rpt()
        {
            InitializeComponent();
        }

        private void ROL_009_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            lbl_fecha.Text = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
            lbl_empresa.Text = empresa;
            lbl_usuario.Text = usuario;
            int IdEmpresa = string.IsNullOrEmpty(p_IdEmpresa.Value.ToString()) ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            DateTime fecha_inicio = string.IsNullOrEmpty(p_fecha_inicio.Value.ToString()) ? DateTime.Now : Convert.ToDateTime(p_fecha_inicio.Value);
            DateTime fecha_fin = string.IsNullOrEmpty(p_fecha_fin.Value.ToString()) ? DateTime.Now : Convert.ToDateTime(p_fecha_fin.Value);
            string estado_novedad = string.IsNullOrEmpty(p_estado_novedad.Value.ToString()) ? "" : Convert.ToString(p_estado_novedad.Value);
            string IdRubro = string.IsNullOrEmpty(p_IdRubro.Value.ToString()) ? "" : Convert.ToString(p_IdRubro.Value);
            decimal IdEmpleado = string.IsNullOrEmpty(p_IdEmpleado.Value.ToString()) ? 0 : Convert.ToInt32(p_IdEmpleado.Value);

            ROL_009_Bus bus_rpt = new ROL_009_Bus();
            List<ROL_009_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, fecha_inicio, fecha_fin,  estado_novedad, IdRubro, IdEmpleado);
            this.DataSource = lst_rpt;
        }
    }
}
