using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Reportes.RRHH
{
    public class ROL_013_Info
    {
        public int IdDepartamento { get; set; }
        public decimal IdEmpleado { get; set; }
        public Nullable<int> pe_anio { get; set; }
        public System.DateTime pe_FechaIni { get; set; }
        public System.DateTime pe_FechaFin { get; set; }
        public string pe_cedulaRuc { get; set; }
        public string pe_apellido { get; set; }
        public string pe_nombre { get; set; }
        public string ru_descripcion { get; set; }
        public string de_descripcion { get; set; }
        public string Nomina { get; set; }
        public string ca_descripcion { get; set; }
        public Nullable<int> pe_mes { get; set; }
        public Nullable<System.DateTime> em_fechaSalida { get; set; }
        public Nullable<System.DateTime> em_fechaIngaRol { get; set; }
        public string Descripcion { get; set; }
        public double Valor { get; set; }
    }
}
