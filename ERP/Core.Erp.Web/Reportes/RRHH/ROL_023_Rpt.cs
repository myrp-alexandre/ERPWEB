using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Bus.General;
using Core.Erp.Info.Reportes.RRHH;
using System.Collections.Generic;
using Core.Erp.Bus.Reportes.RRHH;
using System.Linq;

namespace Core.Erp.Web.Reportes.RRHH
{
    public partial class ROL_023_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        List<ROL_023_Info> ListaAgrupada = new List<ROL_023_Info>();
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

            ListaAgrupada = (from q in lst_rpt
                             group q by new
                             {
                                 q.IdEmpresa,
                                 q.IdSucursal,
                                 q.IdPeriodo,
                                 q.IdNominaTipo,
                                 q.IdNominaTipoLiqui,
                                 q.NombreDivision,
                                 q.NombreArea,
                                 q.NombreDepartamento
                             } into Resumen
                             select new ROL_023_Info
                             {
                                 IdEmpresa = Resumen.Key.IdEmpresa,
                                 IdSucursal = Resumen.Key.IdSucursal,
                                 IdPeriodo = Resumen.Key.IdPeriodo,
                                 IdNominaTipo = Resumen.Key.IdNominaTipo,
                                 IdNominaTipoLiqui = Resumen.Key.IdNominaTipoLiqui,
                                 NombreDivision = Resumen.Key.NombreDivision,
                                 NombreArea = Resumen.Key.NombreArea,
                                 NombreDepartamento = Resumen.Key.NombreDepartamento,                                 
                                 CantidadEmpleados = Resumen.Count(),
                                 TOTALI = Resumen.Sum(q => q.TOTALI),
                                 DECIMOT = Resumen.Sum(q => q.DECIMOT),
                                 DECIMOC = Resumen.Sum(q => q.DECIMOC),
                                 FRESERVA = Resumen.Sum(q => q.FRESERVA),
                                 SUELDO = Resumen.Sum(q => q.SUELDO),
                                 SOBRET = Resumen.Sum(q => q.SOBRET),
                                 OTROING = Resumen.Sum(q => q.OTROING),

                                 TotalResumen = Resumen.Sum(q=> q.SUELDO+q.DECIMOT+q.DECIMOC+q.FRESERVA+q.SOBRET+q.OTROING)
                             }).ToList();

            tb_empresa_Bus bus_empresa = new tb_empresa_Bus();
            var emp = bus_empresa.get_info(IdEmpresa);
            lbl_empresa.Text = emp.em_nombre;
            ImageConverter obj = new ImageConverter();
            lbl_imagen.Image = (Image)obj.ConvertFrom(emp.em_logo);
            
        }

        private void ROL_023_Resumen_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            var Resumen = ListaAgrupada;
            ((XRSubreport)sender).ReportSource.DataSource = Resumen;
        }
    }
}
