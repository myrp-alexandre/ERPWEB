//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Core.Erp.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class cxc_liquidacion_comisiones_det
    {
        public int IdEmpresa { get; set; }
        public decimal IdLiquidacion { get; set; }
        public int Secuencia { get; set; }
        public int IdVendedor { get; set; }
        public int fa_IdEmpresa { get; set; }
        public int fa_IdSucursal { get; set; }
        public int fa_IdBodega { get; set; }
        public decimal fa_IdCbteVta { get; set; }
        public double SubtotalFactura { get; set; }
        public double IvaFactura { get; set; }
        public double TotalFactura { get; set; }
        public double TotalCobrado { get; set; }
        public double BaseComision { get; set; }
        public double PorcentajeComision { get; set; }
        public double TotalAComisionar { get; set; }
        public double TotalComisionado { get; set; }
        public double TotalLiquidacion { get; set; }
        public bool NoComisiona { get; set; }
    
        public virtual cxc_liquidacion_comisiones cxc_liquidacion_comisiones { get; set; }
    }
}