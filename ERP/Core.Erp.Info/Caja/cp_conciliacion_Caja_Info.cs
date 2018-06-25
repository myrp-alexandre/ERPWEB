using System;
using System.ComponentModel.DataAnnotations;

namespace Core.Erp.Info.Caja
{
    public class cp_conciliacion_Caja_Info
    {
        public int IdEmpresa { get; set; }        
        public decimal IdConciliacion_Caja { get; set; }
        [Required(ErrorMessage ="El campo periodo es obligatorio")]
        public int IdPeriodo { get; set; }
        [Required(ErrorMessage = "El campo fecha inicio es obligatorio")]
        public Nullable<System.DateTime> Fecha_ini { get; set; }
        [Required(ErrorMessage = "El campo fecha fin es obligatorio")]
        public Nullable<System.DateTime> Fecha_fin { get; set; }
        [Required(ErrorMessage = "El campo fecha es obligatorio")]
        public System.DateTime Fecha { get; set; }
        [Required(ErrorMessage = "El campo caja es obligatorio")]
        public int IdCaja { get; set; }
        [Required(ErrorMessage = "El campo estado es obligatorio")]
        public string IdEstadoCierre { get; set; }
        [StringLength(20, ErrorMessage = "el campo observación debe tener máximo 1000 caracteres")]
        public string Observacion { get; set; }
        public Nullable<int> IdEmpresa_op { get; set; }
        public Nullable<decimal> IdOrdenPago_op { get; set; }
        [Required(ErrorMessage = "El campo cuenta contable es obligatorio")]
        public string IdCtaCble { get; set; }
        public double Saldo_cont_al_periodo { get; set; }
        public double Ingresos { get; set; }
        public double Total_Ing { get; set; }
        public double Total_fact_vale { get; set; }
        public double Total_fondo { get; set; }
        public double Dif_x_pagar_o_cobrar { get; set; }
        public Nullable<decimal> IdTipoFlujo { get; set; }
        public Nullable<int> IdEmpresa_mov_caj { get; set; }
        public Nullable<int> IdTipoCbte_mov_caj { get; set; }
        public Nullable<decimal> IdCbteCble_mov_caj { get; set; }
    }
}
