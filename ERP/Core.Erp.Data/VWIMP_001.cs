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
    
    public partial class VWIMP_001
    {
        public int IdEmpresa { get; set; }
        public decimal IdOrdenCompra_ext { get; set; }
        public decimal IdProveedor { get; set; }
        public System.DateTime oe_fecha { get; set; }
        public Nullable<System.DateTime> oe_fecha_llegada_est { get; set; }
        public Nullable<System.DateTime> oe_fecha_embarque_est { get; set; }
        public string oe_observacion { get; set; }
        public string NomMoneda { get; set; }
        public string pr_codigo { get; set; }
        public string pr_descripcion { get; set; }
        public double od_cantidad { get; set; }
        public double od_costo { get; set; }
        public double od_por_descuento { get; set; }
        public double od_descuento { get; set; }
        public double od_costo_final { get; set; }
        public double od_subtotal { get; set; }
        public string pe_nombreCompleto { get; set; }
        public string NomPais { get; set; }
        public string nom_presentacion { get; set; }
        public string NomVia { get; set; }
        public string NomFormaPago { get; set; }
        public string NomUnidad { get; set; }
        public string Descripcion_Ciudad { get; set; }
    }
}