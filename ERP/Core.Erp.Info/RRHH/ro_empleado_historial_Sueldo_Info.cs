using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.RRHH
{
   public class ro_empleado_historial_Sueldo_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdEmpleado { get; set; }
        public int Secuencia { get; set; }
        public double SueldoAnterior { get; set; }
        public double SueldoActual { get; set; }
        public double PorIncrementoSueldo { get; set; }
        public double ValorIncrementoSueldo { get; set; }
        public string Motivo { get; set; }
        public System.DateTime Fecha { get; set; }
        public string idUsuario { get; set; }
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public string IdUsuarioUltModi { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string nom_pc { get; set; }
        public string ip { get; set; }
        public string de_descripcion { get; set; }
        public string ca_descripcion { get; set; }
        public string IdCentroCosto { get; set; }
    }
}
