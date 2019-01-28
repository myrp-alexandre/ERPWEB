using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Info.Reportes.RRHH;
using Core.Erp.Bus.Reportes.RRHH;
using System.Collections.Generic;
using Core.Erp.Bus.General;
using System.Linq;
using Core.Erp.Info.RRHH;
using Core.Erp.Bus.RRHH;

namespace Core.Erp.Web.Reportes.RRHH
{
    public partial class ROL_002_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        List<ROL_002_Info> Lista_ingreso = new List<ROL_002_Info>();
        List<ROL_002_Info> Lista_egreso = new List<ROL_002_Info>();

        public string usuario { get; set; }
        public string empresa { get; set; }
        public ROL_002_Rpt()
        {
            InitializeComponent();
        }
        

        private void ROL_002_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
                lbl_fecha.Text = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
                lbl_empresa.Text = empresa;
                lbl_usuario.Text = usuario;
                ro_rubros_calculados_Info info_rubros_calculados = new ro_rubros_calculados_Info();
            ro_rubros_calculados_Bus bus_rubros_calculados = new ro_rubros_calculados_Bus();
            info_rubros_calculados = bus_rubros_calculados.get_info(Convert.ToInt32(Core.Erp.Web.Helps.SessionFixed.IdEmpresa));
            int IdEmpresa = p_IdEmpresa.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
                int IdNomina = p_IdNomina.Value == null ? 0 : Convert.ToInt32(p_IdNomina.Value);
                int IdNominaTipo = p_IdNominaTipo.Value == null ? 0 : Convert.ToInt32(p_IdNominaTipo.Value);
                int IdPeriodo = p_IdPeriodo.Value == null ? 0 : Convert.ToInt32(p_IdPeriodo.Value);
                int IdSucursal = p_IdSucursal.Value == null ? 0 : Convert.ToInt32(p_IdSucursal.Value);

                ROL_002_Bus bus_rpt = new ROL_002_Bus();
                List<ROL_002_Info> lst_rpt = bus_rpt.get_list(IdEmpresa, IdNomina, IdNominaTipo, IdPeriodo, IdSucursal);
                tb_empresa_Bus bus_empresa = new tb_empresa_Bus();
                var emp = bus_empresa.get_info(IdEmpresa);
                ImageConverter obj = new ImageConverter();
                lbl_imagen.Image = (Image)obj.ConvertFrom(emp.em_logo);

                Lista_ingreso = (from q in lst_rpt
                                 where q.Valor > 0
                                 group q by new
                                 {
                                     q.IdEmpresa,
                                     q.IdSucursal,
                                     q.IdPeriodo,
                                     q.IdNominaTipo,
                                     q.IdNominaTipoLiqui,
                                     q.RubroDescripcion,
                                     q.Valor
                                 } into ing
                                 select new ROL_002_Info
                                 {
                                     IdEmpresa = ing.Key.IdEmpresa,
                                     IdSucursal = ing.Key.IdSucursal,
                                     IdPeriodo = ing.Key.IdPeriodo,
                                     IdNominaTipo = ing.Key.IdNominaTipo,
                                     IdNominaTipoLiqui = ing.Key.IdNominaTipoLiqui,
                                     RubroDescripcion = ing.Key.RubroDescripcion,
                                     Valor = ing.Key.Valor

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
                                    q.RubroDescripcion,
                                    q.Valor

                                } into egr
                                select new ROL_002_Info
                                {
                                    IdEmpresa = egr.Key.IdEmpresa,
                                    IdSucursal = egr.Key.IdSucursal,
                                    IdPeriodo = egr.Key.IdPeriodo,
                                    IdNominaTipo = egr.Key.IdNominaTipo,
                                    IdNominaTipoLiqui = egr.Key.IdNominaTipoLiqui,
                                    RubroDescripcion = egr.Key.RubroDescripcion,
                                    Valor = egr.Key.Valor
                                }).ToList();
            lst_rpt = lst_rpt.Where(v => v.IdRubro == info_rubros_calculados.IdRubro_tot_pagar).ToList();
            this.DataSource = lst_rpt;
                    }
        private void Subreporte_Ingresos_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            ((XRSubreport)sender).ReportSource.DataSource = Lista_ingreso;
        }
        private void Subreporte_Egresos_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            ((XRSubreport)sender).ReportSource.DataSource = Lista_egreso;
        }
    }
}
