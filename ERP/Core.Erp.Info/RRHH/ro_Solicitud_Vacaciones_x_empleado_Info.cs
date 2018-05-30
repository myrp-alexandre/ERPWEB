using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.RRHH
{
   public class ro_Solicitud_Vacaciones_x_empleado_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdEmpleado { get; set; }
        public int IdSolicitud { get; set; }
        public int IdVacacion { get; set; }
        public decimal IdEmpleado_aprue { get; set; }
        public Nullable<decimal> IdEmpleado_remp { get; set; }
        public string IdEstadoAprobacion { get; set; }
        public System.DateTime Fecha { get; set; }
        public int AnioServicio { get; set; }
        public int Dias_q_Corresponde { get; set; }
        public int Dias_a_disfrutar { get; set; }
        public int Dias_pendiente { get; set; }
        public System.DateTime Anio_Desde { get; set; }
        public System.DateTime Anio_Hasta { get; set; }
        public System.DateTime Fecha_Desde { get; set; }
        public System.DateTime Fecha_Hasta { get; set; }
        public System.DateTime Fecha_Retorno { get; set; }
        public string Observacion { get; set; }
        public string IdUsuario { get; set; }
        public string IdUsuario_Anu { get; set; }
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public string Estado { get; set; }
        public string MotivoAnulacion { get; set; }
        public string ip { get; set; }
        public string nom_pc { get; set; }
        public Nullable<bool> Gozadas_Pgadas { get; set; }
        public Nullable<bool> Canceladas { get; set; }
    }
}
