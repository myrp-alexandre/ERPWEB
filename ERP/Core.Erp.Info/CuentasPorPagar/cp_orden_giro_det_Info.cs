using System.ComponentModel.DataAnnotations;

namespace Core.Erp.Info.CuentasPorPagar
{
    public class cp_orden_giro_det_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdCbteCble_Ogiro { get; set; }
        public int IdTipoCbte_Ogiro { get; set; }
        public int Secuencia { get; set; }
        [Required(ErrorMessage = "El campo producto es obligatorio")]
        [Range(0.01,long.MaxValue, ErrorMessage = "El campo producto es obligatorio")]
        public decimal IdProducto { get; set; }
        [Required(ErrorMessage = "El campo producto es obligatorio")]
        public string IdUnidadMedida { get; set; }
        [Required(ErrorMessage = "El campo cantidad es obligatorio")]
        [Range(0.01, double.MaxValue, ErrorMessage = "El campo cantidad es obligatorio")]
        public double Cantidad { get; set; }
        [Required(ErrorMessage = "El campo costo unitario es obligatorio")]
        [Range(0.01, double.MaxValue, ErrorMessage = "El campo costo unitario es obligatorio")]
        public double CostoUni { get; set; }
        [Required(ErrorMessage = "El campo porcentaje de descuento es obligatorio")]
        public double PorDescuento { get; set; }
        public double DescuentoUni { get; set; }
        public double CostoUniFinal { get; set; }
        public double Subtotal { get; set; }
        [Required(ErrorMessage = "El campo impuesto es obligatorio")]
        public string IdCod_Impuesto_Iva { get; set; }
        public double PorIva { get; set; }
        public double ValorIva { get; set; }
        public double Total { get; set; }
        public string IdCtaCbleGasto { get; set; }
        #region Campos que no existen en la tabla
        public string pr_descripcion { get; set; }
        #endregion

    }
}
