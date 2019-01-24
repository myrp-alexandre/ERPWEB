using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Reportes.RRHH
{
  public  class ROL_021_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdRol { get; set; }
        public Nullable<int> IdSucursal { get; set; }
        public int IdNominaTipo { get; set; }
        public int IdNominaTipoLiqui { get; set; }
        public int IdPeriodo { get; set; }
        public string IdRubro { get; set; }
        public int Orden { get; set; }
        public double Valor { get; set; }
        public Nullable<bool> rub_visible_reporte { get; set; }
        public string Observacion { get; set; }
        public string ru_descripcion { get; set; }
        public System.DateTime pe_FechaIni { get; set; }
        public System.DateTime pe_FechaFin { get; set; }
        public string ru_tipo { get; set; }
        public string rub_codigo { get; set; }
        public string ru_codRolGen { get; set; }
        public double NumHoras { get; set; }
        public double ValorHora { get; set; }
        public string ca_descripcion { get; set; }
        public string em_codigo { get; set; }
        public decimal IdEmpleado { get; set; }
        public string pe_cedulaRuc { get; set; }
        public string pe_nombreCompleto { get; set; }
        public string Rub_horas { get; set; }
        public Nullable<int> IdArea { get; set; }
        public Nullable<int> IdDivision { get; set; }
        public string Descripcion { get; set; }
        public string rub_grupo { get; set; }

    }
}
