using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.RRHH
{
   public class ROL_001_Info
    {
        public decimal IdEmpleado { get; set; }
        public string Ruc { get; set; }
        public string Empleado { get; set; }
        public string IdRubro { get; set; }
        public string Tag { get; set; }
        public string DescRubroLargo { get; set; }
        public string DescNombreRubroCorto { get; set; }
        public int Orden { get; set; }
        public double Valor { get; set; }
        public string NominaLiqui { get; set; }
        public string Nomina { get; set; }
        public System.DateTime FechaIni { get; set; }
        public System.DateTime FechaFin { get; set; }
        public string EstadoPeriodo { get; set; }
        public string Departamento { get; set; }
        public int IdNominaTipo { get; set; }
        public int IdNominaTipoLiqui { get; set; }
        public int IdPeriodo { get; set; }
        public Nullable<bool> rub_visible_reporte { get; set; }
        public string Division { get; set; }
        public string Sucursal { get; set; }
        public string CentroCosto { get; set; }
        public Nullable<int> IdDivision { get; set; }
        public string IdCentroCosto { get; set; }
        public int IdEmpresa { get; set; }
        public string CodigoEmpleado { get; set; }
        public int IdDepartamento { get; set; }
        public Nullable<int> IdArea { get; set; }
        public string DescripcionArea { get; set; }
        public int secuencia { get; set; }
        public string RazonSocial { get; set; }
        public string NombreComercial { get; set; }
    }
}
