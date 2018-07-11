using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Reportes.RRHH
{
    public class ROL_014_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdEmpleado { get; set; }
        public int IdTipoNomina { get; set; }
        public int IdDepartamento { get; set; }
        public string de_descripcion { get; set; }
        public string pe_cedulaRuc { get; set; }
        public string pe_apellido { get; set; }
        public string pe_nombre { get; set; }
        public string Decimo_Cuarto { get; set; }
        public string Decimo_Tercero { get; set; }
        public string Fondos_Reservas { get; set; }
        public Nullable<int> IdDivision { get; set; }
    }
}
