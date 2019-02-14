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
        List<ROL_023_Info> ListaAgrupadaResumen = new List<ROL_023_Info>();
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
            lst_rpt.ForEach(q => { q.FRESERVA_R = Math.Round(q.FRESERVA ?? 0, 2, MidpointRounding.AwayFromZero);
            q.IESS_R = Math.Round(q.IESS ?? 0, 2, MidpointRounding.AwayFromZero);
            });

            ListaAgrupada = (from q in lst_rpt
                             group q by new
                             {
                                 q.IdEmpresa,
                                 q.IdSucursal,
                                 q.IdPeriodo,
                                 q.IdNominaTipo,
                                 q.IdNominaTipoLiqui,                                 
                                 q.NombreDivision,
                                 q.IdArea,
                                 q.NombreArea,
                                 q.IdDepartamento,
                                 q.NombreDepartamento,
                                 q.IdEmpleado                           
                             } into Resumen
                             select new ROL_023_Info
                             {
                                 IdEmpresa = Resumen.Key.IdEmpresa,
                                 IdSucursal = Resumen.Key.IdSucursal,
                                 IdPeriodo = Resumen.Key.IdPeriodo,
                                 IdNominaTipo = Resumen.Key.IdNominaTipo,
                                 IdNominaTipoLiqui = Resumen.Key.IdNominaTipoLiqui,                                 
                                 NombreDivision = Resumen.Key.NombreDivision,
                                 IdArea = Resumen.Key.IdArea,
                                 NombreArea = Resumen.Key.NombreArea,
                                 IdDepartamento = Resumen.Key.IdDepartamento,
                                 NombreDepartamento = Resumen.Key.NombreDepartamento,
                                 IdEmpleado = Resumen.Key.IdEmpleado,
                                 TOTALI = Resumen.Sum(q => q.TOTALI),
                                 DECIMOT = Resumen.Sum(q => q.DECIMOT),
                                 DECIMOC = Resumen.Sum(q => q.DECIMOC),
                                 FRESERVA = Resumen.Sum(q => q.FRESERVA),
                                 SUELDO = Resumen.Sum(q => q.SUELDO+q.SOBRET+q.OTROING),
                                 SOBRET = Resumen.Sum(q => q.SOBRET),
                                 OTROING = Resumen.Sum(q => q.OTROING),

                                 TotalResumen = Resumen.Sum(q=> q.SUELDO+q.DECIMOT+q.DECIMOC+q.FRESERVA+q.SOBRET+q.OTROING)
                             }).ToList();

            
            ListaAgrupadaResumen = (from q in ListaAgrupada
                                    group q by new
                                 {
                                     q.IdEmpresa,
                                     q.IdSucursal,
                                     q.IdPeriodo,
                                     q.IdNominaTipo,
                                     q.IdNominaTipoLiqui,
                                     q.NombreDivision,
                                     q.IdArea,
                                     q.NombreArea,
                                     q.IdDepartamento,
                                     q.NombreDepartamento
                                    } into Resumen_Reporte
                                 select new ROL_023_Info
                                 {
                                     IdEmpresa = Resumen_Reporte.Key.IdEmpresa,
                                     IdSucursal = Resumen_Reporte.Key.IdSucursal,
                                     IdPeriodo = Resumen_Reporte.Key.IdPeriodo,
                                     IdNominaTipo = Resumen_Reporte.Key.IdNominaTipo,
                                     IdNominaTipoLiqui = Resumen_Reporte.Key.IdNominaTipoLiqui,
                                     NombreDivision = Resumen_Reporte.Key.NombreDivision,
                                     IdArea = Resumen_Reporte.Key.IdArea,
                                     NombreArea = Resumen_Reporte.Key.NombreArea,
                                     IdDepartamento = Resumen_Reporte.Key.IdDepartamento,
                                     NombreDepartamento = Resumen_Reporte.Key.NombreDepartamento,
                                     CantidadEmpleados = Resumen_Reporte.Count()
                                 }).ToList();

            foreach (var item in ListaAgrupadaResumen)
            {
                //item.CantidadEmpleados = ListaAgrupadaResumen.Where(q => q.IdDepartamento == item.IdDepartamento).FirstOrDefault().CantidadEmpleados;
                item.TOTALI = ListaAgrupada.Where(q => q.IdArea == item.IdArea && q.IdDepartamento == item.IdDepartamento).Sum(q=> q.TOTALI);
                item.DECIMOT = ListaAgrupada.Where(q => q.IdArea == item.IdArea && q.IdDepartamento == item.IdDepartamento).Sum(q => q.DECIMOT);
                item.DECIMOC = ListaAgrupada.Where(q => q.IdArea == item.IdArea && q.IdDepartamento == item.IdDepartamento).Sum(q => q.DECIMOC);
                item.FRESERVA = ListaAgrupada.Where(q => q.IdArea == item.IdArea && q.IdDepartamento == item.IdDepartamento).Sum(q => q.FRESERVA);
                item.SUELDO = ListaAgrupada.Where(q => q.IdArea == item.IdArea && q.IdDepartamento == item.IdDepartamento).Sum(q => q.SUELDO);
                item.SOBRET = ListaAgrupada.Where(q => q.IdArea == item.IdArea && q.IdDepartamento == item.IdDepartamento).Sum(q => q.SOBRET);
                item.OTROING = ListaAgrupada.Where(q => q.IdArea == item.IdArea && q.IdDepartamento == item.IdDepartamento).Sum(q => q.OTROING);
                item.TotalResumen = ListaAgrupada.Where(q => q.IdArea == item.IdArea && q.IdDepartamento == item.IdDepartamento).Sum(q => q.TotalResumen);
            }

            tb_empresa_Bus bus_empresa = new tb_empresa_Bus();
            var emp = bus_empresa.get_info(IdEmpresa);
            lbl_empresa.Text = emp.em_nombre;
            ImageConverter obj = new ImageConverter();
            lbl_imagen.Image = (Image)obj.ConvertFrom(emp.em_logo);
            
        }

        private void ROL_023_Resumen_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            var Resumen = ListaAgrupadaResumen;
            ((XRSubreport)sender).ReportSource.DataSource = Resumen;
        }
    }
}
