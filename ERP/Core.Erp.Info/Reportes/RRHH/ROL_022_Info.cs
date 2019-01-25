using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Reportes.RRHH
{
    public class ROL_022_Info
    {
        public int IdEmpresa { get; set; }
        public Nullable<int> IdDivision { get; set; }
        public Nullable<int> IdArea { get; set; }
        public decimal IdEmpleado { get; set; }
        public Nullable<int> IdJornada { get; set; }
        public int IdNomina_Tipo { get; set; }
        public int IdPeriodo { get; set; }
        public string Descripcion { get; set; }
        public string ru_descripcion { get; set; }
        public string empleado { get; set; }
        public string ca_descripcion { get; set; }
        public string ru_tipo { get; set; }
        public int ru_orden { get; set; }
        public Nullable<double> Valor { get; set; }
    }
}
