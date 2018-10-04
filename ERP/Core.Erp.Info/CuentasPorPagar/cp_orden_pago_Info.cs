using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Contabilidad;
using System.ComponentModel.DataAnnotations;

namespace Core.Erp.Info.CuentasPorPagar
{
   public class cp_orden_pago_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdOrdenPago { get; set; }
        [Required(ErrorMessage = "El campo observación es obligatorio")]
        [StringLength(50, MinimumLength = 4, ErrorMessage = "La descripción debe tener mínimo 4 caracteres y máximo 500")]
        public string Observacion { get; set; }
        [Required(ErrorMessage = "El campo tipo de orden de pago es obligatorio")]
        public string IdTipo_op { get; set; }
        [Required(ErrorMessage = "El campo tipo de persona es obligatorio")]

        public string IdTipo_Persona { get; set; }
        public decimal IdPersona { get; set; }
        [Required(ErrorMessage = "El campo beneficiario es obligatorio")]

        public Nullable<decimal> IdEntidad { get; set; }
        public System.DateTime Fecha { get; set; }
        public string IdEstadoAprobacion { get; set; }
        [Required(ErrorMessage = "El campo forma de pago es obligatorio")]
        public string IdFormaPago { get; set; }
        public System.DateTime Fecha_Pago { get; set; }
        public Nullable<int> IdBanco { get; set; }
        public string Estado { get; set; }
        public bool EstadoBool { get; set; }
        public string IdUsuario { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public string MotivoAnu { get; set; }
        public Nullable<System.DateTime> Fecha_UltAnu { get; set; }
        public string nom_pc { get; set; }
        public string ip { get; set; }
        public Nullable<decimal> IdTipoFlujo { get; set; }
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public Nullable<int> IdTipoMovi { get; set; }
        [Required(ErrorMessage = "El campo monto a cancelar es obligatorio")]
        public double Valor_a_pagar { get; set; }
        public double Valor_estimado_a_pagar_OP { get; set; }
        public double Total_cancelado_OP { get; set; }
        public double Saldo_x_Pagar_OP { get; set; }
        public List<cp_orden_pago_det_Info> detalle { get; set; }
        public string Nom_Beneficiario { get; set; }
        public Nullable<double> Total_OP { get; set; }
        public bool check { get; set; }
        public ct_cbtecble_Info info_comprobante { get; set; }
        public bool seleccionado { get; set; }
        public decimal IdEmpleado { get; set; }

        public cp_orden_pago_Info()
        {
            detalle = new List<cp_orden_pago_det_Info>();
            info_comprobante = new ct_cbtecble_Info();
        }
    }
}
