using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.RRHH
{
  public  class ro_empleado_x_centro_costo_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdEmpleado { get; set; }
        public string IdCentroCosto { get; set; }
        public string IdCentroCosto_sub_centro_costo { get; set; }
        public System.DateTime FechaIngresa { get; set; }
        public string UsuarioIngresa { get; set; }
        public Nullable<System.DateTime> FechaModifica { get; set; }
        public string UsuarioModifica { get; set; }
    }
}
