using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Info.Reportes.RRHH;
using System.Collections.Generic;
using Core.Erp.Bus.General;
using Core.Erp.Info.RRHH;
using Core.Erp.Bus.RRHH;
using Core.Erp.Bus.Reportes.RRHH;
using System.Linq;

namespace Core.Erp.Web.Reportes.RRHH
{
    public partial class ROL_002_RolPago : DevExpress.XtraReports.UI.XtraReport
    {
        List<ROL_002_Info> Lista_ingreso = new List<ROL_002_Info>();
        List<ROL_002_Info> Lista_egreso = new List<ROL_002_Info>();
        List<ROL_002_Info> Lista_Rpte = new List<ROL_002_Info>();

        public string usuario { get; set; }
        public string empresa { get; set; }
        public ROL_002_RolPago()
        {
            InitializeComponent();
        }

        private void ROL_002_RolPago_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            lbl_empresa.Text = empresa;
            ro_rubros_calculados_Info info_rubros_calculados = new ro_rubros_calculados_Info();
            ro_rubros_calculados_Bus bus_rubros_calculados = new ro_rubros_calculados_Bus();

            int IdEmpresa = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            int IdNomina = p_IdNomina.Value == null ? 0 : Convert.ToInt32(p_IdNomina.Value);
            int IdNominaTipo = p_IdNominaTipo.Value == null ? 0 : Convert.ToInt32(p_IdNominaTipo.Value);
            int IdPeriodo = p_IdPeriodo.Value == null ? 0 : Convert.ToInt32(p_IdPeriodo.Value);
            int IdSucursal = p_IdSucursal.Value == null ? 0 : Convert.ToInt32(p_IdSucursal.Value);

            info_rubros_calculados = bus_rubros_calculados.get_info(IdEmpresa);

            ROL_002_Bus bus_rpt = new ROL_002_Bus();
            List<ROL_002_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, IdNomina, IdNominaTipo, IdPeriodo, IdSucursal);
            tb_empresa_Bus bus_empresa = new tb_empresa_Bus();
            var emp = bus_empresa.get_info(IdEmpresa);
            ImageConverter obj = new ImageConverter();
            lbl_imagen.Image = (Image)obj.ConvertFrom(emp.em_logo);          

            Lista_Rpte = (from q in lst_rpt
                          group q by new
                          {
                              q.IdEmpresa,
                              q.IdSucursal,
                              q.IdPeriodo,
                              q.IdNominaTipo,
                              q.IdNominaTipoLiqui,
                              q.IdEmpleado,
                              q.NombreCompleto,
                              q.Area,
                              q.de_descripcion,
                              q.Cargo,
                              q.pe_FechaFin
                          }into rpte
                          select new ROL_002_Info
                          {
                              IdEmpresa = rpte.Key.IdEmpresa,
                              IdSucursal = rpte.Key.IdSucursal,
                              IdPeriodo = rpte.Key.IdPeriodo,
                              IdNominaTipo = rpte.Key.IdNominaTipo,
                              IdNominaTipoLiqui = rpte.Key.IdNominaTipoLiqui,
                              IdEmpleado = rpte.Key.IdEmpleado,
                              NombreCompleto = rpte.Key.NombreCompleto,
                              Area = rpte.Key.Area,
                              de_descripcion = rpte.Key.de_descripcion,
                              Cargo = rpte.Key.Cargo,
                              TotalPagar = rpte.Sum(q => q.Valor),
                              pe_FechaFin = rpte.Key.pe_FechaFin
                          }).ToList();

            Lista_ingreso = (from q in lst_rpt
                             where q.Valor > 0
                             group q by new
                             {
                                 q.IdEmpresa,
                                 q.IdSucursal,
                                 q.IdPeriodo,
                                 q.IdNominaTipo,
                                 q.IdNominaTipoLiqui,
                                 q.IdEmpleado,
                                 q.RubroDescripcion,
                                 q.Valor,
                                 q.Grupo
                             } into ing
                             select new ROL_002_Info
                             {
                                 IdEmpresa = ing.Key.IdEmpresa,
                                 IdSucursal = ing.Key.IdSucursal,
                                 IdPeriodo = ing.Key.IdPeriodo,
                                 IdNominaTipo = ing.Key.IdNominaTipo,
                                 IdNominaTipoLiqui = ing.Key.IdNominaTipoLiqui,
                                 IdEmpleado = ing.Key.IdEmpleado,
                                 RubroDescripcion = ing.Key.RubroDescripcion,
                                 Valor = ing.Key.Valor,
                                 Grupo = ing.Key.Grupo

                             }).ToList();

            Lista_egreso = (from q in lst_rpt
                            where q.Valor < 0
                            group q by new
                            {
                                q.IdEmpresa,
                                q.IdSucursal,
                                q.IdPeriodo,
                                q.IdNominaTipo,
                                q.IdNominaTipoLiqui,
                                q.IdEmpleado,
                                q.RubroDescripcion,
                                q.Valor,
                                q.Grupo

                            } into egr
                            select new ROL_002_Info
                            {
                                IdEmpresa = egr.Key.IdEmpresa,
                                IdSucursal = egr.Key.IdSucursal,
                                IdPeriodo = egr.Key.IdPeriodo,
                                IdNominaTipo = egr.Key.IdNominaTipo,
                                IdNominaTipoLiqui = egr.Key.IdNominaTipoLiqui,
                                IdEmpleado = egr.Key.IdEmpleado,
                                RubroDescripcion = egr.Key.RubroDescripcion,
                                Valor = (egr.Key.Valor) * -1,
                                Grupo = egr.Key.Grupo

                            }).ToList();

            this.DataSource = Lista_Rpte;
        }

        private void SubRpteIngresos_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            var ListaIngreso = Lista_ingreso.Where(q => q.IdEmpleado == Convert.ToDecimal(lbl_empleado.Text));
            ((XRSubreport)sender).ReportSource.DataSource = ListaIngreso;
        }

        private void SubRpte_Egresos_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            var ListaEgreso = Lista_egreso.Where(q => q.IdEmpleado == Convert.ToDecimal(lbl_empleado.Text));
            ((XRSubreport)sender).ReportSource.DataSource = ListaEgreso;
        }
    }
}
