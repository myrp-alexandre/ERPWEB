using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.RRHH
{
    public class ro_empleado_x_CuentaContable_Info
    {
        public decimal IdTransaccionSession { get; set; }
        public int IdEmpresa { get; set; }
        public decimal IdEmpleado { get; set; }
        public int Secuencia { get; set; }
        public string IdRubro { get; set; }
        public string IdCuentacon { get; set; }
        public string Observacion { get; set; }

        //campos que no existen en la tabka
        public string pc_Cuenta { get; set; }
        public string ru_descripcion { get; set; }
        public List<ro_empleado_x_CuentaContable_Info> lstdet { get; set; }
    }
}
