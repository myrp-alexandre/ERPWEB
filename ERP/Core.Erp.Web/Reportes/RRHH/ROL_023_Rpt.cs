using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Bus.General;
using Core.Erp.Info.Reportes.RRHH;
using System.Collections.Generic;
using Core.Erp.Bus.Reportes.RRHH;

namespace Core.Erp.Web.Reportes.RRHH
{
    public partial class ROL_023_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string usuario { get; set; }
        public string empresa { get; set; }
        public ROL_023_Rpt()
        {
            InitializeComponent();
        }

        private void ROL_023_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {

            lbl_fecha.Text = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
            lbl_empresa.Text = empresa;
            lbl_usuario.Text = usuario;

            int IdEmpresa = string.IsNullOrEmpty( p_IdEmpresa.Value.ToString())? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            int IdSucursal = string.IsNullOrEmpty(p_IdSucursal.Value.ToString()) ? 0 : Convert.ToInt32(p_IdSucursal.Value);
            int IdNomina = string.IsNullOrEmpty(p_IdNomina.Value.ToString()) ? 0 : Convert.ToInt32(p_IdNomina.Value);
            int IdNominaTipoLiqui = string.IsNullOrEmpty(p_IdNominaTipoLiqui.Value.ToString()) ? 0 : Convert.ToInt32(p_IdNominaTipoLiqui.Value);
            int IdPeriodo = string.IsNullOrEmpty(p_IdPeriodo.Value.ToString()) ? 0 : Convert.ToInt32(p_IdPeriodo.Value);
            int IdDivision = string.IsNullOrEmpty(p_IdDivision.Value.ToString()) ? 0 : Convert.ToInt32(p_IdDivision.Value);
            int IdArea = string.IsNullOrEmpty(p_IdArea.Value.ToString()) ? 0 : Convert.ToInt32(p_IdArea.Value);
            int IdDepartamento = string.IsNullOrEmpty(p_IdEmpresa.Value.ToString()) ? 0 : Convert.ToInt32(p_IdDepartamento.Value);


            ROL_023_Bus bus_rpt = new ROL_023_Bus();
            List<ROL_023_Info> lst_rpt = bus_rpt.GetList(IdEmpresa, IdSucursal, IdNomina, IdNominaTipoLiqui, IdPeriodo, IdDivision, IdArea, IdDepartamento);
            this.DataSource = lst_rpt;

            tb_empresa_Bus bus_empresa = new tb_empresa_Bus();
            var emp = bus_empresa.get_info(IdEmpresa);
            lbl_empresa.Text = emp.em_nombre;
            ImageConverter obj = new ImageConverter();
            lbl_imagen.Image = (Image)obj.ConvertFrom(emp.em_logo);
            
        }
    }
}
