//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Core.Erp.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class VWCXC_003
    {
        public int IdEmpresa { get; set; }
        public int IdSucursal { get; set; }
        public int IdBodega { get; set; }
        public decimal IdCbteVta { get; set; }
        public string vt_tipoDoc { get; set; }
        public string vt_NumFactura { get; set; }
        public string pe_nombreCompleto { get; set; }
        public decimal IdCliente { get; set; }
        public System.DateTime vt_fecha { get; set; }
        public Nullable<double> ValorRteFTE { get; set; }
        public Nullable<double> ValorRteIVA { get; set; }
        public Nullable<double> PorcentajeRetFTE { get; set; }
        public Nullable<double> PorcentajeRetIVA { get; set; }
        public Nullable<double> TotalRTE { get; set; }
        public Nullable<System.DateTime> cr_fecha { get; set; }
    }
}