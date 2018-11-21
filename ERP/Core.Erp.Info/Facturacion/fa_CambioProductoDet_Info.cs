using System;

namespace Core.Erp.Info.Facturacion
{
    public class fa_CambioProductoDet_Info
    {
        public int IdEmpresa { get; set; }
        public int IdSucursal { get; set; }
        public int IdBodega { get; set; }
        public int IdCambio { get; set; }
        public int Secuencia { get; set; }
        public decimal IdCbteVta { get; set; }
        public int SecuenciaFact { get; set; }
        public decimal IdProductoFact { get; set; }
        public decimal IdProductoCambio { get; set; }
        public double Costo { get; set; }
        public double CantidadFact { get; set; }
        public double CantidadCambio { get; set; }
        public Nullable<decimal> IdDevolucion { get; set; }
        #region Campos que no existen en la tabla
        public string pr_descripcion { get; set; }
        #endregion

    }
}
