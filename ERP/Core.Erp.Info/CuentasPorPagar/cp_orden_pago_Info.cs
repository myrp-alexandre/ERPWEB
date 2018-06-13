using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.CuentasPorPagar
{
   public class cp_orden_pago_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdOrdenPago { get; set; }
        public string Observacion { get; set; }
        public string IdTipo_op { get; set; }
        public string IdTipo_Persona { get; set; }
        public decimal IdPersona { get; set; }
        public Nullable<decimal> IdEntidad { get; set; }
        public System.DateTime Fecha { get; set; }
        public string IdEstadoAprobacion { get; set; }
        public string IdFormaPago { get; set; }
        public System.DateTime Fecha_Pago { get; set; }
        public Nullable<int> IdBanco { get; set; }
        public string Estado { get; set; }
        public string IdUsuario { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public string MotivoAnu { get; set; }
        public Nullable<System.DateTime> Fecha_UltAnu { get; set; }
        public string nom_pc { get; set; }
        public string ip { get; set; }
        public Nullable<decimal> IdTipoFlujo { get; set; }
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public Nullable<int> IdTipoMovi { get; set; }
        public double Valor_a_pagar { get; set; }
        public List<cp_orden_pago_det_Info> detalle { get; set; }

        public cp_orden_pago_Info()
        {
            detalle = new List<cp_orden_pago_det_Info>();
        }
    }
}
