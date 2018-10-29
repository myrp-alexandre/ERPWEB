using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Reportes.RRHH
{
    public class ROL_019_Info
    {
        public int IdEmpresa { get; set; }
        public int IdNominaTipo { get; set; }
        public int IdNominaTipoLiqui { get; set; }
        public int IdPeriodo { get; set; }
        public decimal IdEmpleado { get; set; }
        public string IdRubro { get; set; }
        public int Orden { get; set; }
        public double Valor { get; set; }
        public string Observacion { get; set; }
        public Nullable<int> pe_anio { get; set; }
        public Nullable<int> pe_mes { get; set; }
        public string Division { get; set; }
        public string Departamento { get; set; }
        public string Cargo { get; set; }
        public string Rubro { get; set; }
        public string NominaTipo { get; set; }
        public string Nomina { get; set; }
        public string Cedula { get; set; }
        public string Empleado { get; set; }
        public string ru_tipo { get; set; }
        public Nullable<System.DateTime> pe_FechaIni { get; set; }
        public Nullable<System.DateTime> pe_FechaFin { get; set; }
        public string ru_codRolGen { get; set; }

    }
}
