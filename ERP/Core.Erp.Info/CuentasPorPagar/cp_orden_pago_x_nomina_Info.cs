using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.CuentasPorPagar
{
   public class cp_orden_pago_x_nomina_Info
    {
        public int IdEmpresa { get; set; }
        public int IdNominaTipo { get; set; }
        public int IdNominaTipoLiqui { get; set; }
        public int IdPeriodo { get; set; }
        public decimal IdEmpleado { get; set; }
        public string IdRubro { get; set; }
        public int IdEmpresa_op { get; set; }
        public decimal IdOrdenPago { get; set; }
        public string Observacion { get; set; }
    }
}
