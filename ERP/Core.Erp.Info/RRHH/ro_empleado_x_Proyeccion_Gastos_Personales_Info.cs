using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.RRHH
{
   public class ro_empleado_x_Proyeccion_Gastos_Personales_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdEmpleado { get; set; }
        public string IdTipoGasto { get; set; }
        public int AnioFiscal { get; set; }
        public double Valor { get; set; }
        public System.DateTime FechaIngresa { get; set; }
        public string UsuarioIngresa { get; set; }
        public Nullable<System.DateTime> FechaModifica { get; set; }
        public string UsuarioModifica { get; set; }
    }
}
