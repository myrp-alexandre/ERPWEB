using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Info.RRHH
{
   public class ro_empleado_x_ro_tipoNomina_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdEmpleado { get; set; }
        public int IdTipoNomina { get; set; }
        public string observacion { get; set; }
    }
}
