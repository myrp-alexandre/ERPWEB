using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Bus.Reportes.RRHH;
using Core.Erp.Info.Reportes.RRHH;
using System.Collections.Generic;
using Core.Erp.Bus.General;

namespace Core.Erp.Web.Reportes.RRHH
{
    public partial class ROL_010_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string usuario { get; set; }
        public string empresa { get; set; }
        public ROL_010_Rpt()
        {
            InitializeComponent();
        }

        private void ROL_010_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            lbl_fecha.Text = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
            lbl_empresa.Text = empresa;
            lbl_usuario.Text = usuario;
            int IdEmpresa = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            int IdSucursal = p_IdSucursal.Value == null ? 0 : Convert.ToInt32(p_IdSucursal.Value);
            int IdDivision = p_IdDivision.Value == null ? 0 : Convert.ToInt32(p_IdDivision.Value);
            int IdArea = p_IdArea.Value == null ? 0 : Convert.ToInt32(p_IdArea.Value);

            tb_empresa_Bus bus_empresa = new tb_empresa_Bus();
            var emp = bus_empresa.get_info(IdEmpresa);
            lbl_empresa.Text = emp.em_nombre;
            ImageConverter obj = new ImageConverter();
            lbl_imagen.Image = (Image)obj.ConvertFrom(emp.em_logo);

            ROL_010_Bus bus_rpt = new ROL_010_Bus();
            List<ROL_010_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, IdSucursal, IdDivision, IdArea);
            this.DataSource = lst_rpt;
        }
    }
}
