using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Reportes.RRHH
{
    public class ROL_010_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdEmpleado { get; set; }
        public int IdTipoNomina { get; set; }
        public string pe_cedulaRuc { get; set; }
        public string Empleado { get; set; }
        public Nullable<System.DateTime> em_fecha_ingreso { get; set; }
        public Nullable<System.DateTime> em_fechaSalida { get; set; }
        public string ca_descripcion { get; set; }
        public string EstadoEmpleado { get; set; }
        public Nullable<int> IdDivision { get; set; }
        public Nullable<System.DateTime> em_fechaIngaRol { get; set; }
        public string antiguedad_string { get; set; }
    }
}
